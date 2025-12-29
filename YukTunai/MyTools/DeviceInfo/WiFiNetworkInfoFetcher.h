//
//  WiFiNetworkInfoFetcher.h
//  NW
//
//  Created by 张文 on 2024/9/18.
//

#import <UIKit/UIKit.h>
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AdSupport/AdSupport.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <CoreLocation/CoreLocation.h>
#import "WiFiNetworkDetails.h"

NS_ASSUME_NONNULL_BEGIN

@interface WiFiNetworkInfoFetcher : NSObject
+ (NSArray<WiFiNetworkDetails *> *)fetchWiFiDetails;
@end

NS_ASSUME_NONNULL_END
