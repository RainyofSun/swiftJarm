//
//  YTShouyeListItemTableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeListItemTableViewCell: UITableViewCell {
    let box = UIView()
    
    let topimage = UIImageView()
    
    let topname = UILabel.init(title: "",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 12, weight: .bold))
    
    let toprightButton = UIButton.init(title: "",font: .systemFont(ofSize: 13), color: .init(hex: "#F9962F"))
    
    let money = UILabel.init(title: "",textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 14,weight: .bold))
    
    let centerrightButton =  GradientLoadingButton(frame: CGRectZero)
    
    let l1t = UILabel.init(title: YTTools.areaTitle(a: "Loan term", b: "Jangka waktu pinjaman"),textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 16))
    let l1tv = UILabel.init(title: "",textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 16))
    
    let l3t = UILabel.init(title: YTTools.areaTitle(a: "Interest rate", b: "Suku bunga"),textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 16))
    let l3tv = UILabel.init(title: "",textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 16))
    
    func cellLayout() {
        backgroundColor = .init(hex: "#62B0FE")
        
        centerrightButton.isUserInteractionEnabled = false
        
        box.backgroundColor = UIColor(hex: "#EAF5FF")
        box.cornersSet(by: .allCorners, radius: 8)
        contentView.add(box) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 5, left: 13, bottom: 5, right: 13))
            }
        }
        
        topimage.cornersSet(by: .allCorners, radius: 4)
        box.add(topimage) { v in
            v.snp.makeConstraints { make in
                make.left.top.equalToSuperview().offset(15)
                make.size.equalTo(20)
            }
        }
        
        box.add(topname) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(topimage.snp.right).offset(6)
                make.centerY.equalTo(topimage)
                make.width.equalToSuperview().multipliedBy(0.5)
            }
        }
        
        box.add(money) { v in
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-14)
                make.centerY.equalTo(topname)
            }
        }
        
        box.add(l1t) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(topimage)
                make.top.equalTo(topimage.snp.bottom).offset(20)
            }
        }
        
        box.add(l1tv) { v in
            v.snp.makeConstraints { make in
                make.centerY.equalTo(l1t)
                make.right.equalTo(money)
            }
        }
        
        box.add(l3t) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(topimage)
                make.top.equalTo(l1t.snp.bottom).offset(20)
            }
        }
        
        box.add(l3tv) { v in
            v.snp.makeConstraints { make in
                make.centerY.equalTo(l3t)
                make.right.equalTo(money)
            }
        }
        
        centerrightButton.cornersSet(by: .allCorners, radius: 8)
        box.add(centerrightButton) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalTo(l3tv.snp.bottom).offset(20)
                make.height.equalTo(48)
                make.bottom.equalToSuperview().offset(-15)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        cellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
