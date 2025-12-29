//
//  DeviceInformationModel.m
//  NW
//
//  Created by 张文 on 2024/9/18.
//

#import "DeviceInformationModel.h"
#import "WiFiNetworkDetails.h"
#import "WiFiNetworkInfoFetcher.h"
#import "YTIDFVKeychainHelper.h"
#import <ifaddrs.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CFNetwork/CFNetwork.h>
#import <NetworkExtension/NetworkExtension.h>

@implementation DeviceInformationModel


+ (NSDictionary *)getDeviceInfo {
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    int batteryLevel = (int)(device.batteryLevel * 100);
    UIDeviceBatteryState batteryState = device.batteryState;
    
    WiFiNetworkDetails *currentWiFiNetwork = [[WiFiNetworkInfoFetcher fetchWiFiDetails] firstObject];
    NSString *ssid = currentWiFiNetwork.ssid ?: @"";
    NSString *bssid = currentWiFiNetwork.bssid ?: @"";
    
    NSDictionary *wifiDetails = @{
        @"leader": bssid,
        @"ensued": ssid
    };
    
    NSDictionary *deviceInfo = @{
        @"moment": @{
            @"silentium": [self freeDisk],
            @"cried": @([self getTotalStorageSize]),
            @"broadsword": @([self getTotalMemorySize]),
            @"mighty": @([self getTotalMemorySize] - [self freeMemory])
        },
        @"striking": @{
            @"entered": @(batteryLevel),
            @"president": @(batteryState == UIDeviceBatteryStateCharging ? 1 : 0)
        },
        @"shirt": @{
            @"dirty": device.systemVersion,
            @"hair": device.name,
            @"jacket": [self getDeviceName]
        },
        @"tight": @{
            @"cap": @([self isSimulator] ? 1 : 0),
            @"crimson": @([self isJailbroken] ? 1 : 0)
        },
        @"small": @{
            @"wore": [NSTimeZone localTimeZone].name,
            @"pieces": [self getDeviceIdentifier],
            @"schlaeger": [self getCurrentLanguage],
            @"spurred": [[self getNetworkType] uppercaseString],
            @"held": [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString]
        },
        @"booted": @{
            @"landsmannschaft": wifiDetails
        }
    };
    
    return deviceInfo;
}


+ (NSString *)getDeviceName {
    size_t size;
      // 获取 hw.machine 属性的大小
      sysctlbyname("hw.machine", NULL, &size, NULL, 0);
      
      // 定义一个 C 字符数组来存储设备型号
      char *machine = malloc(size);
      
      // 获取具体的设备型号
      sysctlbyname("hw.machine", machine, &size, NULL, 0);
      
      // 将 C 字符数组转换为 NSString
      NSString *model = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
      
      // 释放分配的内存
      free(machine);
      
      return model;
}


+ (NSString *)getCurrentLanguage {
    // 返回设备曾使用过的语言列表
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    
    // 当前使用的语言排在第一
    NSString *currentLanguage = [languages firstObject];
    
    return currentLanguage ?: @"en-CN";
}

+ (NSNumber *)freeDisk {
    @try {
            NSURL *url = [NSURL fileURLWithPath:NSTemporaryDirectory()];
            NSDictionary *results = [url resourceValuesForKeys:@[NSURLVolumeAvailableCapacityForImportantUsageKey] error:nil];
            
            NSNumber *freeSpace = results[NSURLVolumeAvailableCapacityForImportantUsageKey];
            if (freeSpace) {
                return freeSpace;
            } else {
                return @(-1);
            }
        }
        @catch (NSException *exception) {
            return @(-1);
        }
}

+ (unsigned long long)getTotalStorageSize {
    NSError *error;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (!error) {
        return [attributes[NSFileSystemSize] unsignedLongLongValue];
    }
    return 0;
}

+ (unsigned long long)getTotalMemorySize {
    return [NSProcessInfo processInfo].physicalMemory;
}

+ (unsigned long long)freeMemory {
    mach_msg_type_number_t size = sizeof(vm_statistics64_data_t) / sizeof(integer_t);
       vm_statistics64_data_t vmStat;
       vm_size_t pageSize = 0;
       
       mach_port_t hostPort = mach_host_self();
       host_page_size(hostPort, &pageSize);
       
       kern_return_t status = host_statistics64(hostPort, HOST_VM_INFO64, (host_info64_t)&vmStat, &size);
       
       if (status == KERN_SUCCESS) {
           // 计算空闲内存
           uint64_t freeMemory = (
               (uint64_t)vmStat.free_count +
               (uint64_t)vmStat.inactive_count +
               (uint64_t)vmStat.external_page_count +
               (uint64_t)vmStat.purgeable_count -
               (uint64_t)vmStat.speculative_count
           ) * (uint64_t)pageSize;
           
           return freeMemory;
       } else {
           NSLog(@"Failed to fetch vm statistics: %d", status);
           return 0;
       }
}

+ (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
    return YES;
#else
    return NO;
#endif
}

+ (BOOL)isJailbroken {
    NSArray *jailbreakPaths = @[@"/Applications/Cydia.app", @"/bin/bash", @"/usr/sbin/sshd", @"/etc/apt"];
    for (NSString *path in jailbreakPaths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            return YES;
        }
    }
    return NO;
}

+ (NSString *)getDeviceIdentifier {
    return [YTIDFVKeychainHelper retrieveIDFV];
}

+ (NSString *)uploadDeviceInfos {
    NSDictionary *deviceInfo = [self getDeviceInfo];
    NSData *deviceInfoData = [NSJSONSerialization dataWithJSONObject:deviceInfo options:0 error:nil];
    NSString *deviceInfoString = [[NSString alloc] initWithData:deviceInfoData encoding:NSUTF8StringEncoding];
    return deviceInfoString;
}

+ (NSString *)getNetworkType {
    struct sockaddr_storage zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    

    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);

    if (defaultRouteReachability == NULL) {
        // 错误处理
        NSLog(@"eewy");
    }
    
    if (!defaultRouteReachability) {
        return @"eew";
    }
    
    SCNetworkReachabilityFlags flags;
    Boolean didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    
    if (!didRetrieveFlags || !(flags & kSCNetworkReachabilityFlagsReachable) || (flags & kSCNetworkReachabilityFlagsConnectionRequired)) {
        return @"eew";
    }
    
    if (flags & kSCNetworkReachabilityFlagsConnectionRequired) {
        return @"eew";
    } else if (flags & kSCNetworkReachabilityFlagsIsWWAN) {
        return [self cellularNetworkType];
    } else {
        return @"WiFi";
    }
}

+ (NSString *)cellularNetworkType {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *networkType;
    
    if (@available(iOS 12.0, *)) {
        NSDictionary<NSString *, NSString *> *dict = info.serviceCurrentRadioAccessTechnology;
        NSString *firstKey = dict.allKeys.firstObject;
        NSString *typeTemp = dict[firstKey];
        if (!typeTemp) {
            return @"eew";
        }
        networkType = typeTemp;
    } else {
        NSDictionary<NSString *, NSString *> *dict = info.serviceCurrentRadioAccessTechnology;
        NSString *firstKey = dict.allKeys.firstObject;
        NSString *typeTemp = dict[firstKey];
        if (!typeTemp) {
            return @"eew";
        }
        networkType = typeTemp;
    }
    
    if (@available(iOS 14.1, *)) {
        if ([networkType isEqualToString:CTRadioAccessTechnologyNR] || [networkType isEqualToString:CTRadioAccessTechnologyNRNSA]) {
            return @"5G";
        }
    }
    
    if ([networkType isEqualToString:CTRadioAccessTechnologyGPRS] ||
        [networkType isEqualToString:CTRadioAccessTechnologyEdge] ||
        [networkType isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
        return @"2G";
    } else if ([networkType isEqualToString:CTRadioAccessTechnologyWCDMA] ||
               [networkType isEqualToString:CTRadioAccessTechnologyHSDPA] ||
               [networkType isEqualToString:CTRadioAccessTechnologyHSUPA] ||
               [networkType isEqualToString:CTRadioAccessTechnologyeHRPD] ||
               [networkType isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
               [networkType isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
               [networkType isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
        return @"3G";
    } else if ([networkType isEqualToString:CTRadioAccessTechnologyLTE]) {
        return @"4G";
    } else {
        return @"eew";
    }
}

+ (BOOL)isVPNConnected {
   
        NSArray *networkInterfaces = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
        
        for (NSString *interface in networkInterfaces) {
            CFDictionaryRef networkDetails = CNCopyCurrentNetworkInfo((__bridge CFStringRef)interface);
            if (networkDetails) {
                CFRelease(networkDetails);
            }
        }
        
        NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
        NSArray *scopedKeys = proxySettings[@"__SCOPED__"];
        
        for (NSString *key in scopedKeys) {
            if ([key rangeOfString:@"tap"].location != NSNotFound ||
                [key rangeOfString:@"tun"].location != NSNotFound ||
                [key rangeOfString:@"ppp"].location != NSNotFound ||
                [key rangeOfString:@"ipsec"].location != NSNotFound ||
                [key rangeOfString:@"ipsec0"].location != NSNotFound) {
                return YES;
            }
        }
        
        return NO;
   
}

+ (BOOL)isProxyEnabled {
    CFDictionaryRef proxySettingsRef = CFNetworkCopySystemProxySettings();
       if (!proxySettingsRef) {
           return NO;
       }

       NSDictionary *proxySettings = (__bridge NSDictionary *)(proxySettingsRef);

       // 检查 HTTP 代理是否启用
       NSNumber *httpEnable = proxySettings[(NSString *)kCFNetworkProxiesHTTPEnable];
       NSString *httpProxy = proxySettings[(NSString *)kCFNetworkProxiesHTTPProxy];

       // 如果 HTTP 代理启用了并且代理地址不为空，则返回 YES
       if ([httpEnable boolValue] && httpProxy && ![httpProxy isEqualToString:@""]) {
           CFRelease(proxySettingsRef);
           return YES;
       }

       CFRelease(proxySettingsRef);
       return NO;
}


@end
