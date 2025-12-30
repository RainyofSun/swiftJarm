//
//  YTShouyeT1TableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeT1TableViewCell: UITableViewCell {
    
    let bottomView = UIView()
    
    let name = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 20,weight: .semibold))
    
    let subName = UILabel.init(title: YTTools.areaTitle(a: "Loan amount", b: "Jumlah pinjaman"),textColor: .white,font: .systemFont(ofSize: 16))
    
    let price = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 38,weight: .bold))
    
    let icon = UIImageView()
    
    let buttonname = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 24,weight: .semibold))
    
    let buttonicon = UIButton(title: "", backimage: "home_apply")
    
    let lyBox = UIView.init(bgColor: .init(hex: "#FFFFFF",alpha: 0.18))
    
    let icon1 = UIImageView.init(image: UIImage.init(named: "Group 1347"))
    let l1t = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 13))
    let l1tv = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 14,weight: .bold))
    
    
    let icon2 = UIImageView.init(image: UIImage.init(named: "Group 1349"))
    let l2t = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 13))
    let l2tv = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 14,weight: .bold))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        let image = UIImageView.init(image: UIImage.init(named: "home_top"))
        contentView.add(image) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(UIScreen.main.bounds.width * 1.23)
                make.left.right.equalToSuperview()
            }
        }
        
        name.isHidden = true
        
        subName.isHidden = true
        
        price.isHidden = true
        
        icon.isHidden = true
        
        buttonname.isHidden = true
        
        buttonicon.isHidden = true
        
        lyBox.isHidden = true
        
        icon1.isHidden = true
        l1t.isHidden = true
        l1tv.isHidden = true
        
        
        icon2.isHidden = true
        l2t.isHidden = true
        l2tv.isHidden = true
        
        
        
        
        contentView.add(buttonicon) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(28)
                make.bottom.equalTo(image).offset(-10)
            }
            
            let box = UIView()
            bottomView.add(box) { v in
                v.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
            }
            
            box.add(buttonname) { v in
                v.snp.makeConstraints { make in
                    make.left.bottom.top.equalToSuperview()
                }
            }
        }
        
        
        contentView.add(icon) { v in
            icon.cornersSet(by: .allCorners, radius: 12)
            v.snp.makeConstraints { make in
                make.height.width.equalTo(44)
                make.left.equalToSuperview().offset(22)
                make.top.equalToSuperview().offset(statusBarHeight + (YTTools.isIPhone6Series() ? 12 : 1))
            }
        }
        
        contentView.add(name) { v in
            v.snp.makeConstraints { make in
                make.centerY.equalTo(icon)
                make.left.equalTo(icon.snp.right).offset(10)
            }
        }
        
        contentView.add(subName) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(icon.snp.bottom).offset(YTTools.isIPhone6Series() ? 8 : 4)
            }
        }
        
        contentView.add(price) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(subName.snp.bottom).offset(6)
            }
        }
        
        
        
        lyBox.cornersSet(by: .allCorners, radius: 12)
        contentView.add(lyBox) { v in
            v.snp.makeConstraints { make in
                make.height.equalTo(60)
                make.left.right.equalToSuperview().inset(13)
                make.top.equalTo(price.snp.bottom).offset(8)
            }
        }
        
        let bbox = UIView()
        lyBox.add(bbox) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(22)
               
                make.width.equalTo((UIScreen.main.bounds.width-33-33)/2)
                make.centerY.equalToSuperview()
            }
            
            bbox.add(icon1) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
            }
            
            bbox.add(l1t) { v in
                v.snp.makeConstraints { make in
                    make.left.equalTo(icon1.snp.right).offset(10)
                    make.top.equalToSuperview()
                }
            }
            
            bbox.add(l1tv) { v in
                v.snp.makeConstraints { make in
                    make.left.equalTo(icon1.snp.right).offset(10)
                    make.bottom.equalToSuperview()
                    make.top.equalTo(l1t.snp.bottom).offset(4)
                }
            }
        }
        
        let bbox2 = UIView()
        lyBox.add(bbox2) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(bbox.snp.right)
                make.top.equalTo(price.snp.bottom).offset(15)
                make.width.equalTo((UIScreen.main.bounds.width-33-33)/2)
            }
            
            bbox2.add(icon2) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(30)
                    make.centerY.equalToSuperview()
                }
            }
            
            bbox2.add(l2t) { v in
                v.snp.makeConstraints { make in
                    make.left.equalTo(icon2.snp.right).offset(10)
                    make.top.equalTo(l1t.snp.top)
                }
            }
            
            bbox2.add(l2tv) { v in
                v.snp.makeConstraints { make in
                    make.left.equalTo(icon2.snp.right).offset(10)
                    make.bottom.equalToSuperview()
                    make.top.equalTo(l1t.snp.bottom).offset(4)
                }
            }
        }
        
        
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
