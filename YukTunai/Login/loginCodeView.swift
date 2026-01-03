//
//  loginCodeView.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/1.
//

import UIKit

class loginCodeView: UIView {

    let codeText: YTTextField = YTTextField()
    let countdownBtn: CountdownButton = CountdownButton(frame: CGRectZero)
    let line = UIView(frame: CGRectZero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        codeText.setTextField(textColor: "#ffffff", font: 16, weight: UIFont.Weight.medium, alignment: NSTextAlignment.left, placeHolderText: LocalizationManager.shared().localizedString(forKey: "login_v_code"), style: UITextField.BorderStyle.none)
        #if DEBUG
        countdownBtn.totalSeconds = 10
        #else
        countdownBtn.totalSeconds = 60
        #endif
        countdownBtn.normalTitle = LocalizationManager.shared().localizedString(forKey: "login_v_code_btn")
        countdownBtn.finishedTitle = LocalizationManager.shared().localizedString(forKey: "login_v_code_btn")
        countdownBtn.countingTitle = { "\($0)s" }
        line.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        self.addSubview(self.codeText)
        self.addSubview(self.countdownBtn)
        self.addSubview(self.line)
        
        self.codeText.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        self.countdownBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.verticalEdges.equalToSuperview()
            make.width.greaterThanOrEqualTo(80)
        }
        
        self.line.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
