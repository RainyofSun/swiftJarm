//
//  loginPhonView.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/1.
//

import UIKit

class loginPhonView: UIView {

    let fileLaw: UILabel = UILabel(title: (YTTools.areaTitle(a: "+61", b: "+91")), textColor: .white, font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium))
    let phoneText: YTTextField = YTTextField()
    let line = UIView(frame: CGRectZero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        phoneText.setTextField(textColor: "#ffffff", font: 16, weight: UIFont.Weight.medium, alignment: NSTextAlignment.left, placeHolderText: LocalizationManager.shared().localizedString(forKey: "login_phone_p"), style: UITextField.BorderStyle.none)
        line.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        self.addSubview(phoneText)
        self.addSubview(self.line)
        
        self.add(fileLaw) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.centerY.equalToSuperview()
                make.width.equalTo(30)
            }
        }
        
        phoneText.snp.makeConstraints { make in
            make.left.equalTo(fileLaw.snp.right).offset(8)
            make.height.equalTo(45)
            make.top.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        line.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(phoneText.snp.bottom)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
