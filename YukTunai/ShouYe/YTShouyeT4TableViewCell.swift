//
//  YTShouyeT4TableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeT4TableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .init(hex: "#F2F4F4")
        
        let image = UIImageView.init(image: UIImage.init(named: YTTools.areaTitle(a: "Group 1779", b: "Group 1780")))
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(13)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
