//
//  YTZhongJianViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit

class YTZhongJianViewController: YTBaseViewController {
    
    let scrollView = YTScrollView()
    
    let contentView = UIView()
    
    let pos = ["Frame 309","Frame 310","Frame 311","Frame 312","Frame 313","Frame 314"]
    
    let poss = [YTTools.areaTitle(a: "Under review", b: "Sedang ditinjau"),
                YTTools.areaTitle(a: "Loan in progress", b: "Pinjaman sedang dalam proses"),
                YTTools.areaTitle(a: "Overdue", b: "Terlambat"),
                YTTools.areaTitle(a: "Review failed", b: "Peninjauan gagal"),
                YTTools.areaTitle(a: "Loan released", b: "Pencairan pinjaman"),
                YTTools.areaTitle(a: "Cleared", b: "Menetap")]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //if YTUserDefaults.shared.gash == 2 {
            YTAddressTools.shared.load()
        //}
        
        setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = .init(hex: "#F2F4F4")
        
        view.add(scrollView) { v in
            v.alwaysBounceVertical = true
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        scrollView.add(contentView) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalToSuperview()
            }
        }
        
        let image = UIImageView.init(image: UIImage.init(named: "bg132"))
        contentView.add(image) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview()
            }
        }
        
        let boxs = UIView()
        contentView.add(boxs) { v in
            v.snp.makeConstraints { make in
                make.top.equalTo(image.snp.bottom).offset(-17)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-100)
            }
        }
        
        var pre: UIView?
        for i in pos.enumerated() {
           
            let image1 = UIImageView.init(image: UIImage.init(named: i.element))
            
            image1.isUserInteractionEnabled = true
          
            image1.tag = i.offset
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(clickTa(tap:)))
            image1.addGestureRecognizer(tap)
            
            
            boxs.add(image1) { v in
                v.snp.makeConstraints { make in
                    make.left.right.equalToSuperview().inset(13)
                    if i.offset == 0 {
                        make.top.equalToSuperview()
                    } else {
                        make.top.equalTo(pre!.snp.bottom).offset(10)
                        
                        if i.offset == pos.count - 1 {
                            make.bottom.equalToSuperview()
                        }
                    }
                }
            }
            
            
            let t2 = UILabel.init(title:poss[i.offset],textColor: .init(hex: "#141C35"),font: .systemFont(ofSize: 18,weight: .bold))
            t2.numberOfLines = 2
            image1.add(t2) { v in
                v.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.width.lessThanOrEqualTo(200)
                    make.left.equalToSuperview().offset(100)
                }
            }
            
            pre = image1
        }
        

    }
    
    
    
    @objc func clickTa(tap t: UITapGestureRecognizer){
        guard let v = t.view else {
            return
        }
        
        let vc = YTZhongJianCellViewController()
        vc.hT = poss[v.tag]
        if v.tag == 0 {
            vc.pid = "10"
        } else if v.tag == 1 {
            vc.pid = "9"
        } else if v.tag == 2 {
            vc.pid = "8"
        } else if v.tag == 3 {
            vc.pid = "7"
        } else if v.tag == 4 {
            vc.pid = "6"
        } else if v.tag == 5 {
            vc.pid = "5"
        }
        navigationController?.pushViewController(vc, animated: true)
    }

  

}
