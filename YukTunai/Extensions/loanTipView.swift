//
//  loanTipView.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/2.
//

import UIKit

class loanTipView: UIImageView {

    let title = UILabel(title: "", textColor: .black, font: UIFont.boldSystemFont(ofSize: 16))
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named: "alert_top")
        
        self.add(title) { v in
            v.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
