

import UIKit

@objc class YTTools: NSObject {
    
    
    static func isIPhone6Series() -> Bool {
        let screenSize = UIScreen.main.bounds.size
        return (screenSize.width == 375.0 && screenSize.height == 667.0) ||
               (screenSize.width == 667.0 && screenSize.height == 375.0)
    }
    
    /// 判断是否为 Pad
    /// - Returns: bool
    static func isIpad() -> Bool {
        let modelName = modelName
        if modelName.contains("iPad") {
            return true
        }
        return false
    }
    
    /// 设备的名字
    static var deviceIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// 设备的名字
    static var modelName: String {
        let identifier = deviceIdentifier
        func mapToDevice(identifier: String) -> String {
            //MARK: os(iOS)
            #if os(iOS)
            switch identifier {
            case "iPod1,1":
                return "iPod touch"
            case "iPod2,1":
                return "iPod touch (2nd generation)"
            case "iPod3,1":
                return "iPod touch (3rd generation)"
            case "iPod4,1":
                return "iPod touch (4th generation)"
            case "iPod5,1":
                return "iPod touch (5th generation)"
            case "iPod7,1":
                return "iPod touch (6th generation)"
            case "iPod9,1":
                return "iPod touch (7th generation)"
            case "iPhone1,1":
                return "iPhone"
            case "iPhone1,2":
                return "iPhone 3G"
            case "iPhone2,1":
                return "iPhone 3GS"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":
                return "iPhone 4"
            case "iPhone4,1":
                return "iPhone 4S"
            case "iPhone5,1", "iPhone5,2":
                return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":
                return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":
                return "iPhone 5s"
            case "iPhone7,2":
                return "iPhone 6"
            case "iPhone7,1":
                return "iPhone 6 Plus"
            case "iPhone8,1":
                return "iPhone 6s"
            case "iPhone8,2":
                return "iPhone 6s Plus"
            case "iPhone8,4":
                return "iPhone SE (2nd generation)"
            case "iPhone9,1", "iPhone9,3":
                return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":
                return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":
                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":
                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":
                return "iPhone X"
            case "iPhone11,2":
                return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":
                return "iPhone XS Max"
            case "iPhone11,8":
                return "iPhone XR"
            case "iPhone12,1":
                return "iPhone 11"
            case "iPhone12,3":
                return "iPhone 11 Pro"
            case "iPhone12,5":
                return "iPhone 11 Pro Max"
            case "iPhone12,8":
                return "iPhone SE"
            case "iPhone13,1":
                return "iPhone 12 mini"
            case "iPhone13,2":
                return "iPhone 12"
            case "iPhone13,3":
                return "iPhone 12 Pro"
            case "iPhone13,4":
                return "iPhone 12 Pro Max"
            case "iPhone14,2":
                return "iPhone 13 Pro"
            case "iPhone14,3":
                return "iPhone 13 Pro Max"
            case "iPhone14,4":
                return "iPhone 13 mini"
            case "iPhone14,5":
                return "iPhone 13"
            case "iPhone14,6":
                return "iPhone SE (3rd generation)"
            case "iPhone14,7":
                return "iPhone 14"
            case "iPhone14,8":
                return "iPhone 14 Plus"
            case "iPhone15,2":
                return "iPhone 14 Pro"
            case "iPhone15,3":
                return "iPhone 14 Pro Max"
            case "iPhone15,4":
                return "iPhone 15"
            case "iPhone15,5":
                return "iPhone 15 Plus"
            case "iPhone16,1":
                return "iPhone 15 Pro"
            case "iPhone16,2":
                return "iPhone 15 Pro Max"
            case "iPad1,1":
                return "iPad"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":
                return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":
                return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":
                return "iPad (4th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":
                return "iPad Air"
            case "iPad5,3", "iPad5,4":
                return "iPad Air 2"
            case "iPad6,11", "iPad6,12":
                return "iPad 5"
            case "iPad7,5", "iPad7,6":
                return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":
                return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":
                return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":
                return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":
                return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":
                return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":
                return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":
                return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":
                return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":
                return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":
                return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":
                return "Apple TV"
            case "AppleTV6,2":
                return "Apple TV 4K"
            case "AudioAccessory1,1":
                return "HomePod"
            case "i386", "x86_64":
                return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:
                return identifier
            }
            //MARK: os(tvOS)
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3":
                return "Apple TV 4"
            case "AppleTV6,2":
                return "Apple TV 4K"
            case "i386", "x86_64":
                return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default:
                return identifier
            }
            #endif
        }
        return mapToDevice(identifier: identifier)
    }
    
    static func kStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top
        statusBarHeight = topPadding ?? 20.0
        return statusBarHeight
    }
    
    static func areaTitle(a:String,b:String) -> String {
        return YTUserDefaults.shared.gash == "1" ? a:b
    }
    



    private static func isCuScheme(_ url: String) -> Bool {
        return url.hasPrefix("yu://")
    }

    private static func handleCuScheme(_ url: String, in navigationController: UINavigationController?, data: Any) {
        if url.contains("yu://una.kno.s/junge") {
           
        } else if url.contains("yu://una.kno.s/arrogant?erect") {
            handleProductDetailRequest(url, in: navigationController)
        }
    }



    private static func handleProductDetailRequest(_ url: String, in navigationController: UINavigationController?) {
        guard let parameters = extractParameters(from: url), let id = parameters["erect"] else {
            return
        }
        let productVC = YTProductViewController()
        productVC.mID = id
        navigationController?.pushViewController(productVC, animated: true)
    }



    static func extractParameters(from urlString: String) -> [String: String]? {
        guard let url = URL(string: urlString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
    
    static func fullScreenView() -> UIView {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            let windowArray = UIApplication.shared.windows
            for tempWin in windowArray {
                if tempWin.windowLevel == UIWindow.Level.normal {
                    window = tempWin;
                    break
                }
            }
        }
        return window!
    }
    
    
    static func keyWindo() -> UIView? {
        return UIApplication.shared.keyWindow?.rootViewController?.view
    }
    
    static func convertToDate(from string: String) -> Date? {
        let components = string.split(separator: "-")
        guard components.count == 3,
              let day = Int(components[0]),
              let month = Int(components[1]),
              let year = Int(components[2]) else {
            return nil
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
}



