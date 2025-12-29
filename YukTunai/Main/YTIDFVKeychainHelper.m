
#import "YTIDFVKeychainHelper.h"

@implementation YTIDFVKeychainHelper
static NSString *const idfaAccount = @"useridfa@cn.com";
static NSString *const idfaService = @"com.cn.www";

+ (void)storeIDFV:(NSString *)idfV {
    NSData *idfvData = [idfV dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([self isIDFVStored]) {
        NSLog(@"IDFV+++++++++++++++++++++++++++++++++++++++++++++++++++");
    } else {
        OSStatus status = [self addIDFVToKeychain:idfvData];
        if (status == errSecSuccess) {
            NSLog(@"IDFV+++++++++++++++++++++++++++++++++++++++++++++++++++");
        } else {
            NSLog(@"IDFV----------------------------------------------------: %d", (int)status);
        }
    }
}

+ (NSString *)retrieveIDFV {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrAccount: idfaAccount,
        (__bridge id)kSecAttrService: idfaService,
        (__bridge id)kSecReturnData: @YES,
        (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne
    };
    
    CFTypeRef item = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &item);
    
    if (status == errSecSuccess) {
        NSData *data = (__bridge NSData *)item;
        NSString *idfv = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return idfv;
    } else {
        NSLog(@"读取失败，错误代码: %d", (int)status);
    }
    
    return nil;
}

+ (OSStatus)addIDFVToKeychain:(NSData *)data {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrAccount: idfaAccount,
        (__bridge id)kSecAttrService: idfaService,
        (__bridge id)kSecValueData: data
    };
    
    return SecItemAdd((__bridge CFDictionaryRef)query, NULL);
}

+ (BOOL)isIDFVStored {
    NSDictionary *query = @{
        (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
        (__bridge id)kSecAttrAccount: idfaAccount,
        (__bridge id)kSecAttrService: idfaService,
        (__bridge id)kSecReturnData: @NO,
        (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne
    };
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL);
    return (status == errSecSuccess);
}

@end
