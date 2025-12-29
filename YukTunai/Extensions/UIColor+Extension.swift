

import UIKit

extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        let hex: String = {
            if hexString.hasPrefix("#") {
                return String(hexString.dropFirst())
            }
            return hexString
        }()
        
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        
        let r, g, b: CGFloat
        switch hex.count {
        case 3: // RGB (12-bit)
            r = CGFloat((rgbValue & 0xF00) >> 8) / 15.0
            g = CGFloat((rgbValue & 0x0F0) >> 4) / 15.0
            b = CGFloat(rgbValue & 0x00F) / 15.0
        case 6: // RGB (24-bit)
            r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgbValue & 0x0000FF) / 255.0
        default:
            r = 0.0
            g = 0.0
            b = 0.0
        }
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
}




