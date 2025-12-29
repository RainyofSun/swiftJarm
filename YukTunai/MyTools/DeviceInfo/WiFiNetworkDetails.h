//
//  WiFiNetworkDetails.h
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

NS_ASSUME_NONNULL_BEGIN

@interface WiFiNetworkDetails : NSObject
@property (nonatomic, strong) NSString *interface;
@property (nonatomic, assign) BOOL isConnected;
@property (nonatomic, strong) NSString *ssid;
@property (nonatomic, strong) NSString *bssid;

- (instancetype)initWithInterface:(NSString *)interface isConnected:(BOOL)isConnected ssid:(NSString *)ssid bssid:(NSString *)bssid;

@end


NS_ASSUME_NONNULL_END
