

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
    
    let phoneView: loginPhonView = loginPhonView(frame: CGRectZero)
    let codeView: loginCodeView = loginCodeView(frame: CGRectZero)
    
    let voice = UIButton.init(title: LocalizationManager.shared().localizedString(forKey: "login_v_voice"), image: "login_voi")
    
    let pvB = UIButton.init(title: "", image: "pro_sel")
    
    let close = UIButton.init(title: "", image: "sett_arr")
    let button = GradientLoadingButton()
    var l1: String?
    var l2: String?
    let uploadS = upapisServices()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        YTLocationHelper.sharedInstance().requestLocation(withTimeout: 15) {[weak self] location, error in
            if let location = location {
                let geocoder = CLGeocoder.init()
                geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                    guard let self = self else { return }
                    self.l1 = YTLocationHelper.sharedInstance().latitude(from: location)
                    self.l2 = YTLocationHelper.sharedInstance().longitude(from: location)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.time = Date()
        setBarBgHidden()
        setNavigationBarHidden(true, animated: true)
        
        button.setTitle(LocalizationManager.shared().localizedString(forKey: "login_btn"))
        phoneView.phoneText.keyboardType = .numberPad
        codeView.codeText.keyboardType = .numberPad
        close.imageView?.transform = CGAffineTransform(rotationAngle: Double.pi)
        
        let logoIms = UIImageView(image: UIImage(named: "login_logo"))
        
        view.add(logoIms) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(YTTools.isIPhone6Series() ? 80 : 144)
            }
        }
        
        let bottomV = UIView.init(bgColor: .clear)
        
        view.add(bottomV) { v in
            v.snp.makeConstraints { make in
                make.left.right.bottom.equalToSuperview()
                make.top.equalTo(logoIms.snp.bottom).offset(YTTools.isIPhone6Series() ? 60 : 60)
            }
        }
        
        
        bottomV.add(phoneView) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(20)
                make.horizontalEdges.equalToSuperview().inset(30)
                make.height.equalTo(48)
            }
        }
        
        bottomV.add(codeView) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.height.equalTo(phoneView)
                make.top.equalTo(phoneView.snp.bottom).offset(8)
            }
        }
        
        
        voice.addTarget(self, action: #selector(voiceCode), for: .touchUpInside)
        bottomV.add(voice) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(codeView.snp.bottom).offset(16)
            }
        }
        
        let pV = UIView()
        
        
        pvB.isSelected = true
        
        let protocolLable = UILabel(title: "",textColor: .init(hex: "#A2A2A2"),font: .systemFont(ofSize: 12))
        
        bottomV.add(pV) { v in
            v.snp.makeConstraints { make in
                make.top.equalTo(voice.snp.bottom).offset(40)
                make.left.right.equalToSuperview().inset(30)
            }
            
            pV.add(pvB) { v in
                pvB.addTarget(self, action: #selector(check), for: .touchUpInside)
                pvB.isSelected = true
                pvB.setImage(image: "pro_sel")
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
                attributedString.addAttribute(.foregroundColor, value: UIColor.init(hex: "#FEC95D"), range: privacyRange)
                
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
      
        codeView.countdownBtn.addTarget(self, action: #selector(smsCode), for: .touchUpInside)
        
        button.cornersSet(by: .allCorners, radius: 8)
        bottomV.add(button) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalTo(phoneView)
                make.top.equalTo(pV.snp.bottom).offset(20)
                make.height.equalTo(48)
            }
        }
        
        view.add(close) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(25)
                make.top.equalToSuperview().offset(YTTools.isIPhone6Series() ? 30 : 56)
            }
        }
    
        close.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.addTarget(self, action: #selector(login), for: UIControl.Event.touchUpInside)
        
        if !YTUserDefaults.shared.arrogant.isEmpty {
            phoneView.phoneText.text = YTUserDefaults.shared.arrogant
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if phoneView.phoneText.canBecomeFirstResponder {
            phoneView.phoneText.becomeFirstResponder()
        }
    }
    
    @objc func closeView(){
        codeView.countdownBtn.stop()
        dismiss(animated: true)
    }
    
    // 语音
    @objc func voiceCode(){
        if let t = phoneView.phoneText.text,t.isEmpty,t.count == 0  {
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter your mobile phone number", b: "Silakan masukkan nomor ponsel Anda"))
            return
        }
        
        viewModel.dexterous(avp: phoneView.phoneText.text!) {[weak self] ree in
            switch ree {
            case .success(let success):
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    if self?.codeView.codeText.canBecomeFirstResponder == true {
                        self?.codeView.codeText.becomeFirstResponder()
                    }
                })
                SVProgressHUD.showSuccess(withStatus: success?.lip.description ?? "")
                
                break
            case .failure(let error):
                
                SVProgressHUD.showInfo(withStatus: error.description)
                break
            }
        }
       
        
    }
    
    @objc func smsCode(_ button: CountdownButton) {

        if let t = phoneView.phoneText.text,t.isEmpty,t.count == 0 {
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter your mobile phone number", b: "Silakan masukkan nomor ponsel Anda"))
            return
        }
        
        viewModel.suabian(avp: phoneView.phoneText.text!) {[weak self] ree in
            switch ree {
            case .success(let success):
                button.start()
                SVProgressHUD.showInfo(withStatus: success?.lip.description ?? "")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
                    if self?.codeView.codeText.canBecomeFirstResponder == true {
                        self?.codeView.codeText.becomeFirstResponder()
                    }
                })
                break
            case .failure(let error):
                SVProgressHUD.showInfo(withStatus: error.description)
                break
            }
        }

    }
    
    @objc func login(_ button: UIButton) {

        if let t = phoneView.phoneText.text,t.isEmpty,t.count == 0 {
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter your mobile phone number", b: "Silakan masukkan nomor ponsel Anda"))
            
            return
        }
        
        if let t = codeView.codeText.text,t.isEmpty,t.count == 0  {
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter the verification code", b: "Silakan masukkan kode verifikasi"))
            return
        }
        
        if pvB.isSelected == false {
            
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please read and agree to the terms of this agreement first.", b: "Harap baca dan setujui ketentuan perjanjian ini terlebih dahulu."))
            return
        }
        
        if let result = phoneView.phoneText.text!.components(separatedBy: " ").last {
            viewModel.eyelid(avp: ["arrogant":"\(result)",
                                   "offensive":"\(codeView.codeText.text!)"]) {[weak self] ree in
                switch ree {
                case .success(let success):
                    

                    YTUserDefaults.shared.transport = success?.upper?.transport ?? ""
                    YTUserDefaults.shared.arrogant = success?.upper?.arrogant ?? ""
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginOK"), object: nil,userInfo: nil)
                    
                    
                    var upInfo = ["dialect":YTIDFVKeychainHelper.retrieveIDFV(),
                                  "forward":"2",
                                  "mustaches":self?.l2 ?? "",
                                  "smooth":self?.l1 ?? "",
                                  "called":ASIdentifierManager.shared().advertisingIdentifier.uuidString]
                    
                   
                       let a = "1"
                       let b = "\(((self?.time) ?? Date()).timeIntervalSince1970)"
                       let c = "\(Date().timeIntervalSince1970)"
                        upInfo["obliged"] = a
                        upInfo["nasty"] = b
                        upInfo["newcomers"] = c
                        
                        self?.uploadS.tumult(avp: upInfo) { r in
                            switch r {
                            case .success(let success):
                                
                                SVProgressHUD.showSuccess(withStatus: success?.lip.description ?? "")
                                print("shang bao maidian chenggong ------------shang bao weizhi maidian chenggong ------------shang bao weizhi maidian chenggong ------------ ")
                                self?.dismiss(animated: true, completion: {
                                })
                                break
                            case .failure(let failure):
                               
                                print("shang bao weizhi maidian chu cuo ------------ ")
                                break
                            }
                        }
                    
                
                    
                   
                    break
                case .failure(let error):
                    
                    
    
                    SVProgressHUD.showError(withStatus: error.description)
                    break
                }
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
        button.setImage(image: button.isSelected ? "pro_sel" : "pro_nor")
        button.isSelected = !button.isSelected
    }
}
