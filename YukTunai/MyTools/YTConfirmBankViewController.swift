//
//  YTConfirmBankViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/21.
//

import UIKit

class YTConfirmBankViewController: YTBaseViewController {
    
    let viewModel = ApiViewModel()
    
    var pid: String?
    
    var onHandle:(()->())?

    let box = UIView()
    
    let b1 = UILabel.init(title: YTTools.areaTitle(a: "Confirm card number", b: "Konfirmasi nomor kartu"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 22,weight: .bold))
    
    let closeButton = UIButton.init(title: "", image: "取消")
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Confirmation", b: "Konfirmasi"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)

    let b2 = UILabel.init(title: "",textColor: .init(hex: "#F9962F"),font: .systemFont(ofSize: 24,weight: .bold))
    
    let t4 = UILabel.init(title: YTTools.areaTitle(a: "Please confirm your card number is correct?", b: "Harap konfirmasi apakah nomor kartu Anda benar?"),textColor: .init(hex: "#FF455D"),font: .systemFont(ofSize: 12))
    

    var l: [String:String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(true, animated: true)
        
    
        view.backgroundColor = .init(hex: "#000000",alpha: 0.5)
        box.backgroundColor = .white
        box.cornersSet(by: .allCorners, radius: 22)
        
        view.add(box) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(28)
                make.centerY.equalToSuperview()
            }
        }
    
        
        box.add(b1) { v in
            b1.textAlignment = .center
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(22)
            }
        }
        
        
        let box1 = UIView()
        box1.backgroundColor = .init(hex: "#FFF5E0")
        box1.cornersSet(by: .allCorners, radius: 12)
        box.add(box1) { v in
            v.snp.makeConstraints { make in
                make.height.equalTo(90)
                make.left.right.equalToSuperview().inset(17)
                make.top.equalTo(b1.snp.bottom).offset(45)
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
        
        
        let box2 = UIImageView.init(image: UIImage.init(named: "image 55"))
        box.add(box2) { v in
            v.snp.makeConstraints { make in
                make.right.equalTo(box1.snp.right).offset(-10)
                make.centerY.equalTo(box1.snp.top)
            }
        }
        
        box1.add(t4) { v in
            t4.textAlignment = .center
            v.snp.makeConstraints { make in
                make.left.right.equalTo(box1)
                make.top.equalTo(box1.snp.bottom).offset(8)
            }
        }
        
        box.add(button) { v in
            button.backgroundColor = .init(hex: "#5F85F4")
            v.cornersSet(by: .allCorners, radius: 25)
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(14)
                make.top.equalTo(t4.snp.bottom).offset(30)
                make.height.equalTo(50)
                make.bottom.equalToSuperview().offset(-22)
            }
        }
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.add(closeButton) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(box.snp.bottom).offset(33)
            }
        }
        
        button.addTarget(self, action: #selector(ccc), for: .touchUpInside)
    }
    
    @objc func close(){
        dismiss(animated: false)
    }
    
    @objc func ccc(){
          SVProgressHUD.show()
          SVProgressHUD.setDefaultStyle(.dark)
          SVProgressHUD.setDefaultMaskType(.clear)
          viewModel.offensive(avp: l!) {[weak self] r in
              switch r {
              case .success(let success):
                  SVProgressHUD.dismiss()
                  self?.dismiss(animated: false, completion: {
                      self?.onHandle?()
                  })
                  break
              case .failure(let failure):
                  SVProgressHUD.setDefaultStyle(.dark)
                  SVProgressHUD.setDefaultMaskType(.clear)
                  SVProgressHUD.dismiss(withDelay: 1.5)
                  SVProgressHUD.showInfo(withStatus: failure.description)
                  break
              }
          }
    }

}
