//
//  YTUserInfoAlertViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/21.
//

import UIKit

class YTUserInfoAlertViewController: YTBaseViewController {
    
    let viewModel = ApiViewModel()
    
    var pid: String?
    
    var m: FACEhandsModel?
    
    var onHandle:(()->Void)?
    
    let box = UIView()
    
    let b1 = UILabel.init(title: YTTools.areaTitle(a: "Confirm information", b: "Konfirmasi informasi"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 22,weight: .bold))
    
    let closeButton = UIButton.init(title: "", image: "取消")
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Confirmation", b: "Konfirmasi"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    
    let t1 = UILabel.init(title: YTTools.areaTitle(a: "Full Name", b: "Nama Lengkap"),textColor: .init(hex: "#919191"),font: .systemFont(ofSize: 14))
    
    let t2 = UILabel.init(title: YTTools.areaTitle(a: "ID NO.", b: "Nama Lengkap"),textColor: .init(hex: "#919191"),font: .systemFont(ofSize: 14))
    
    let t3 = UILabel.init(title: YTTools.areaTitle(a: "Birthday", b: "Hari ulang tahun"),textColor: .init(hex: "#919191"),font: .systemFont(ofSize: 14))
    
    let t4 = UILabel.init(title: YTTools.areaTitle(a: "Check the identity information andmake sure it is correct, oncesubmitted it cannot be changed!", b: "Periksa informasi identitas dan pastikan sudah benar, setelah dikirimkan tidak dapat diubah!"),textColor: .init(hex: "#FF455D"),font: .systemFont(ofSize: 12))
    
    let f1 = UIView()
    let f2 = UIView()
    let f3 = UIView()
    
    let text1 = YTTextField()
    let text2 = YTTextField()
    let text3 = YTTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(true, animated: true)
        
        
        text1.font = .systemFont(ofSize: 18,weight: .semibold)
        text2.font = .systemFont(ofSize: 18,weight: .semibold)
        text3.font = .systemFont(ofSize: 18,weight: .semibold)
        
        text1.keyboardType = .asciiCapable
        text2.keyboardType = .asciiCapable
        text3.isUserInteractionEnabled = false
        
        text1.placeholder = YTTools.areaTitle(a: "please input", b: "Sila masukkan")
        text2.placeholder = YTTools.areaTitle(a: "please input", b: "Sila masukkan")
        text3.placeholder = YTTools.areaTitle(a: "please input", b: "Sila masukkan")
        
        
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
        
        let box2 = UIView()
        box.add(box2) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(17)
                make.top.equalTo(b1.snp.bottom).offset(28)
            }
            
            box2.add(t1) { v in
                v.snp.makeConstraints { make in
                    make.left.top.equalToSuperview()
                }
            }
            
            box2.add(f1) { v in
                f1.backgroundColor = .init(hex: "#F4F8FF")
                f1.cornersSet(by: .allCorners, radius: 8)
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.height.equalTo(48)
                    make.top.equalTo(t1.snp.bottom).offset(6)
                }
                
                f1.add(text1) { v in
                    v.snp.makeConstraints { make in
                        make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12))
                    }
                }
            }
            
            
            box2.add(t2) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.top.equalTo(f1.snp.bottom).offset(8)
                }
            }
            
            box2.add(f2) { v in
                f2.backgroundColor = .init(hex: "#F4F8FF")
                f1.cornersSet(by: .allCorners, radius: 8)
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.right.equalToSuperview()
                    make.height.equalTo(48)
                    make.top.equalTo(t2.snp.bottom).offset(6)
                }
                
                f2.add(text2) { v in
                    v.snp.makeConstraints { make in
                        make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12))
                    }
                }
            }
            
            
            box2.add(t3) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.top.equalTo(f2.snp.bottom).offset(8)
                }
            }
            
            box2.add(f3) { v in
                f3.backgroundColor = .init(hex: "#F4F8FF")
                f1.cornersSet(by: .allCorners, radius: 8)
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.height.equalTo(48)
                    make.right.equalToSuperview()
                    make.top.equalTo(t3.snp.bottom).offset(6)
                }
                
                f3.add(text3) { v in
                    v.snp.makeConstraints { make in
                        make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12))
                    }
                }
            }
            

            box2.add(t4) { v in
                t4.numberOfLines = 0
                v.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.top.equalTo(f3.snp.bottom).offset(8)
                    make.bottom.equalToSuperview()
                }
            }
            
        }
        
        box.add(button) { v in
            button.addTarget(self, action: #selector(pu), for: .touchUpInside)
            button.backgroundColor = .init(hex: "#5F85F4")
            v.cornersSet(by: .allCorners, radius: 25)
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(14)
                make.top.equalTo(box2.snp.bottom).offset(20)
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
        
        let p = UITapGestureRecognizer.init(target: self, action: #selector(bir))
        f3.addGestureRecognizer(p)
    }
    
    @objc func close(){
        dismiss(animated: false)
    }
  
    @objc func pu(){
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        
        viewModel.duels(avp: [m!.profusely![0].eyelid!:text1.text!,
                              m!.profusely![1].eyelid!:text2.text!,
                              m!.profusely![2].eyelid!:text3.text!,
                              "erect":pid!
                             ]) {[weak self] r in
            switch r {
            case .success(let success):
                SVProgressHUD.dismiss()
                self?.onHandle?()
                self?.dismiss(animated: true)
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
    
    @objc func bir(){
        let t = text3.text!
        let vc = YTBirthdaySelectorViewController.init(select:YTTools.convertToDate(from: text3.text ?? "") ?? YTTools.convertToDate(from: "01-01-2000"))
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
        vc.onHandleShow =  {[weak self] str in
            self?.text3.text = str
        }
    }

}
