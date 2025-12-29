

import UIKit



class YTTextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}

extension UITextField {
    
    func setTextField(textColor: String, font:CGFloat, weight: UIFont.Weight, alignment: NSTextAlignment, placeHolderText: String, style: UITextField.BorderStyle) {
        self.textColor = .init(hex: textColor)
        self.font = UIFont.systemFont(ofSize: font, weight: weight)
        self.textAlignment = alignment
        self.placeholder = placeHolderText
        self.borderStyle = style
    }
}









class YTLoginViewController: YTBaseViewController {
    
    let viewModel = ApiViewModel()
    
    var time: Date?
    
    let code = YTTextField()
    
    let voice = UIButton.init(title: "", image: "语音输入")

    let button = UIButton.init(title: YTTools.areaTitle(a: "Get code", b: "Ambil kode"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    let pvB = UIButton.init(title: "", image: "勾选")
    
    let close = UIButton.init(title: "", image: "bac")
    
    var phone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .init(hex: "#7395F5")
        
        setBarBgHidden()
        setNavigationBarHidden(true, animated: true)
        
        let image = UIImageView.init(image: UIImage.init(named: "Frame 308"))
        view.add(image) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(statusBarHeight+17)
                make.left.right.equalToSuperview()
            }
        }
        
        code.keyboardType = .numberPad
        
        let t1 = UILabel.init(title: YTTools.areaTitle(a: "Hello!", b: "Halo!"),textColor: .white,font: .systemFont(ofSize: 40))
        view.add(t1) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(24)
                make.top.equalTo(cBar.snp.bottom).offset(12)
            }
        }
        
        
        let t2 = UILabel.init(title:YTTools.areaTitle(a: "Welcome to YukTunai", b: "Selamat datang di YukTunai"),textColor: .white,font: .systemFont(ofSize: 16))
        view.add(t2) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(24)
                make.top.equalTo(t1.snp.bottom)
            }
        }
        
        let bottomV = UIView.init(bgColor: .white)
        bottomV.cornersSet(by: [.topLeft,.topRight], radius: 22)
        view.add(bottomV) { v in
            v.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(image.snp.bottom).offset(YTTools.isIPhone6Series() ? -80 : -54)
            }
        }
        
        
        phone = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 18, weight: .bold))
        bottomV.add(phone) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(40)
                make.top.equalToSuperview().offset(27)
            }
        }
        
        
        let box = UIView.init(bgColor: .init(hex: "#F4F8FF"))
        box.cornersSet(by: .allCorners, radius: 16)
        bottomV.add(box) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(40)
                make.top.equalTo(phone!.snp.bottom).offset(12)
                make.height.equalTo(52)
            }
            
            
           
            
            code.font = .systemFont(ofSize: 14, weight: .bold)
            code.placeholder = YTTools.areaTitle(a: "Enter cell number", b: "Masukkan nomor sel")
            box.add(code) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(12)
                    make.top.bottom.equalToSuperview()
                    make.right.equalToSuperview()
                }
            }
            
        }
        
        
        voice.addTarget(self, action: #selector(voiceCode), for: .touchUpInside)
        bottomV.add(voice) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(box.snp.bottom).offset(16)
            }
        }
        
      
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.cornersSet(by: .allCorners, radius: 25)
        button.setBgColor(color: .init(hex: "#6D90F5"))
        bottomV.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(40)
                make.top.equalTo(voice.snp.bottom).offset(39)
                make.height.equalTo(50)
            }
        }
        
        view.add(close) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(12)
                make.top.equalToSuperview().offset(56)
            }
        }
        
        
        let pV = UIView()
        
        
        pvB.isSelected = true
        
        let protocolLable = UILabel(title: "",textColor: .init(hex: "#A2A2A2"),font: .systemFont(ofSize: 12))
        
        bottomV.add(pV) { v in
            v.snp.makeConstraints { make in
                make.bottom.equalToSuperview().offset(-44)
                make.left.right.equalToSuperview().inset(30)
            }
            
            pV.add(pvB) { v in
                pvB.addTarget(self, action: #selector(check), for: .touchUpInside)
                pvB.isSelected = true
                pvB.setImage(image: "勾选12212")
                v.snp.makeConstraints { make in
                    make.top.bottom.left.equalToSuperview()
                }
            }
            
            pV.add(protocolLable) { v in
                protocolLable.isUserInteractionEnabled = true
                // 创建富文本字符串
                let fullText = YTTools.areaTitle(a: "I've read and agreed with <Privacy Agreement>", b: "Saya sudah membaca dan setuju dengan <Perjanjian Privasi>")
                let privacyText = YTTools.areaTitle(a: "<Privacy Agreement>", b: "<Perjanjian Privasi>")
                let attributedString = NSMutableAttributedString(string: fullText)
                let privacyRange = (fullText as NSString).range(of: privacyText)
                
                attributedString.addAttribute(.foregroundColor, value: UIColor.init(hex: "#999999"), range: (fullText as NSString).range(of: "<Privacy Agreement>"))
                attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: (fullText as NSString).range(of: fullText))
                // 设置下划线和颜色
                attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: privacyRange)
                attributedString.addAttribute(.foregroundColor, value: UIColor.init(hex: "#0E6DFD"), range: privacyRange)
                
                protocolLable.attributedText = attributedString
                v.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview()
                    make.height.equalTo(56)
                    make.left.equalTo(pvB.snp.right).offset(10)
                }
            }
            
            let protocolGestrue = UITapGestureRecognizer(target: self, action: #selector(protocola))
            v.addGestureRecognizer(protocolGestrue)
            
        }
    
        close.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    
    }
    
    @objc func closeView(){
        dismiss(animated: true)
    }
    
    // 语音
    @objc func voiceCode(){
        if let t = code.text,t.isEmpty,t.count == 0  {
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter your mobile phone number", b: "Silakan masukkan nomor ponsel Anda"))
            SVProgressHUD.dismiss(withDelay: 1.5)
            return
        }
        
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        viewModel.dexterous(avp: code.text!) {[weak self] ree in
            switch ree {
            case .success(let success):
               
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
               
                
                let v2 = YTLogin2ViewController()
                v2.phone.text = "\(YTUserDefaults.shared.gash == "1" ? "+91" : "+62") " + (self?.code.text)!
                v2.time = Date()
                self?.navigationController?.pushViewController(v2, animated: true)
                
                SVProgressHUD.showSuccess(withStatus: success?.lip.description ?? "")
                
                break
            case .failure(let error):
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
                SVProgressHUD.showInfo(withStatus: error.description)
                break
            }
        }
       
        
    }
    
    @objc func login(_ button: UIButton) {

        if let t = code.text,t.isEmpty,t.count == 0 {
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.dismiss(withDelay: 1.5)
            
            
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter your mobile phone number", b: "Silakan masukkan nomor ponsel Anda"))
            
            return
        }
        
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        viewModel.suabian(avp: code.text!) {[weak self] ree in
            switch ree {
            case .success(let success):

                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
                
                let v2 = YTLogin2ViewController()
                v2.time = Date()
                v2.phone.text = "\(YTUserDefaults.shared.gash == "1" ? "+91" : "+62") " + (self?.code.text)!
                v2.start()
                self?.navigationController?.pushViewController(v2, animated: true)
                
                SVProgressHUD.showInfo(withStatus: success?.lip.description ?? "")
                break
            case .failure(let error):
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
                SVProgressHUD.showInfo(withStatus: error.description)
                break
            }
        }

    }
    

    @objc func protocola(gesture: UITapGestureRecognizer){
        
        let b = "https://sheth-fincap.com/Yuk.html"
        if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: b)?.absoluteString {
            let webView = YTWebViewController.init(url: b)
            navigationController?.pushViewController(webView, animated: true)
        }

    }

    
    @objc func check(_ button: UIButton) {
        button.setImage(image: button.isSelected ? "勾选" : "勾选12212")
        button.isSelected = !button.isSelected
    }

   
}
