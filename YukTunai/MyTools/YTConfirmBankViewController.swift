//
//  YTConfirmBankViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/21.
//

import UIKit

class YTConfirmBankViewController: PPAlertCksViewController {
    
    let viewModel = ApiViewModel()
    
    var pid: String?
    
    var onHandle:(()->())?

    let b2 = UILabel.init(title: "",textColor: .init(hex: "#F9962F"),font: .systemFont(ofSize: 24,weight: .bold))

    var l: [String:String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loanTileView.title.text = YTTools.areaTitle(a: "Confirm card number", b: "Konfirmasi nomor kartu")
        
        let box1 = UIView()
        box1.backgroundColor = .init(hex: "#FFF5E0")
        box1.cornersSet(by: .allCorners, radius: 8)
        contentView.add(box1) { v in
            v.snp.makeConstraints { make in
                make.height.equalTo(90)
                make.left.right.equalToSuperview().inset(17)
                make.verticalEdges.equalToSuperview().inset(40)
            }
            
            box1.addSubview(b2)
            b2.textAlignment = .center
            box1.add(b2) { v in
                v.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.left.right.equalToSuperview().inset(12)
                }
            }
        }
    }
    
    override func submitContent() {
      viewModel.offensive(avp: l!) {[weak self] r in
          switch r {
          case .success(let success):
              self?.dismiss(animated: false, completion: {
                  self?.onHandle?()
              })
              break
          case .failure(let failure):
              SVProgressHUD.showInfo(withStatus: failure.description)
              break
          }
      }
    }

}
