//
//  PPChanPunTableViewCell.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/3.
//

import UIKit

class PPChanPunTableViewCell: UITableViewCell {
    
    let subName = UILabel.init(title: YTTools.areaTitle(a: "Loan amount", b: "Jumlah pinjaman"),textColor: .white,font: .systemFont(ofSize: 16))
    
    let price = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 44,weight: .bold))
    
    let lyBox = UIImageView(image: UIImage(named: "top_line"))
    
    let l1t = UILabel.init(title: "",textColor: UIColor(hex: "#999999"),font: .systemFont(ofSize: 13))
    let l1tv = UILabel.init(title: "",textColor: UIColor(hex: "#333333"),font: .systemFont(ofSize: 14,weight: .bold))
    
    
    let l2t = UILabel.init(title: "",textColor: UIColor(hex: "#999999"),font: .systemFont(ofSize: 13))
    let l2tv = UILabel.init(title: "",textColor: UIColor(hex: "#333333"),font: .systemFont(ofSize: 14,weight: .bold))
    let bgHeight = UIScreen.main.bounds.width
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        let image = UIImageView.init(image: UIImage.init(named: "pp_top"))
        contentView.add(image) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(bgHeight)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        
        subName.isHidden = true
        
        price.isHidden = true
        
        lyBox.isHidden = true
        
        l1t.isHidden = true
        l1tv.isHidden = true
        
        
        l2t.isHidden = true
        l2tv.isHidden = true
        
        contentView.add(subName) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(bgHeight * 0.39)
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
                make.top.equalTo(price.snp.bottom).offset(bgHeight * 0.26)
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
    
    func resetBoxView1() {
        contentView.add(lyBox) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(price.snp.bottom).offset(bgHeight * 0.26)
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
    
    
    func resetBoxView2() {
        l1tv.textAlignment = .center
        l2tv.textAlignment = .center
        
        contentView.add(lyBox) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(price.snp.bottom).offset(bgHeight * 0.26)
            }
            
            lyBox.add(l1tv) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(8)
                    make.centerY.equalToSuperview()
                }
            }
            
            lyBox.add(l2tv) { v in
                v.snp.makeConstraints { make in
                    make.left.equalTo(l1tv.snp.right)
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview().offset(-8)
                    make.width.equalTo(l1tv)
                }
            }
        }
    }
}
