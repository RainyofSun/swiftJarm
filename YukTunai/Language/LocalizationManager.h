//
//  LocalizationManager.h
//  PinjamN
//
//  Created by Yu Chen  on 2025/12/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 语言变更通知（切换语言后发出）
FOUNDATION_EXPORT NSString * const LocalizationLanguageDidChangeNotification;

@interface LocalizationManager : NSObject

/// 当前 App 语言（如 @"en" / @"zh-Hans"）
@property (nonatomic, copy, readonly) NSString *currentLanguage;

/// 是否跟随系统语言
@property (nonatomic, assign, readonly) BOOL followsSystemLanguage;

/// 单例
+ (instancetype)sharedManager;

/// 获取本地化字符串
- (NSString *)localizedStringForKey:(NSString *)key;

/// 获取本地化字符串（支持 table）
- (NSString *)localizedStringForKey:(NSString *)key
                              table:(nullable NSString *)table;

/// 设置 App 语言（@"en", @"zh-Hans"...）
- (void)setLanguage:(NSString *)language;

/// 恢复跟随系统语言
- (void)resetToSystemLanguage;

@end

NS_ASSUME_NONNULL_END
