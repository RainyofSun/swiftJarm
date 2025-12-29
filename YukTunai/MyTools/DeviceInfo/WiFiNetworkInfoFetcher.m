//
//  WiFiNetworkInfoFetcher.m
//  NW
//
//  Created by 张文 on 2024/9/18.
//

#import "WiFiNetworkInfoFetcher.h"
#import "WiFiNetworkDetails.h"

@implementation WiFiNetworkInfoFetcher
+ (NSArray<WiFiNetworkDetails *> *)fetchWiFiDetails {
    // 获取支持的接口列表
    CFArrayRef interfaces = CNCopySupportedInterfaces();
    if (!interfaces) {
        return nil; // 如果没有接口，返回空
    }
    
    NSMutableArray<WiFiNetworkDetails *> *networkDetailsList = [NSMutableArray array];
    NSArray *interfaceArray = (__bridge_transfer NSArray *)interfaces; // 自动管理内存
    
    for (NSString *interface in interfaceArray) {
        // 获取当前网络信息
        NSDictionary *networkInfo = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)interface);
        
        // 创建 WiFiNetworkDetails 实例并设置默认值
        WiFiNetworkDetails *details = [[WiFiNetworkDetails alloc] initWithInterface:interface
                                                                         isConnected:(networkInfo != nil)
                                                                                ssid:networkInfo[(NSString *)kCNNetworkInfoKeySSID]
                                                                               bssid:networkInfo[(NSString *)kCNNetworkInfoKeyBSSID]];
        [networkDetailsList addObject:details];
    }
    
    return networkDetailsList; // 返回网络详情数组
}
@end
