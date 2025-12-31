//
//  YTShouyeT2TableViewCell.swift
//  YukTunai
//
//  Created by whoami on 2024/11/20.
//

import UIKit

class YTShouyeT2TableViewCell: UITableViewCell {
    
    let image1 = UIImageView(image: UIImage(named: "tip_top"))

    let title: UILabel = UILabel(title: LocalizationManager.shared().localizedString(forKey: "home_tip_big"), textColor: .black, font: UIFont.boldSystemFont(ofSize: 16))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        let top_box: bigCardTipView = bigCardTipView(frame: CGRectZero)
        top_box.setTipType(type: TipText.Superiority)
        top_box.cornersSet(by: .allCorners, radius: 8)
        
        let bottom_box: UIView = UIView(frame: CGRectZero)
        bottom_box.backgroundColor = UIColor(hex: "#EAF5FF")
        bottom_box.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        
        let box1: bigCardTipView = bigCardTipView(frame: CGRectZero)
        let box2: bigCardTipView = bigCardTipView(frame: CGRectZero)
        let box3: bigCardTipView = bigCardTipView(frame: CGRectZero)
        let box4: bigCardTipView = bigCardTipView(frame: CGRectZero)
        let box5: bigCardTipView = bigCardTipView(frame: CGRectZero)
        
        box1.setTipType(type: TipText.LongLoanPeriod)
        box2.setTipType(type: TipText.Lowloaninterestrate)
        box3.setTipType(type: TipText.Highreviewrate)
        box4.setTipType(type: TipText.Highsafety)
        box5.setTipType(type: TipText.Nohiddanexpenses)
        
        contentView.add(image1) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            v.add(title) { v in
                v.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalToSuperview().offset(10)
                }
            }
            
            v.add(top_box) { v1 in
                v1.snp.makeConstraints { make in
                    make.horizontalEdges.equalToSuperview().inset(15)
                    make.top.equalTo(title.snp.bottom).offset(25)
                    make.height.equalTo(36)
                }
            }
            
            v.add(bottom_box) { v in
                v.snp.makeConstraints { make in
                    make.horizontalEdges.equalTo(top_box)
                    make.top.equalTo(top_box.snp.bottom).offset(4)
                    make.bottom.equalToSuperview().offset(-8)
                }
            }
            
            bottom_box.add(box1) { v in
                v.snp.makeConstraints { make in
                    make.horizontalEdges.top.equalToSuperview()
                    make.height.equalTo(top_box)
                }
            }
            
            bottom_box.add(box2) { v in
                v.snp.makeConstraints { make in
                    make.horizontalEdges.height.equalTo(box1)
                    make.top.equalTo(box1.snp.bottom)
                }
            }
            
            bottom_box.add(box3) { v in
                v.snp.makeConstraints { make in
                    make.horizontalEdges.height.equalTo(box1)
                    make.top.equalTo(box2.snp.bottom)
                }
            }
            
            bottom_box.add(box4) { v in
                v.snp.makeConstraints { make in
                    make.horizontalEdges.height.equalTo(box1)
                    make.top.equalTo(box3.snp.bottom)
                }
            }
            
            bottom_box.add(box5) { v in
                v.snp.makeConstraints { make in
                    make.horizontalEdges.height.equalTo(box1)
                    make.top.equalTo(box4.snp.bottom)
                    make.bottom.equalToSuperview()
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
