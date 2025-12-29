//
//  UITextFieldExtension.swift
//  Toni
//
//
//

import UIKit


extension UITextField {
    
//    func setTextField(textColor: String, font:CGFloat, weight: UIFont.Weight, alignment: NSTextAlignment, placeHolderText: String, style: UITextField.BorderStyle) {
//        self.textColor = .init(hex: textColor)
//        self.font = UIFont.systemFont(ofSize: font, weight: weight)
//        self.textAlignment = alignment
//        self.placeholder = placeHolderText
//        self.borderStyle = style
//    }
}


class NWTextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}
