//
//  YTShouyeT3TableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeT3TableViewCell: UITableViewCell {
    
  
    let image = UIImageView.init(image: UIImage.init(named: YTTools.areaTitle(a: "Group 177f5", b: "Group 1wwww775")))
    
    
    let b1 = UIButton.init()
    
    let b2 = UIButton.init()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .init(hex: "#F2F4F4")
        
        contentView.addSubview(image)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 16, bottom: 10, right: 16))
        }
        
        
        contentView.addSubview(b1)
        contentView.addSubview(b2)
        
        b1.snp.makeConstraints { make in
            make.width.equalTo(image.frame.width/2)
            make.height.equalTo(44)
            make.top.equalToSuperview()
            make.left.equalTo(image)
        }
        
        
        b2.snp.makeConstraints { make in
            make.width.equalTo(image.frame.width/2)
            make.height.equalTo(44)
            make.right.top.equalTo(image)
        }
        
        b1.addTarget(self, action: #selector(a1), for: .touchUpInside)
        b2.addTarget(self, action: #selector(a2), for: .touchUpInside)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func a1(){
        image.image = UIImage.init(named: YTTools.areaTitle(a: "Group 177f5", b: "Group 1wwww775"))
    }
    
    @objc func a2(){
        image.image = UIImage.init(named: YTTools.areaTitle(a: "Grou1p 1775", b: "Group fewwe1775"))
    }
}
