

#import <Security/Security.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTIDFVKeychainHelper : NSObject
+ (void)storeIDFV:(NSString *)idfV;
+ (NSString *)retrieveIDFV;
@end

NS_ASSUME_NONNULL_END
