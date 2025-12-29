//
//  LocalizationManager.m
//  PinjamN
//
//  Created by Yu Chen  on 2025/12/27.
//

#import "LocalizationManager.h"

NSString * const LocalizationLanguageDidChangeNotification =
@"LocalizationLanguageDidChangeNotification";

static NSString * const kAppLanguageKey = @"kAppLanguageKey";

@interface LocalizationManager ()
@property (nonatomic, strong) NSBundle *languageBundle;
@property (nonatomic, copy, readwrite) NSString *currentLanguage;
@property (nonatomic, assign, readwrite) BOOL followsSystemLanguage;
@end

@implementation LocalizationManager

+ (instancetype)sharedManager {
    static LocalizationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        [manager loadInitialLanguage];
    });
    return manager;
}

#pragma mark - Init

- (void)loadInitialLanguage {
    NSString *savedLanguage =
    [[NSUserDefaults standardUserDefaults] stringForKey:kAppLanguageKey];

    if (savedLanguage.length > 0) {
        self.followsSystemLanguage = NO;
        [self applyLanguage:savedLanguage];
    } else {
        self.followsSystemLanguage = YES;
        [self applySystemLanguage];
    }
}

#pragma mark - Language Apply

- (void)applySystemLanguage {
    NSString *systemLang =
    [NSLocale preferredLanguages].firstObject ?: @"en";

    // zh-Hans-CN → zh-Hans
    if ([systemLang hasPrefix:@"zh-Hans"]) {
        systemLang = @"zh-Hans";
    } else if ([systemLang hasPrefix:@"zh-Hant"]) {
        systemLang = @"zh-Hant";
    }

    [self applyLanguage:systemLang];
}

- (void)applyLanguage:(NSString *)language {
    NSString *path =
    [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];

    if (!path) {
        // fallback
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        language = @"en";
    }

    self.languageBundle = [NSBundle bundleWithPath:path];
    self.currentLanguage = language;
}

#pragma mark - Public

- (NSString *)localizedStringForKey:(NSString *)key {
    return [self localizedStringForKey:key table:nil];
}

- (NSString *)localizedStringForKey:(NSString *)key
                              table:(NSString *)table {
    return [self.languageBundle localizedStringForKey:key
                                                 value:key
                                                 table:table];
}

- (void)setLanguage:(NSString *)language {
    if (!language.length) return;

    self.followsSystemLanguage = NO;
    [[NSUserDefaults standardUserDefaults] setObject:language
                                              forKey:kAppLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self applyLanguage:language];

    [[NSNotificationCenter defaultCenter]
     postNotificationName:LocalizationLanguageDidChangeNotification
     object:nil];
}

- (void)resetToSystemLanguage {
    self.followsSystemLanguage = YES;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAppLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self applySystemLanguage];

    [[NSNotificationCenter defaultCenter]
     postNotificationName:LocalizationLanguageDidChangeNotification
     object:nil];
}

@end
