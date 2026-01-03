//
//  CancleItemView.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/2.
//

import UIKit

class CancleItemView: UIView {

    let numLab = UILabel(title: "", textColor: .white, font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium))
    let content = UILabel(title: "", textColor: .black, font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        numLab.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        numLab.backgroundColor = UIColor(hex: "#2864D7")
        numLab.textAlignment = .center
        
        self.add(numLab) { v in
            v.snp.makeConstraints { make in
                make.size.equalTo(16)
                make.top.left.equalToSuperview().offset(15)
            }
        }
        
        self.add(content) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(numLab.snp.right).offset(8)
                make.top.equalTo(numLab)
                make.bottom.equalToSuperview()
                make.right.equalToSuperview().offset(-15)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
