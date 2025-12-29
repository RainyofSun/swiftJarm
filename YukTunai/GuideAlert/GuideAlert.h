//
//  GuideAlert.h
//  PinjamN
//
//  Created by Yu Chen  on 2025/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    AlertType_Location,
    AlertType_Contacts,
    AlertType_Camera,
} AlertType;

@interface GuideAlert : NSObject

+ (void)showAlertController:(UIViewController *)presentVC alertType:(AlertType)type;

@end

NS_ASSUME_NONNULL_END
