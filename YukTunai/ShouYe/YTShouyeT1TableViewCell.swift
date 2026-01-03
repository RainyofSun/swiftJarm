//
//  YTShouyeT1TableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeT1TableViewCell: UITableViewCell {
    
    let name = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 20,weight: .semibold))
    
    let subName = UILabel.init(title: YTTools.areaTitle(a: "Loan amount", b: "Jumlah pinjaman"),textColor: .white,font: .systemFont(ofSize: 16))
    
    let price = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 44,weight: .bold))
    
    let icon = UIImageView()
        
    let buttonicon = UIButton(title: "", backimage: "home_apply")
    
    let lyBox = UIImageView(image: UIImage(named: "top_line"))
    
    let l1t = UILabel.init(title: "",textColor: UIColor(hex: "#999999"),font: .systemFont(ofSize: 13))
    let l1tv = UILabel.init(title: "",textColor: UIColor(hex: "#333333"),font: .systemFont(ofSize: 14,weight: .bold))
    
    
    let l2t = UILabel.init(title: "",textColor: UIColor(hex: "#999999"),font: .systemFont(ofSize: 13))
    let l2tv = UILabel.init(title: "",textColor: UIColor(hex: "#333333"),font: .systemFont(ofSize: 14,weight: .bold))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        let bgHeight = UIScreen.main.bounds.width * 1.23
        buttonicon.isUserInteractionEnabled = false
        let image = UIImageView.init(image: UIImage.init(named: "home_top"))
        contentView.add(image) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(bgHeight)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        
        name.isHidden = true
        
        subName.isHidden = true
        
        price.isHidden = true
        
        icon.isHidden = true
        
        buttonicon.isHidden = true
        buttonicon.setFont(font: UIFont.boldSystemFont(ofSize: 22))
        buttonicon.titleEdgeInsets = UIEdgeInsets(top: -8, left: 0, bottom: 8, right: 0)
        
        lyBox.isHidden = true
        
        l1t.isHidden = true
        l1tv.isHidden = true
        
        
        l2t.isHidden = true
        l2tv.isHidden = true
        
        
        
        
        contentView.add(buttonicon) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(28)
                make.bottom.equalTo(image).offset(-10)
            }
        }
        
        let iconView = UIView(frame: CGRectZero)
        
        contentView.add(iconView) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(statusBarHeight)
            }
            
            iconView.add(icon) { v in
                icon.cornersSet(by: .allCorners, radius: 8)
                icon.layer.borderWidth = 1
                icon.layer.borderColor = UIColor.white.cgColor
                
                v.snp.makeConstraints { make in
                    make.size.equalTo(30)
                    make.left.verticalEdges.equalToSuperview()
                }
            }
            
            iconView.add(name) { v in
                v.snp.makeConstraints { make in
                    make.centerY.equalTo(icon)
                    make.left.equalTo(icon.snp.right).offset(10)
                    make.width.lessThanOrEqualTo(100)
                    make.right.equalToSuperview()
                }
            }
        }
        
        contentView.add(subName) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(icon.snp.bottom).offset(bgHeight * 0.15)
            }
        }
        
        contentView.add(price) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(subName.snp.bottom).offset(6)
            }
        }
        
        
        contentView.add(lyBox) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(price.snp.bottom).offset(bgHeight * 0.23)
            }
            
            lyBox.add(l1t) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(8)
                    make.centerY.equalToSuperview()
                }
            }
            
            lyBox.add(l1tv) { v in
                v.snp.makeConstraints { make in
                    make.left.equalTo(l1t.snp.right)
                    make.centerY.equalToSuperview()
                }
            }
            
            lyBox.add(l2t) { v in
                v.snp.makeConstraints { make in
                    make.left.equalTo(l1tv.snp.right).offset(10)
                    make.centerY.equalToSuperview()
                }
            }
            
            lyBox.add(l2tv) { v in
                v.snp.makeConstraints { make in
                    make.left.equalTo(l2t.snp.right)
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview().offset(-8)
                }
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
