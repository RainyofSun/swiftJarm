

import UIKit


extension UILabel {
    
   convenience init(title: String?,
                     textColor: UIColor = UIColor.darkGray,
                     font: UIFont = UIFont.systemFont(ofSize: 12, weight: .medium),
                     numOfLines: Int = 0,
                     alignment: NSTextAlignment = .left) {
        self.init()
        self.privateInit(title: title, textColor: textColor, font: font, numOfLines: numOfLines, alignment: alignment)
    }
    
    private func privateInit(title: String?,
                             textColor: UIColor = UIColor.darkGray,
                             font: UIFont = UIFont.systemFont(ofSize: 12, weight: .medium),
                             numOfLines: Int = 0,
                             alignment: NSTextAlignment = .left) {
        self.text = title
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numOfLines
        self.textAlignment = alignment
        self.sizeToFit()
    }
    
}
