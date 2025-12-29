//
//  UIButton+Extension.swift
//  CukupUang
//
//  Created by whoami on 2024/8/17.
//

import UIKit

extension UIButton {
    
    enum ButtonImagePosition {
        case top          //图片在上，文字在下，垂直居中对齐
        case bottom       //图片在下，文字在上，垂直居中对齐
        case left         //图片在左，文字在右，水平居中对齐
        case right        //图片在右，文字在左，水平居中对齐
    }
    /// - Description 设置Button图片的位置
    /// - Parameters:
    ///   - style: 图片位置
    ///   - spacing: 按钮图片与文字之间的间隔
    func imagePosition(style: ButtonImagePosition, spacing: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-spacing/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-spacing/2, right: 0)
            break;
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -spacing/2, bottom: 0, right: spacing)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: spacing/2, bottom: 0, right: -spacing/2)
            break;
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-spacing/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-spacing/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+spacing/2, bottom: 0, right: -labelWidth-spacing/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-spacing/2, bottom: 0, right: imageWidth!+spacing/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    public convenience init (title: String, font: UIFont, color: UIColor, image: String = "", bgColor: UIColor = UIColor.clear) {
        self.init(type: .custom)
        titleLabel?.font = font
        setTitleColor(color, for: .normal)
        setTitleColor(color, for: .highlighted)
        setTitle(title: title)
        if !image.isEmpty {
            setImage(image: image)
        }
        
        setBackgroundColor(bgColor, forState: .normal)
        setBackgroundColor(bgColor, forState: .highlighted)
        sizeToFit()
    }
    
    public convenience init (title: String, image: String, bgColor: UIColor = UIColor.clear) {
        self.init(type: .custom)
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
        setBackgroundColor(bgColor, forState: .normal)
        setBackgroundColor(bgColor, forState: .highlighted)
        // 设置图片
        setImage(image: image)
        sizeToFit()
    }
    
    
    /// 设置图片
    public func setImage(image: String){
        guard !image.isEmpty  else { return }
        setImage(UIImage.init(named: image), for: .normal)
        setImage(UIImage.init(named: image), for: .highlighted)
    }
    
    public func setTitle(title: String){
        setTitle(title, for: .normal)
        setTitle(title, for: .highlighted)
    }
    
    public func setTitleColor(color: UIColor){
        setTitleColor(color, for: .normal)
        setTitleColor(color, for: .highlighted)
    }
    
    public func setFont(font: UIFont){
        titleLabel?.font = font
    }
    
    public func setBackgroundColor(_ backgroundColor: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(backgroundColor.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    public func setBackground(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    public func setBgColor(color: UIColor) {
        setBackgroundColor(color, forState: .normal)
        setBackgroundColor(color, forState: .highlighted)
    }
    
}
