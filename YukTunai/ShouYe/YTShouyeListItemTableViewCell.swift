//
//  YTShouyeListItemTableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeListItemTableViewCell: UITableViewCell {
    
    let topimage = UIImageView()
    
    let topname = UILabel.init(title: "",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 12, weight: .bold))
    
    let toprightButton = UIButton.init(title: "",font: .systemFont(ofSize: 13), color: .init(hex: "#F9962F"))
    
    let money = UILabel.init(title: "",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 26,weight: .bold))
    
    let centerrightButton =  UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 18))//UIButton.init(title: "",font: .systemFont(ofSize: 18), color: .white)
    
    
    let l1t = UILabel.init(title: YTTools.areaTitle(a: "Loan term", b: "Jangka waktu pinjaman"),textColor: .init(hex: "#9B9B9B"),font: .systemFont(ofSize: 12))
    let l1tv = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 13))
    
    let l3t = UILabel.init(title: YTTools.areaTitle(a: "Interest rate", b: "Suku bunga"),textColor: .init(hex: "#9B9B9B"),font: .systemFont(ofSize: 12))
    let l3tv = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 13))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .init(hex: "#5E84F4")
        
        selectionStyle = .none
        
        centerrightButton.isUserInteractionEnabled = false
        
        let box = UIView()
        box.backgroundColor = .white
        box.cornersSet(by: .allCorners, radius: 12)
        contentView.add(box) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 5, left: 13, bottom: 5, right: 13))
            }
        }
        
        
        let box1 = UIView()
        box.add(box1) { v in
            v.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(32)
            }
            
            let leftBox = UIView()
            leftBox.backgroundColor = .init(hex: "#D4DFFF")
            box1.add(leftBox) { v in
                leftBox.cornersSet(by: .bottomRight, radius: 14)
                v.snp.makeConstraints { make in
                    make.left.top.bottom.equalToSuperview()
                }
                
                leftBox.add(topimage) { v in
                    v.snp.makeConstraints { make in
                        make.left.equalToSuperview().offset(14)
                        make.centerY.equalToSuperview()
                        make.width.height.equalTo(21)
                    }
                }
                
                leftBox.add(topname) { v in
                    v.snp.makeConstraints { make in
                        make.left.equalTo(topimage.snp.right).offset(6)
                        make.centerY.equalToSuperview()
                        make.right.equalToSuperview().offset(-21)
                    }
                }
                
            }
            
            
            
            box1.add(toprightButton) { v in
                v.snp.makeConstraints { make in
                    make.right.equalToSuperview().offset(-12)
                    make.centerY.equalToSuperview()
                }
            }

        }
        
        let box2 = UIView()
        box.add(box2) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(box1.snp.bottom)
            }
            
            box2.add(money) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(14)
                    make.top.bottom.equalToSuperview().inset(16)
                }
            }
            
            let b11 = UIView()
            b11.cornersSet(by: .allCorners, radius: 12)
            b11.backgroundColor = .init(hex: "#5F85F4")
            box2.add(b11) { v in
                v.snp.makeConstraints { make in
                    make.height.equalTo(36)
                    make.right.equalToSuperview().offset(-12)
                    make.centerY.equalToSuperview()
                }
            }
            
            
            b11.add(centerrightButton) { v in
              
                v.snp.makeConstraints { make in
                   
                    make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 8, left: 12, bottom: 8, right: 12))
                }
            }
        }
        
        
        
        
        
        
        let box3 = UIView()
        box.add(box3) { v in
            v.snp.makeConstraints { make in
                make.left.bottom.right.equalToSuperview()
                make.top.equalTo(box2.snp.bottom)
            }
            
            
            let lb = UIView()
            box3.add(lb) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(14)
                    make.top.equalToSuperview()
                    make.width.equalTo((UIScreen.main.bounds.width-13-13)/2)
                }
            }
            
            lb.add(l1t) { v in
                v.snp.makeConstraints { make in
                   
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.left.equalToSuperview()
                }
            }
            
            lb.add(l1tv) { v in
               
                v.snp.makeConstraints { make in
                    make.centerY.equalTo(l1t)
                    make.left.equalTo(l1t.snp.right).offset(10)
                }
            }
            
            
          
            
            let lr = UIView()
            box3.add(lr) { v in
                v.snp.makeConstraints { make in
                    make.top.equalTo(lb.snp.bottom).offset(12)
                    make.left.equalToSuperview().offset(14)
                    make.width.equalTo(lb)
                    make.bottom.equalToSuperview()
                }
            }
            
        
            
            lr.add(l3t) { v in
             
                v.snp.makeConstraints { make in
                    make.top.left.equalToSuperview()
                    make.bottom.equalToSuperview().offset(-12)
                }
            }
            
            lr.add(l3tv) { v in
             
                v.snp.makeConstraints { make in
                    make.centerY.equalTo(l3t)
                    make.left.equalTo(l3t.snp.right).offset(10)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
