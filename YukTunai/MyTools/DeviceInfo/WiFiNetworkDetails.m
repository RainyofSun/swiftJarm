//
//  WiFiNetworkDetails.m
//  NW
//
//  Created by 张文 on 2024/9/18.
//

#import "WiFiNetworkDetails.h"

@implementation WiFiNetworkDetails

- (instancetype)initWithInterface:(NSString *)interface isConnected:(BOOL)isConnected ssid:(NSString *)ssid bssid:(NSString *)bssid {
    self = [super init];
    if (self) {
        self.interface = interface;
        self.isConnected = isConnected;
        self.ssid = ssid;
        self.bssid = bssid;
    }
    return self;
}

@end
