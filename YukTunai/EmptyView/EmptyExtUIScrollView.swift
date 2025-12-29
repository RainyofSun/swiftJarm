//
//  Empty+UIScrollView.swift
//  Toni
//
//  Created by 张文 on 2022/5/19.
//

import UIKit



extension Empty where T : UIScrollView {
 
    var emptyDataSourceView: EmptyDataSourceView {
        return Empty.emptyView
    }
    
    var emptysuperView: UIScrollView {
        return emptyDataSourceView.superview as! UIScrollView
    }
    
    func hidden(){
        emptysuperView.bounces = true
        emptyDataSourceView.subviews.forEach{ $0.removeFromSuperview() }
        emptyDataSourceView.isHidden = true
    }
    
    func show(emptyImage image: UIImage,
              emptyTitle title: String?,
              buttonTitle: String? = nil,
              buttonImage: String = "",
              offsetY: CGFloat? = 0.0,
              topOffset: CGFloat = 0.0,
              canBunces: Bool? = false,
              action: @escaping ()->() = {  return }) {
        emptysuperView.bounces = canBunces ?? false
        emptyDataSourceView.isHidden = false
        emptyDataSourceView.image = image
        emptyDataSourceView.title = title
        emptyDataSourceView.buttonTitle = buttonTitle
        emptyDataSourceView.buttonImage = buttonImage
        emptyDataSourceView.action = action
        emptyDataSourceView.offsetY = offsetY ?? 0.0
        emptyDataSourceView.topOffset = topOffset
        emptyDataSourceView.layoutSubViews()
        
        Empty.layoutEmptyView()
    }

}





var kEmptyView = "emptyView"

public extension UIScrollView {
    
     var emptyView: EmptyDataSourceView {
        get {
            if let aValue = objc_getAssociatedObject(self, &kEmptyView) as? EmptyDataSourceView {
                return aValue
            }
            else {
                let empty = EmptyDataSourceView()
                empty.isHidden = true
                self.addSubview(empty)
                self.bringSubviewToFront(empty)
                self.emptyView = empty
                self.layoutEmptyView()
                return empty
            }
        }
        set {
            objc_setAssociatedObject(self, &kEmptyView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
     func layoutEmptyView(){
        emptyView.translatesAutoresizingMaskIntoConstraints = false
         emptyView.snp.remakeConstraints { make in
             make.left.right.bottom.equalToSuperview()
             make.top.equalTo(self).offset(self.emptyView.topOffset ?? 0)
             make.width.height.equalTo(self)
         }
         
    }
    
}









