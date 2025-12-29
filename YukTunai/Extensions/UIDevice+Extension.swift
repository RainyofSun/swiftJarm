
import UIKit


extension UIDevice {
    // lhp
    var hasNotch: Bool {
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        let bottomSafeInset = window?.safeAreaInsets.bottom ?? 0
        return bottomSafeInset > 0
    }
}


let statusBarHeight = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
