

import UIKit

extension UIView {
    
    @discardableResult
    func add<T: UIView>(_ subView: T, then closure: (T)->Void ) -> T {
        addSubview(subView)
        closure(subView)
        return subView
    }
    
}




extension UIView {
    
    var topSafeAreaInset: CGFloat {
        return self.safeAreaInsets.top
    }

    var bottomSafeAreaInset: CGFloat {
        return self.safeAreaInsets.bottom
    }
    
}




extension UIView {
    
    convenience init (bgColor: UIColor) {
        self.init()
        backgroundColor = bgColor
    }
    
    
    func cornersSet(by corners: UIRectCorner, radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    
    enum GradientDirection {
        case topToBottom
        case leftToRight
        case topLeftToBottomRight
    }

    func applyGradient(to view: UIView, colors: [UIColor], locations: [NSNumber]? = nil, direction: GradientDirection) {
        removeGradientLayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // 设置渐变的颜色
        gradientLayer.colors = colors.map { $0.cgColor }
        
        // 设置渐变的结束位置
        if let locations = locations {
            gradientLayer.locations = locations
        }
        
        // 设置渐变方向
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .topLeftToBottomRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        
        // 移除已有的渐变图层以避免重复
        if let previousGradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            previousGradientLayer.removeFromSuperlayer()
        }
        
        // 将渐变图层添加到视图
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    private func removeGradientLayer() {
          // 查找并移除已存在的渐变层
          self.layer.sublayers?.forEach { layer in
              if let gradientLayer = layer as? CAGradientLayer,
                 gradientLayer.name == "GradientLayer" {
                  gradientLayer.removeFromSuperlayer()
              }
          }
      }
}



extension UIView {
    
    // 获取状态栏高度
    var statusBarHeight: CGFloat {
        UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    }
    
  
    
  
    
}



extension UIViewController {
    
    // 获取状态栏高度
    var statusBarHeight: CGFloat {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0
    }
    
    // 获取导航栏高度
    var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.size.height ?? 0
    }
    
    // 获取安全区域顶部高度
    var safeAreaTop: CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }
    
    // 获取状态栏和导航栏的总高度
    var totalTopHeight: CGFloat {
        return statusBarHeight + navigationBarHeight
    }
}


extension UIView {
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        for subview in self.subviews {
            if let firstResponder = subview.findFirstResponder() {
                return firstResponder
            }
        }
        return nil
    }
}
