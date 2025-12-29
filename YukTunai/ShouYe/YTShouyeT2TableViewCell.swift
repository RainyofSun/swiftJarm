//
//  YTShouyeT2TableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeT2TableViewCell: UITableViewCell {
    
    let image1 = UIImageView()
    
    let image2 = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .init(hex: "#F2F4F4")
        
        image1.image = UIImage.init(named: YTTools.areaTitle(a: "hGroup 2", b: "hrGroup 4"))
        image2.image = UIImage.init(named: YTTools.areaTitle(a: "Group 3", b: "hreGroup 5"))
        
        contentView.addSubview(image1)
        image1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.equalTo((UIScreen.main.bounds.width-16-16-10)/2)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        contentView.addSubview(image2)
        image2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(image1.snp.right).offset(10)
            make.width.equalTo((UIScreen.main.bounds.width-16-16-10)/2)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
