//
//  CKTrackingManager.h
//  NW
//
//  Created by 张文 on 2024/9/18.
//

#import <Foundation/Foundation.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>


NS_ASSUME_NONNULL_BEGIN

@interface CKTrackingManager : NSObject


+ (instancetype)sharedManager;
- (void)requestAuthorizationWithCompletion:(void (^)(BOOL success, NSDictionary *data))completion;


@end

NS_ASSUME_NONNULL_END
