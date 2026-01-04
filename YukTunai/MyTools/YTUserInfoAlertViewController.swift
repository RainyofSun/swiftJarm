//
//  YTUserInfoAlertViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/21.
//

import UIKit

class YTUserInfoAlertViewController: YTBaseViewController {
    
    let viewModel = ApiViewModel()
    
    var bigTitle = UILabel(title: "", textColor: UIColor.white, font: UIFont.boldSystemFont(ofSize: 40), alignment: .center)
    
    var pid: String?
    var t: String?
    
    var m: FACEhandsModel?
    
    var onHandle:(()->Void)?
    
    let button = {
        let view = GradientLoadingButton()
        view.setTitle(YTTools.areaTitle(a: "Confirmation", b: "Konfirmasi"))
        view.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        return view
    }()
    
    let t1 = UILabel.init(title: YTTools.areaTitle(a: "Full Name", b: "Nama Lengkap"),textColor: .init(hex: "#919191"),font: .systemFont(ofSize: 14))
    
    let t2 = UILabel.init(title: YTTools.areaTitle(a: "ID NO.", b: "Nama Lengkap"),textColor: .init(hex: "#919191"),font: .systemFont(ofSize: 14))
    
    let t3 = UILabel.init(title: YTTools.areaTitle(a: "Birthday", b: "Hari ulang tahun"),textColor: .init(hex: "#919191"),font: .systemFont(ofSize: 14))
    
    let f1 = UIView()
    let f2 = UIView()
    let f3 = UIView()
    
    let text1 = YTTextField()
    let text2 = YTTextField()
    let text3 = YTTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bigTitle.text = self.t
        self.view.backgroundColor = UIColor(hex: "#2864D7")
        setbgTopImgViewShow()
        self.setbgImgViewHidden()
        
        self.topBgImgView.add(self.bigTitle) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().dividedBy(2)
                make.top.equalToSuperview().offset(105)
            }
        }
        
        text1.font = .systemFont(ofSize: 18,weight: .semibold)
        text2.font = .systemFont(ofSize: 18,weight: .semibold)
        text3.font = .systemFont(ofSize: 18,weight: .semibold)
        
        text1.keyboardType = .asciiCapable
        text2.keyboardType = .asciiCapable
        text3.delegate = self
        
        text1.placeholder = YTTools.areaTitle(a: "please input", b: "Sila masukkan")
        text2.placeholder = YTTools.areaTitle(a: "please input", b: "Sila masukkan")
        text3.placeholder = YTTools.areaTitle(a: "please input", b: "Sila masukkan")
        
        text1.borderStyle = .none
        text2.borderStyle = .none
        text3.borderStyle = .none
        
        let box = UIView()
        box.backgroundColor = UIColor(hex: "#EAF5FF")
        box.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        
        let box1 = UIView()
        box1.backgroundColor = UIColor(hex: "#EAF5FF")
        box1.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        
        let box2 = UIView()
        box2.backgroundColor = UIColor(hex: "#EAF5FF")
        box2.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        
        box.add(t1) { v in
            v.snp.makeConstraints { make in
                make.top.left.equalToSuperview().offset(15)
            }
        }
        
        box.add(text1) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalTo(t1.snp.bottom).offset(8)
                make.height.equalTo(45)
                make.bottom.equalToSuperview().offset(-8)
            }
        }
        
        box1.add(t2) { v in
            v.snp.makeConstraints { make in
                make.left.top.equalToSuperview().offset(15)
            }
        }
        
        box1.add(text2) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalTo(t2.snp.bottom).offset(8)
                make.height.equalTo(45)
                make.bottom.equalToSuperview().offset(-8)
            }
        }
        
        box2.add(t3) { v in
            v.snp.makeConstraints { make in
                make.left.top.equalToSuperview().offset(15)
            }
        }
        
        box2.add(text3) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalTo(t3.snp.bottom).offset(8)
                make.height.equalTo(45)
                make.bottom.equalToSuperview().offset(-8)
            }
        }
        
        self.view.add(box) { v in
            v.snp.makeConstraints { make in
                make.top.equalTo(self.bigTitle.snp.bottom).offset(34)
                make.horizontalEdges.equalToSuperview().inset(20)
            }
        }
        
        self.view.add(box1) { v in
            v.snp.makeConstraints { make in
                make.top.equalTo(box.snp.bottom).offset(10)
                make.horizontalEdges.equalTo(box)
            }
        }
        
        self.view.add(box2) { v in
            v.snp.makeConstraints { make in
                make.top.equalTo(box1.snp.bottom).offset(10)
                make.horizontalEdges.equalTo(box1)
            }
        }
        
        self.view.add(button) { v in
            button.addTarget(self, action: #selector(pu), for: .touchUpInside)
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalTo(box2)
                make.height.equalTo(48)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -20 : -39)
            }
        }
    }
    
    override func bTapped() {
        dismiss(animated: false)
    }
  
    @objc func pu(){
        
        viewModel.duels(avp: [m!.profusely![0].eyelid!:text1.text!,
                              m!.profusely![1].eyelid!:text2.text!,
                              m!.profusely![2].eyelid!:text3.text!,
                              "erect":pid!
                             ]) {[weak self] r in
            switch r {
            case .success(let success):
                
                self?.onHandle?()
                self?.dismiss(animated: true)
                break
            case .failure(let failure):
                
                
                
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

extension YTUserInfoAlertViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        bir()
        return false
    }
}
