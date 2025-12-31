//
//  bigCardTipView.swift
//  YukTunai
//
//  Created by Yu Chen  on 2025/12/31.
//

import UIKit

enum TipText: String {
    case Superiority = "Superiority"
    case LongLoanPeriod = "Longloanperiod"
    case Lowloaninterestrate = "Lowloaninterestrate"
    case Highreviewrate = "Highreviewrate"
    case Highsafety = "Highsafety"
    case Nohiddanexpenses = "Nohiddanexpenses"
}

class bigCardTipView: UIView {

    private var leftLab: UILabel = UILabel(title: "", textColor: .black, font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium), alignment: NSTextAlignment.center)
    private var midlab: UILabel = {
        let view = UILabel(title: LocalizationManager.shared().localizedString(forKey: "Other"), textColor: .black, font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium), alignment: NSTextAlignment.center)
        view.isHidden = true
        return view
    }()
    
    private var rightlab: UILabel = {
        let view = UILabel(title: LocalizationManager.shared().localizedString(forKey: "Our"), textColor: .black, font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium), alignment: NSTextAlignment.center)
        view.isHidden = true
        return view
    }()
    
    private var midImg: UIImageView = {
        let view = UIImageView(image: UIImage(named: "bir_skw"))
        view.isHidden = true
        return view
    }()
    
    private var rightImg: UIImageView = {
        let view = UIImageView(image: UIImage(named: "boshw"))
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hex: "#EAF5FF")
        
        self.addSubview(self.leftLab)
        self.addSubview(self.midlab)
        self.addSubview(self.rightlab)
        self.addSubview(self.midImg)
        self.addSubview(self.rightImg)
        
        self.leftLab.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        self.midlab.snp.makeConstraints { make in
            make.left.equalTo(self.leftLab.snp.right)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        self.rightlab.snp.makeConstraints { make in
            make.left.equalTo(self.midlab.snp.right)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        self.midImg.snp.makeConstraints { make in
            make.center.equalTo(self.midlab)
        }
        
        self.rightImg.snp.makeConstraints { make in
            make.center.equalTo(self.rightlab)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTipType(type: TipText) {
        self.midlab.isHidden = type != TipText.Superiority
        self.rightlab.isHidden = self.midlab.isHidden
        self.midImg.isHidden = !self.midlab.isHidden
        self.rightImg.isHidden = !self.midlab.isHidden
        
        self.leftLab.text = LocalizationManager.shared().localizedString(forKey: type.rawValue)
    }
}
