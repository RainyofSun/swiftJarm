//
//  LocationHelper.h
//  CukupUang
//
//  Created by whoami on 2024/9/17.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTLocationHelper : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) void (^locationCallback)(CLLocation * _Nullable location, NSError * _Nullable error);
@property (nonatomic, strong) dispatch_block_t timeoutTask;

+ (instancetype)sharedInstance;
- (void)requestLocationPermission;
- (void)requestLocationWithTimeout:(NSTimeInterval)timeout completion:(void (^)(CLLocation * _Nullable location, NSError * _Nullable error))completion;


- (NSString *)countryNameFromPlacemark:(CLPlacemark *)placemark;
- (NSString *)countryCodeFromPlacemark:(CLPlacemark *)placemark;
- (NSString *)provinceFromPlacemark:(CLPlacemark *)placemark;
- (NSString *)cityFromPlacemark:(CLPlacemark *)placemark;
- (NSString *)districtFromPlacemark:(CLPlacemark *)placemark;
- (NSString *)streetFromPlacemark:(CLPlacemark *)placemark;
- (NSString *)latitudeFromLocation:(CLLocation *)location;
- (NSString *)longitudeFromLocation:(CLLocation *)location;

- (NSDictionary *)locationDetail:(CLPlacemark *)placemark loca:(CLLocation *)location;


@end

NS_ASSUME_NONNULL_END
