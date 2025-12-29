//
//  CKContactAccessManager.m
//  NW
//
//  Created by 张文 on 2024/9/18.
//

#import "YTContactAccessManager.h"

@implementation YTContactAccessManager

+ (instancetype)sharedManager {
    static YTContactAccessManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YTContactAccessManager alloc] init];
    });
    return sharedInstance;
}

- (void)requestAccessToContacts:(void (^)(BOOL granted))completion {
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error requesting access to contacts: %@", error);
            completion(NO);
        } else {
            completion(granted);
        }
    }];
}

- (NSArray<CNContact *> *)fetchContacts {
    CNContactStore *store = [[CNContactStore alloc] init];
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    NSMutableArray<CNContact *> *contacts = [NSMutableArray array];
    
    NSError *error = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        CNContactStore *store = [[CNContactStore alloc] init];
        [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            [contacts addObject:contact];
        }];

    });
  
    if (error) {
        NSLog(@"Error fetching contacts: %@", error);
    }
    
    return [contacts copy];
}

- (void)checkContactAuthorizationStatus:(UIViewController *)viewController completion:(void (^)(NSDictionary *result))completion {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    switch (status) {
        case CNAuthorizationStatusNotDetermined: {
            [self requestAccessToContacts:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        NSArray *contacts = [self fetchContacts];
                        completion(@{ @"contacts": contacts });
                    } else {
                        if (viewController) {
                            [self showSettingsAlert:viewController];
                        }
                        completion(@{ @"error": @"Access Denied" });
                    }
                });
            }];
            break;
        }
        case CNAuthorizationStatusRestricted:
        case CNAuthorizationStatusDenied:
            if (viewController) {
                [self showSettingsAlert:viewController];
            }
            completion(@{ @"error": @"Access Denied" });
            break;
        case CNAuthorizationStatusAuthorized: {
            NSArray *contacts = [self fetchContacts];
            completion(@{ @"contacts": contacts });
            break;
        }
        default:
            break;
    }
}



- (void)showSettingsAlert:(UIViewController *)viewController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Contacts Access Denied"
                                                                             message:@"Please enable contacts access in Settings to provide better service."
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:appSettings]) {
            [[UIApplication sharedApplication] openURL:appSettings];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:settingsAction];
    [alertController addAction:cancelAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}


- (NSString *)getPhoneNumbersStringFromContact:(CNContact *)contact {
    NSMutableArray *phoneNumbersArray = [NSMutableArray array];
    
    for (CNLabeledValue<CNPhoneNumber *> *labeledValue in contact.phoneNumbers) {
        CNPhoneNumber *phoneNumber = labeledValue.value;
        NSString *phoneNumberString = phoneNumber.stringValue;
        [phoneNumbersArray addObject:phoneNumberString];
    }

    NSString *phoneNumbersString = [phoneNumbersArray componentsJoinedByString:@", "];
    
    return phoneNumbersString;
}

- (NSArray<NSDictionary *> *)fetchAllContacts {
    CNContactStore *store = [[CNContactStore alloc] init];
    
    NSMutableArray<CNKeyDescriptor> *keysToFetch = [NSMutableArray arrayWithArray:@[
        CNContactFamilyNameKey,
        CNContactGivenNameKey,
        CNContactNicknameKey,
        CNContactOrganizationNameKey,
        CNContactJobTitleKey,
        CNContactDepartmentNameKey,
        CNContactBirthdayKey,
        CNContactNonGregorianBirthdayKey,
        CNContactDatesKey,
        CNContactTypeKey,
        CNContactPhoneNumbersKey,
        CNContactEmailAddressesKey,
        CNContactPostalAddressesKey,
        CNContactInstantMessageAddressesKey,
        CNContactSocialProfilesKey,
        CNContactUrlAddressesKey,
    ]];
    
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    NSMutableArray<NSDictionary *> *contactArr = [NSMutableArray array];

    
    NSError *error = nil;
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        NSString *name = [NSString stringWithFormat:@"%@ %@", contact.givenName, contact.familyName];
        NSString *note = @"";
        NSString *dateStr = @"";
        
        if ([contact isKeyAvailable:CNContactNoteKey]) {
            note = contact.note;
        }
        
        for (CNLabeledValue *cnDate in contact.dates) {
            NSDate *date = (NSDate *)cnDate.value;
                if (date) {
                    NSString *label = [CNLabeledValue localizedStringForLabel:cnDate.label];
                    if (label.length > 0) {
                        dateStr = [NSString stringWithFormat:@"%lld", (long long)([date timeIntervalSince1970] * 1000)];
                    }
                }
        }
        
        
        
        NSString *phoneNumbers = [self getPhoneNumbersStringFromContact:contact];
        NSString *emailAddresses = [[contact.emailAddresses valueForKey:@"value"] componentsJoinedByString:@","];
        
        NSString *birthdayString = @"";
        if (contact.birthday) {
            NSDate *birthdayDate = [[NSCalendar currentCalendar] dateFromComponents:contact.birthday];
            if (birthdayDate) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"dd/MM/yyyy"];
                birthdayString = [formatter stringFromDate:birthdayDate];
            }
        }
        
        NSDictionary *contactDict = @{
            @"absurd": phoneNumbers.length > 0 ? phoneNumbers : @"",
            @"senior": @"",
            @"individuals": note.length > 0 ? note : @"",
            @"mythology": birthdayString.length > 0 ? birthdayString : @"",
            @"distinguished": emailAddresses.length > 0 ? emailAddresses : @"",
            @"sat": dateStr.length > 0 ? dateStr : @"",
            @"ensued": name.length > 0 ? name : @"",
        };
        
        [contactArr addObject:contactDict];
    }];
    
    if (error) {
        NSLog(@"error: %@", error);
    }

    return [contactArr copy];
}
@end
