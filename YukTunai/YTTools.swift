

import UIKit

@objc class YTTools: NSObject {
    
    
    static func isIPhone6Series() -> Bool {
        let screenSize = UIScreen.main.bounds.size
        return (screenSize.width == 375.0 && screenSize.height == 667.0) ||
               (screenSize.width == 667.0 && screenSize.height == 375.0)
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



