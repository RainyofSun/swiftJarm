//
//  LocationHelper.m
//  CukupUang
//
//  Created by whoami on 2024/9/17.
//

#import "YTLocationHelper.h"

@implementation YTLocationHelper


+ (instancetype)sharedInstance {
    static YTLocationHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (BOOL)checkLocationAuthorizationStatus {
    CLAuthorizationStatus status = self.locationManager.authorizationStatus;
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            return YES;
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            return NO;
        default:
            return NO;
    }
}

- (void)requestLocationPermission {
    if ([CLLocationManager locationServicesEnabled]) {
            if (@available(iOS 14.0, *)) {
                CLAuthorizationStatus status = self.locationManager.authorizationStatus; // 使用实例方法
                [self handleAuthorizationStatus:status];
            }
        } else {
            NSLog(@"fwsssssssss");
        }
}

- (void)handleAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization]; // 请求权限
            break;
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
            NSLog(@"fwefweffff");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"ffwef");
            break;
        default:
            break;
    }
}


- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    if (@available(iOS 14.0, *)) {
        CLAuthorizationStatus status = manager.authorizationStatus; // 使用实例方法获取授权状态
        [self handleAuthorizationStatus:status];
    }
}

- (void)requestLocationWithTimeout:(NSTimeInterval)timeout completion:(void (^)(CLLocation * _Nullable location, NSError * _Nullable error))completion {
    self.locationCallback = completion;
    
    // 检查定位权限
    if (![self checkLocationAuthorizationStatus]) {
        if (self.locationCallback) {
            NSError *error = [NSError errorWithDomain:@"LocationError"
                                                 code:1
                                             userInfo:@{NSLocalizedDescriptionKey: @"Location services are disabled"}];
            self.locationCallback(nil, error);
        }
        return;
    }
    
    CLAuthorizationStatus status = self.locationManager.authorizationStatus;
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
        [self startLocationUpdatesWithTimeout:timeout];
    } else {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)startLocationUpdatesWithTimeout:(NSTimeInterval)timeout {
    [self.locationManager startUpdatingLocation];
    
    self.timeoutTask = dispatch_block_create(0, ^{
        [self.locationManager stopUpdatingLocation];
        if (self.locationCallback) {
            NSError *error = [NSError errorWithDomain:@"fwefwe"
                                                 code:1
                                             userInfo:@{NSLocalizedDescriptionKey: @"ffffffffffff"}];
            self.locationCallback(nil, error);
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), self.timeoutTask);
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    [self.locationManager stopUpdatingLocation];
    
    if (self.timeoutTask) {
        dispatch_block_cancel(self.timeoutTask);
    }
    
    if (location) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (!error && placemarks.count > 0) {
                if (self.locationCallback) {
                    self.locationCallback(location, nil);
                }
            } else {
                if (self.locationCallback) {
                    NSError *locationError = [NSError errorWithDomain:@"erew"
                                                                 code:1
                                                             userInfo:@{NSLocalizedDescriptionKey: @"ffffffffffff"}];
                    self.locationCallback(nil, locationError);
                }
            }
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
    if (self.timeoutTask) {
        dispatch_block_cancel(self.timeoutTask);
    }
    if (self.locationCallback) {
        self.locationCallback(nil, error);
    }
}




- (NSString *)countryNameFromPlacemark:(CLPlacemark *)placemark {
    // 获取国家名称
    if (placemark.country != nil) {
        return placemark.country;
    }
    return @"";
}

- (NSString *)countryCodeFromPlacemark:(CLPlacemark *)placemark {
    // 获取国家代码 (ISO country code)
    if (placemark.ISOcountryCode != nil) {
        return placemark.ISOcountryCode;
    }
    return @"";
}

- (NSString *)provinceFromPlacemark:(CLPlacemark *)placemark {
    // 获取省份
    if (placemark.administrativeArea != nil) {
        return placemark.administrativeArea;
    }
    return @"";
}

- (NSString *)cityFromPlacemark:(CLPlacemark *)placemark {
    // 获取城市
    if (placemark.locality != nil) {
        return placemark.locality;
    }
    return @"";
}

- (NSString *)districtFromPlacemark:(CLPlacemark *)placemark {
    // 获取区
    if (placemark.subLocality != nil) {
        return placemark.subLocality;
    }
    return @"";
}

- (NSString *)streetFromPlacemark:(CLPlacemark *)placemark {
    // 获取街道
    if (placemark.thoroughfare != nil) {
        if (placemark.subThoroughfare != nil) {
            return [NSString stringWithFormat:@"%@ %@", placemark.subThoroughfare, placemark.thoroughfare];
        }
        return placemark.thoroughfare;
    }
    return @"";
}

- (NSString *)latitudeFromLocation:(CLLocation *)location {
    // 获取纬度，保留6位小数
    return [NSString stringWithFormat:@"%.6f", location.coordinate.latitude];
}

- (NSString *)longitudeFromLocation:(CLLocation *)location {
    // 获取经度，保留6位小数
    return [NSString stringWithFormat:@"%.6f", location.coordinate.longitude];
}

- (NSDictionary *)locationDetail:(CLPlacemark *)placemark loca:(CLLocation *)location {
    NSDictionary *appInfo = @{
                   @"arch": [self provinceFromPlacemark:placemark],
                   @"beneath": [self countryCodeFromPlacemark:placemark],
                   @"cheeks": [self countryNameFromPlacemark:placemark],
                   @"rosy": [self streetFromPlacemark:placemark],
                   @"mustaches": [self longitudeFromLocation:location],
                   @"smooth": [self latitudeFromLocation:location],
                   @"enormous": [self cityFromPlacemark:placemark],
                   @"cork": [self districtFromPlacemark:placemark]
               };
    return appInfo;
}





@end
