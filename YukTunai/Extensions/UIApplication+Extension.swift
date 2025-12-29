
import UIKit


extension UIApplication {
    
    static var appVersion: String? {
        appUsageDescription(with: "CFBundleShortVersionString")
    }
    
}


extension UIApplication {
    
    static fileprivate func appUsageDescription (with key: String) -> String {
        let infoDictionary = Bundle.main.infoDictionary!
        let description = infoDictionary[key]
        let desc = description as! String
        return desc
    }
    
}



extension UIApplication {
    
    var keyWindow: UIWindow? {
        return self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .filter { $0.isKeyWindow }
            .first
    }
}

extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
    
}
