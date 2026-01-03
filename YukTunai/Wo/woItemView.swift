//
//  woItemView.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/2.
//

import UIKit

enum WotItemsType: Int {
    case Apply = 1
    case Repayment = 2
    case Finished = 9
    
    func subText() -> String {
        switch self {
        case .Apply:
            return LocalizationManager.shared().localizedString(forKey: "order_apply")
        case .Repayment:
            return LocalizationManager.shared().localizedString(forKey: "order_repay")
        case .Finished:
            return LocalizationManager.shared().localizedString(forKey: "order_finis")
        }
    }
    
    func bgColor() -> String {
        switch self {
        case .Apply:
            return "#2864D7"
        case .Repayment:
            return "#FF8727"
        case .Finished:
            return "#24DD5B"
        }
    }
}

class woItemView: UIControl {

    let numLab = UILabel(title: "", textColor: .white, font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold))
    let whiteAww = UIImageView(image: UIImage(named: "white_arr"))
    let subLab = UILabel(title: "", textColor: .white, font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium))
    
    var type: WotItemsType = .Apply
    
    init(frame: CGRect, woType: WotItemsType) {
        super.init(frame: frame)
        self.type = woType
        
        self.numLab.text = "\(type.rawValue)"
        self.subLab.text = type.subText()
        
        self.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        self.backgroundColor = UIColor(hex: type.bgColor())
        
        self.add(numLab) { v in
            v.snp.makeConstraints { make in
                make.top.left.equalToSuperview().offset(11)
            }
        }
        
        self.add(whiteAww) { v in
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-10)
                make.centerY.equalTo(numLab)
            }
        }
        
        self.add(subLab) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(numLab)
                make.top.equalTo(numLab.snp.bottom).offset(8)
                make.bottom.equalToSuperview().offset(-10)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
