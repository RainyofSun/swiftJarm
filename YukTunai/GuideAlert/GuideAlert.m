//
//  GuideAlert.m
//  PinjamN
//
//  Created by Yu Chen  on 2025/12/28.
//

#import "GuideAlert.h"

@implementation GuideAlert

+ (void)showAlertController:(UIViewController *)presentVC alertType:(AlertType)type {
    
}

+ (NSString *)ok {
    if ([GuideAlert isEnglish]) {
        return @"Go to Settings";
    } else {
        return @"Buka Pengaturan";
    }
}

+ (NSString *)cancel {
    if ([GuideAlert isEnglish]) {
        return @"Cancel";
    } else {
        return @"Nanti Saja";
    }
}

+ (NSString *)title {
    if ([GuideAlert isEnglish]) {
        return @"Permission Required";
    } else {
        return @"Izin Diperlukan";
    }
}

+ (NSString *)content:(AlertType)type {
    if ([GuideAlert isEnglish]) {
        switch (type) {
            case AlertType_Location:
                return @"Location permission is disabled. Please enable it in Settings to allow your loan application to be processed.";
            case AlertType_Contacts:
                return @"Contact permission is disabled. Please enable it in Settings to allow your loan application to be processed.";
            case AlertType_Camera:
                return @"Camera permission is disabled. Please enable it in Settings to allow your loan application to be processed.";
        }
    } else {
        switch (type) {
            case AlertType_Location:
                return @"Izin lokasi dinonaktifkan. Harap aktifkan di Pengaturan agar aplikasi pinjaman Anda dapat diproses.";
            case AlertType_Contacts:
                return @"Izin kontak dinonaktifkan. Harap aktifkan di Pengaturan agar pengajuan pinjaman Anda dapat diproses.";
            case AlertType_Camera:
                return @"Izin kamera dinonaktifkan. Harap aktifkan di Pengaturan agar pengajuan pinjaman Anda dapat diproses.";
        }
    }
}

+ (BOOL)isEnglish {
    return [[[NSUserDefaults standardUserDefaults] stringForKey:@"gash"] isEqualToString:@"1"];
}

@end
