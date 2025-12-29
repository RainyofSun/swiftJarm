//
//  CKContactAccessManager.h
//  NW
//
//  Created by 张文 on 2024/9/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>


NS_ASSUME_NONNULL_BEGIN

@interface YTContactAccessManager : NSObject
+ (instancetype)sharedManager;
- (void)requestAccessToContacts:(void (^)(BOOL granted))completion;
- (NSArray<CNContact *> *)fetchContacts;
- (void)checkContactAuthorizationStatus:(UIViewController *)viewController completion:(void (^)(NSDictionary *result))completion;
- (NSArray<NSDictionary *> *)fetchAllContacts;
@end

NS_ASSUME_NONNULL_END
