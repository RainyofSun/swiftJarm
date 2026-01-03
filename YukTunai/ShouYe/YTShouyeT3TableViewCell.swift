//
//  YTShouyeT3TableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeT3TableViewCell: UITableViewCell {
    
  
    let image = UIImageView.init(image: UIImage.init(named: YTTools.areaTitle(a: "eng_en", b: "eng_id")))
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.width * 0.357)
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
