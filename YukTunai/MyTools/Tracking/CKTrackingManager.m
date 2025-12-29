//
//  CKTrackingManager.m
//  NW
//
//  Created by 张文 on 2024/9/18.
//

#import "CKTrackingManager.h"
#import "YTIDFVKeychainHelper.h"

@implementation CKTrackingManager


+ (instancetype)sharedManager {
    static CKTrackingManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CKTrackingManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)requestAuthorizationWithCompletion:(void (^)(BOOL success, NSDictionary *data))completion {
    [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                NSString *idfv = [YTIDFVKeychainHelper retrieveIDFV];
                
                if (idfv) {
                    NSDictionary *data = @{@"pieces": idfv, @"held": idfa};
                    completion(YES, data);
                } else {
                    completion(YES, nil);
                }
            });
        } else {
            completion(NO, nil);
        }
    }];
}


@end
