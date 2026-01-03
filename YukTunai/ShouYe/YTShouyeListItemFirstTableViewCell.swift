//
//  YTShouyeListItemFirstTableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeListItemFirstTableViewCell: YTShouyeListItemTableViewCell {
    
    let bgImgView: UIImageView = UIImageView(image: UIImage(named: "tip_top"))
    let title: UILabel = UILabel(title: LocalizationManager.shared().localizedString(forKey: "Loansupermarket"), textColor: UIColor(hex: "#333333"), font: UIFont.boldSystemFont(ofSize: 16))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func cellLayout() {
        
        centerrightButton.isUserInteractionEnabled = false
        
        contentView.add(bgImgView) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        bgImgView.add(title) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.centerX.equalToSuperview()
            }
        }
        
        box.backgroundColor = UIColor(hex: "#EAF5FF")
        box.cornersSet(by: .allCorners, radius: 8)
        bgImgView.add(box) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalTo(title.snp.bottom).offset(24)
                make.bottom.equalToSuperview().offset(-5)
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
}
