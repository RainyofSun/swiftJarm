

import UIKit






class YTLogin2ViewController: YTBaseViewController {
    
    let viewModel = ApiViewModel()
    
    var phone: UILabel = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 18, weight: .bold))
    
    let code = YTTextField()
    
    let voice = UIButton.init(title: "", image: "语音输入")
    
    let codeNumber = UIButton.init(title: "", font: .systemFont(ofSize: 14, weight: .bold), color: .init(hex: "#F9962F",alpha: 0.6))
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Login", b: "Masuk"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    let pvB = UIButton.init(title: "", image: "勾选")
    
    var time: Date?
    
    let uploadS = upapisServices()
    
    fileprivate var timer: Timer?
    
    fileprivate var rSeconds: Int = 60
    
    let close = UIButton.init(title: "", image: "bac")
    
    var l1: String?
    var l2: String?
    
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
                make.top.equalTo(phone.snp.bottom).offset(12)
                make.height.equalTo(52)
            }
            
            
            box.add(codeNumber) { v in
                v.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.right.equalToSuperview().offset(-12)
                    make.width.equalTo(90)
                }
            }
            
            code.font = .systemFont(ofSize: 14, weight: .bold)
            code.placeholder = YTTools.areaTitle(a: "Enter cell number", b: "Masukkan nomor sel")
            box.add(code) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(12)
                    make.top.bottom.equalToSuperview()
                    make.right.equalTo(codeNumber.snp.left).offset(-10)
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
        
        codeNumber.isUserInteractionEnabled = false
        
        
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
        
   
        
        let otherBox = UIView()
        bottomV.add(otherBox) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(button.snp.bottom).offset(10)
                make.bottom.equalTo(pV.snp.top).offset(-12)
            }
        }
        
        
        let t4 = UILabel.init(title: YTTools.areaTitle(a: "Reminder Your verifcation code is valid for 30 minutes. Please make sure it is operatedby yourself and do not share theverifcation code to others.", b: "Pengingat kode verifikasi Anda berlaku selama 30 menit. Pastikan itu dioperasikan sendiri dan jangan bagikan kode theverifcation kepada orang lain."),textColor: .init(hex: "#4A4A4A"),font: .systemFont(ofSize: 13))
        t4.textAlignment = .center
        otherBox.add(t4) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.centerX.centerY.equalToSuperview()
            }
        }
        
        let fullText = YTTools.areaTitle(a: "Reminder Your verifcation code is valid for 30 minutes. Please make sure it is operatedby yourself and do not share theverifcation code to others.", b: "Pengingat kode verifikasi Anda berlaku selama 30 menit. Pastikan itu dioperasikan sendiri dan jangan bagikan kode theverifcation kepada orang lain.")
        let privacyText = YTTools.areaTitle(a: "30 minutes", b: "30 menit")
        let attributedString = NSMutableAttributedString(string: fullText)
     
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.init(hex: "#F9962F"), range: (fullText as NSString).range(of: "30 menit"))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: (fullText as NSString).range(of: fullText))
        t4.attributedText = attributedString
        
        view.add(close) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(12)
                make.top.equalToSuperview().offset(56)
            }
        }
     
        close.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        codeNumber.addTarget(self, action: #selector(loadCode), for: .touchUpInside)
        
       
    }
    
    
    func start(){
        startCountdown()
    }
  
    @objc func closeView(){
        navigationController?.popViewController(animated: true)
    }
    
    // 语音
    @objc func voiceCode(){
        if (phone.text ?? "").isEmpty  {
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
                self?.time = Date()
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
                SVProgressHUD.showSuccess(withStatus: success?.lip.description ?? "")
                break
            case .failure(let error):
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
                SVProgressHUD.showError(withStatus: error.description)
                break
            }
        }
        
    }
    
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
    
    @objc func login(_ button: UIButton) {

    
        
        if let t = code.text,t.isEmpty,t.count == 0, !(phone.text ?? "").isEmpty  {
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.dismiss(withDelay: 1.5)
            
            
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter the verification code", b: "Silakan masukkan kode verifikasi"))
            
            return
        }
        
        if pvB.isSelected == false {
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.dismiss(withDelay: 1.5)
            
            
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please check the agreement", b: "Silakan periksa kesepakatan"))
            return
        }
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        if let result = phone.text!.components(separatedBy: " ").last {
            viewModel.eyelid(avp: ["arrogant":"\(result)",
                                   "offensive":"\(code.text!)"]) {[weak self] ree in
                switch ree {
                case .success(let success):
                    

                    YTUserDefaults.shared.transport = success?.upper?.transport ?? ""
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
                                SVProgressHUD.dismiss(withDelay: 1.5)
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
                    SVProgressHUD.setDefaultStyle(.dark)
                    SVProgressHUD.setDefaultMaskType(.clear)
                    SVProgressHUD.dismiss(withDelay: 1.5)
                    SVProgressHUD.showError(withStatus: error.description)
                    break
                }
            }
        }
        
        
    }
    
    
    @objc func loadCode(){
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        viewModel.suabian(avp: code.text!) {[weak self] ree in
            switch ree {
            case .success(let success):
                self?.codeNumber.isHidden = false
                self?.startCountdown()
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
                SVProgressHUD.showSuccess(withStatus: success?.lip.description ?? "")
                break
            case .failure(let error):
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
                SVProgressHUD.showError(withStatus: error.description)
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
    
    @objc func startCountdown() {
        rSeconds = 60
        updateButtonTitle()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        rSeconds -= 1
        updateButtonTitle()
        
        if rSeconds <= 0 {
            timer?.invalidate()
            timer = nil
            resetButton()
        }
    }
    
    func updateButtonTitle() {
        codeNumber.isUserInteractionEnabled = false
        codeNumber.setTitle(title: YTTools.areaTitle(a: "", b: "Sisa ") + "\(rSeconds)s")
    }
    
    func resetButton() {
        codeNumber.isUserInteractionEnabled = true
        codeNumber.setTitle(title: YTTools.areaTitle(a: "Retrieve Again", b: "Ambil Ulang"))
    }
}
