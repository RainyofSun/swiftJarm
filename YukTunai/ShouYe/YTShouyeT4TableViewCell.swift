//
//  YTShouyeT4TableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeT4TableViewCell: UITableViewCell {

    let tip1 = UILabel(title: LocalizationManager.shared().localizedString(forKey: "Borrowingagreement"), textColor: .white, font: UIFont.boldSystemFont(ofSize: 16))
    let tip2 = UILabel(title: LocalizationManager.shared().localizedString(forKey: "oprotect"), textColor: .white, font: UIFont.boldSystemFont(ofSize: 10))
    let boxView = UIView(frame: CGRectZero)
    
    var strUrl: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        boxView.backgroundColor = .init(hex: "#FFAC30")
        
        let blackView = UIView(frame: CGRectZero)
        blackView.isUserInteractionEnabled = false
        blackView.backgroundColor = UIColor(hex: "#021B3A")
        blackView.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        let arrView = UIImageView(image: UIImage(named: "sett_arr"))
        
        let imgsjwjs = UIImageView(image: UIImage(named: "home_sw"))
        
        contentView.add(boxView) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.height.equalTo(80)
                make.verticalEdges.equalToSuperview().inset(12)
            }
            
            v.add(imgsjwjs) { v in
                v.snp.makeConstraints { make in
                    make.centerY.left.equalToSuperview()
                }
            }
            
            v.add(blackView) { v in
                v.snp.makeConstraints { make in
                    make.verticalEdges.equalToSuperview().inset(16)
                    make.right.equalToSuperview().offset(-15)
                    make.size.equalTo(48)
                }
            }
            
            blackView.add(arrView) { v in
                v.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
            }
            
            v.add(tip1) { v in
                v.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(16)
                    make.right.equalTo(blackView.snp.left).offset(-40)
                    make.width.equalToSuperview().multipliedBy(0.5)
                }
            }
            
            v.add(tip2) { v in
                v.snp.makeConstraints { make in
                    make.horizontalEdges.equalTo(tip1)
                    make.top.equalTo(tip1.snp.bottom).offset(5)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
