//
//  YTProductFaceViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/21.
//

import UIKit
import SmartCodable
import AVFoundation
import Photos


class marchedFaceModel: SmartCodable {
    var marched: marchedFacesUBModel?
    required init(){}
}


class marchedFacesUBModel: SmartCodable {
    var doctor: String?
    var thou: String?
    var supper: String?
    var flushed: String?
    required init(){}
}




class YTProductFaceViewController: YTBaseViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let viewmodLE = ApiViewModel()
    
    var model: marchedFaceModel?
    
    var pid: String?
    
    var time: Date?
    
    var time2: Date?
    
    let topView = UIView()
    
    let la = UILabel.init(title: YTTools.areaTitle(a: "Don't worry, your information and data are protected", b: "Jangan khawatir, informasi dan data Anda dilindungi"),textColor: .init(hex: "#FFBA31"),font: .systemFont(ofSize: 13))
    
    let box1 = UIView()
    
    let bimae = UIImageView.init(image: UIImage.init(named: "Group 1788"))
    
    let box2 = UIView()
    
    let b2image = UIImageView.init(image: UIImage.init(named: "Group 1788(1)"))
    
    let b1 = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 16, weight: .bold))
    
    let b2 = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 16, weight: .bold))
    
    let b11 = UILabel.init(title: YTTools.areaTitle(a: "Please select the order you want to view", b: "Pilih pesanan yang ingin Anda lihat"),textColor: .init(hex: "#A4A4A4"),font: .systemFont(ofSize: 12))
    
    let b22 = UILabel.init(title: YTTools.areaTitle(a: "Please complete face recognition certification", b: "Harap Lengkapi Sertifikasi Pengakuan Wajah"),textColor: .init(hex: "#A4A4A4"),font: .systemFont(ofSize: 12))
    
    let button1 = UIButton.init(title: "", image: "Group 1789")
    
    let button2 = UIButton.init(title: "", image: "Group 1789")
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Next", b: "Berikutnya"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    let imagePicker = UIImagePickerController()
    
    var current: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.time = Date()
        
        view.backgroundColor = .white
        
        topView.cornersSet(by: .allCorners, radius: 8)
        
        setNavigationBarTitle(YTTools.areaTitle(a: "ldentity information", b: "Informasi identitas"))
        
        view.addSubview(topView)
        topView.backgroundColor = .init(hex: "#FFF5E0")
        topView.snp.makeConstraints { make in
            make.top.equalTo(cBar.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(14)
        }
        
        bimae.contentMode = .scaleAspectFill
        b2image.contentMode = .scaleAspectFill
        
        topView.addSubview(la)
        la.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10))
        }

        imagePicker.delegate = self
        
        
        view.addSubview(box1)
        view.addSubview(box2)
        
        box1.cornersSet(by: .allCorners, radius: 12)
        box2.cornersSet(by: .allCorners, radius: 12)
        
        box1.backgroundColor = .init(hex: "#F4F6F8")
        box2.backgroundColor = .init(hex: "#F4F6F8")
        box1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(14)
            make.top.equalTo(topView.snp.bottom).offset(40)
        }
        
        box2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(14)
            make.top.equalTo(box1.snp.bottom).offset(12)
        }
        
        
        bimae.cornersSet(by: .allCorners, radius: 12)
        b2image.cornersSet(by: .allCorners, radius: 12)
        box1.addSubview(bimae)
        box2.addSubview(b2image)
        
        b11.numberOfLines = 2
        b22.numberOfLines = 2
        b11.isHidden = true
        b22.isHidden = true
        
        bimae.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(13)
            make.top.bottom.equalToSuperview().inset(32)
            make.width.equalTo(156)
            make.height.equalTo(100)
        }
        
        b2image.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(13)
            make.top.bottom.equalToSuperview().inset(32)
            make.width.equalTo(156)
            make.height.equalTo(100)
        }

        
        box1.addSubview(b1)
        box2.addSubview(b2)
        box1.addSubview(b11)
        box2.addSubview(b22)
        
        b1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(bimae)
            make.right.equalTo(bimae.snp.right).offset(-14)
        }
        
        b2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(b2image)
            make.right.equalTo(bimae.snp.right).offset(-14)
        }
        
        b11.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(b1.snp.bottom).offset(4)
            make.right.equalTo(bimae.snp.left).offset(-14)
        }
        
        b22.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(b2.snp.bottom).offset(4)
            make.right.equalTo(bimae.snp.left).offset(-14)
        }
        
        box1.addSubview(button1)
        box2.addSubview(button2)
        
        button1.snp.makeConstraints { make in
            make.left.equalTo(b1)
            make.top.equalTo(b11.snp.bottom).offset(12)
        }
        
        button2.snp.makeConstraints { make in
            make.left.equalTo(b1)
            make.top.equalTo(b22.snp.bottom).offset(12)
        }
        
        
        button.addTarget(self, action: #selector(nextA), for: .touchUpInside)
        button.cornersSet(by: .allCorners, radius: 25)
        button.setBgColor(color: .init(hex: "#6D90F5"))
        view.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -20 : -39)
                make.height.equalTo(50)
            }
        }
        
        let t1 = UITapGestureRecognizer.init(target: self, action: #selector(takeFace))
        let t2 = UITapGestureRecognizer.init(target: self, action: #selector(takeBank))
        
        box1.isUserInteractionEnabled = true
        box2.isUserInteractionEnabled = true
        
        box1.addGestureRecognizer(t1)
        box2.addGestureRecognizer(t2)
        
        button1.isUserInteractionEnabled = false
        button2.isUserInteractionEnabled = false
        
        load()
       
        
    }
    
    
    func load(){
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        viewmodLE.fought(avp: ["erect": pid!]) {[weak self] re in
            switch re {
            case .success(let success):
                SVProgressHUD.dismiss()
                
                self?.b11.isHidden = false
                self?.b22.isHidden = false
                
                self?.model = success?.upper
                self?.b1.text = success?.upper?.marched?.doctor
                self?.b2.text = success?.upper?.marched?.supper
                  
                if let i1 = success?.upper?.marched?.thou,i1.count > 0  {
                    self?.bimae.sd_setImage(with: URL.init(string: i1),placeholderImage: UIImage.init(named: "Group 1788"))
                    self?.button1.isHidden = true
                }
                
                if let i2 = success?.upper?.marched?.flushed,i2.count > 0 {
                    self?.b2image.sd_setImage(with: URL.init(string: i2),placeholderImage: UIImage.init(named: "Group 1788(1)"))
                    self?.button2.isHidden = true
                }
                
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
  
    
    @objc func takeBank(){
        if let i1 = model?.marched?.thou,i1.count == 0  {
            current = 0
            let vc = YTProductFaceKTPViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.b1.text = model?.marched?.doctor
            present(vc, animated: false)
            vc.onKeluarButtonTapped = {[weak self] in
                self?.checkCameraPermission(type: 0)
            }
           return
        }
        
        if let i2 = model?.marched?.flushed,i2.count == 0 {
            current = 1
            let vc = YTProductFaceWJAViewController()
             vc.modalPresentationStyle = .overFullScreen
             vc.b1.text = model?.marched?.supper
             self.time2 = Date()
             present(vc, animated: false)
            vc.onKeluarButtonTapped = {[weak self] in
                self?.checkCameraPermission(type: 1)
            }
           return
        }
        
//        current = 1
//        let vc = YTProductFaceWJAViewController()
//         vc.modalPresentationStyle = .overFullScreen
//         vc.b1.text = model?.marched?.supper
//         self.time2 = Date()
//         present(vc, animated: false)
//        vc.onKeluarButtonTapped = {[weak self] in
//            self?.checkCameraPermission(type: 1)
//        }
    }
    
    @objc func takeFace(){
        if let i1 = model?.marched?.thou,i1.count == 0  {
            current = 0
            let vc = YTProductFaceKTPViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.b1.text = model?.marched?.doctor
            present(vc, animated: false)
            vc.onKeluarButtonTapped = {[weak self] in
                self?.checkCameraPermission(type: 0)
            }
           return
        }
        
        if let i2 = model?.marched?.flushed,i2.count == 0 {
            current = 1
            let vc = YTProductFaceWJAViewController()
            self.time2 = Date()
             vc.modalPresentationStyle = .overFullScreen
             vc.b1.text = model?.marched?.supper
             present(vc, animated: false)
            vc.onKeluarButtonTapped = {[weak self] in
                self?.checkCameraPermission(type: 1)
            }
           return
        }
        
//        current = 0
//        let vc = YTProductFaceKTPViewController()
//        vc.modalPresentationStyle = .overFullScreen
//        vc.b1.text = model?.marched?.doctor
//        present(vc, animated: false)
//        vc.onKeluarButtonTapped = {[weak self] in
//            self?.checkCameraPermission(type: 0)
//        }
    }

    @objc func nextA(){
        
        
        if let i1 = model?.marched?.thou,i1.count == 0  {
            current = 0
            let vc = YTProductFaceKTPViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.b1.text = model?.marched?.doctor
            present(vc, animated: false)
            vc.onKeluarButtonTapped = {[weak self] in
                self?.checkCameraPermission(type: 0)
            }
           return
        }
        
        if let i2 = model?.marched?.flushed,i2.count == 0 {
            current = 1
            let vc = YTProductFaceWJAViewController()
            self.time2 = Date()
             vc.modalPresentationStyle = .overFullScreen
             vc.b1.text = model?.marched?.supper
             present(vc, animated: false)
            vc.onKeluarButtonTapped = {[weak self] in
                self?.checkCameraPermission(type: 1)
            }
           return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func checkCameraPermission(type: Int) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // 已授权
            presentCameraViewController(type: type)
        case .notDetermined:
            // 请求授权
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.presentCameraViewController(type: type)
                    } else {
                        self.showPermissionAlert()
                    }
                }
            }
        case .denied, .restricted:
            showPermissionAlert()
        @unknown default:
            fatalError()
        }
    }

    
    func presentCameraViewController(type: Int) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.cameraDevice = type == 0 ? .rear : .front
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func showPermissionAlert() {
        let alert = UIAlertController(title: "Camera Permission Needed", message: "Please enable camera permission in settings to take photos.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })
        present(alert, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
//            if let i1 = model?.marched?.thou,i1.count == 0  {
//                uploadBankCard(with: image)
//                picker.dismiss(animated: true, completion: nil)
//                return
//            }
//            
//            if let i2 = model?.marched?.flushed,i2.count == 0 {
//                didUploadUserFace(with: image)
//                picker.dismiss(animated: true, completion: nil)
//            }
            
            if current == 0 {
                uploadBankCard(with: image)
                picker.dismiss(animated: true, completion: nil)
            } else {
                didUploadUserFace(with: image)
                picker.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uploadBankCard(with image: UIImage){
        let img = image.compressImage(maxLength: 1024*100)
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        viewmodLE.hands(avp: ["hope": img,"directly":"11","face":"1"]) {[weak self] r in
            switch r {
            case .success(let success):
                SVProgressHUD.dismiss()

                let vc = YTUserInfoAlertViewController()
                
                vc.pid = self?.pid
                
                vc.m = success?.upper
                
                vc.t1.text = success?.upper?.profusely?[0].advice
                
                vc.text1.text = success?.upper?.profusely?[0].parental ?? ""
                
                vc.t2.text = success?.upper?.profusely?[1].advice
                
                vc.text2.text = success?.upper?.profusely?[1].parental ?? ""
                
                vc.t3.text = success?.upper?.profusely?[2].advice
                
                vc.text3.text = success?.upper?.profusely?[2].parental ?? ""
                
                vc.t4.text = success?.upper?.garnished
                
                
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: false)
                
                vc.onHandle = { [weak self] in
                    
                    let data: [String: Any] = ["obliged": "2", "nasty": "\(((self?.time) ?? Date()).timeIntervalSince1970)","newcomers":"\(Date().timeIntervalSince1970)"]
                    NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: data)

                    
                    self?.load()
                }
                
                break
            case .failure(let failure):
                
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.showError(withStatus: failure.description)
                SVProgressHUD.dismiss(withDelay: 1.5)
               break
            }
        }
    }
    
    func didUploadUserFace(with image: UIImage){
        let img = image.compressImage(maxLength: 1024*100)
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        viewmodLE.hands(avp: ["hope": img,"directly":"10","face":"1"]) {[weak self] r in
            switch r {
            case .success(let success):
                SVProgressHUD.dismiss()
                let data: [String: Any] = ["obliged": "3", "nasty": "\(((self?.time2) ?? Date()).timeIntervalSince1970)","newcomers":"\(Date().timeIntervalSince1970)"]
                NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: data)
                self?.load()
                break
            case .failure(let failure):
                
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.showError(withStatus: failure.description)
                SVProgressHUD.dismiss(withDelay: 1.5)
               break
            }
        }
    }
    
    

}















































class YTProductFaceKTPViewController: YTBaseViewController {
    
    var onKeluarButtonTapped: (() -> Void)?
    
    let box = UIView()
    
    let b1 = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 22, weight: .bold))
    
    let b2 = UILabel.init(title: YTTools.areaTitle(a: "Please submit certification according to the example to avoid blurring, obstruction, and reflection", b: "Harap unggah foto sesuai dengan contoh untuk menghindari kabur"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
    
    let b2image = UIImageView.init(image: UIImage.init(named: "Group 1788"))
    
    let b3 = UILabel.init(title: YTTools.areaTitle(a: "Error sample", b: "Contoh kesalahan"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 16))
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Next", b: "Berikutnya"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    let b3image = UIImageView.init(image: UIImage.init(named: YTTools.areaTitle(a: "错误示范12323", b:"错误示范")))
    
    let clos = UIButton.init(title: "", image: "F12ffframe")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarBgHidden()
        setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = .init(hex: "000000",alpha: 0.5)
            
        box.backgroundColor = .white
        
        view.addSubview(box)
        box.cornersSet(by: [.topLeft,.topRight], radius: 22)
        box.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        box.addSubview(b1)
        b1.numberOfLines = 0
        b1.textAlignment = .center
        b1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(13)
        }
        
        box.addSubview(b2)
        b2.numberOfLines = 0
        b2.textAlignment = .center
        b2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(b1.snp.bottom).offset(40)
        }
        
        
        box.addSubview(b2image)
        b2image.snp.makeConstraints { make in
            make.width.equalTo(217)
            make.height.equalTo(139)
            make.centerX.equalToSuperview()
            make.top.equalTo(b2.snp.bottom).offset(36)
        }
        
        
        box.addSubview(b3)
        b3.textAlignment = .center
        b3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(b2image.snp.bottom).offset(40)
        }
        
        box.addSubview(b3image)
        b3image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(b3.snp.bottom).offset(20)
        }
        
        
        
        button.addTarget(self, action: #selector(nextA), for: .touchUpInside)
        button.cornersSet(by: .allCorners, radius: 25)
        button.setBgColor(color: .init(hex: "#6D90F5"))
        box.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -20 : -39)
                make.height.equalTo(50)
                make.top.equalTo(b3image.snp.bottom).offset(56)
            }
        }
        
        box.addSubview(clos)
        clos.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(b1)
            make.right.equalToSuperview().offset(-10)
        }
        
        clos.addTarget(self, action: #selector(cloasea), for: .touchUpInside)
    }
    
    
    @objc func nextA(){
      
        dismiss(animated: false)
        onKeluarButtonTapped?()
    }
    
    @objc func cloasea(){
   
        dismiss(animated: false)
    }
    
}


class YTProductFaceWJAViewController: YTBaseViewController {
    
    var onKeluarButtonTapped: (() -> Void)?
    
    let box = UIView()
    
    let b1 = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 22, weight: .bold))
    
    let b2 = UILabel.init(title: YTTools.areaTitle(a: "Please take a complete photo of yourself, avoiding blurring and not covering your face", b: "Silakan ambil foto diri Anda yang lengkap, hindari kabur dan tidak menutupi wajah Anda"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
    
    let b2image = UIImageView.init(image: UIImage.init(named: "Group 1791"))
    
    let b3 = UILabel.init(title: YTTools.areaTitle(a: "Error sample", b: "Contoh kesalahan"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 16))
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Next", b: "Berikutnya"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    let b3image = UIImageView.init(image: UIImage.init(named: YTTools.areaTitle(a: "Groupffffffw 33", b: "Group 33")))
    
    let clos = UIButton.init(title: "", image: "F12ffframe")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarBgHidden()
        setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = .init(hex: "000000",alpha: 0.5)
            
        box.backgroundColor = .white
        
        view.addSubview(box)
        box.cornersSet(by: [.topLeft,.topRight], radius: 22)
        box.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        box.addSubview(b1)
        b2.numberOfLines = 0
        b1.textAlignment = .center
        b1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(13)
        }
        
        box.addSubview(b2)
        b2.textAlignment = .center
        b2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(b1.snp.bottom).offset(40)
        }
        
        
        box.addSubview(b2image)
        b2image.snp.makeConstraints { make in
            make.width.equalTo(137)
            make.height.equalTo(149)
            make.centerX.equalToSuperview()
            make.top.equalTo(b2.snp.bottom).offset(36)
        }
        
        
        box.addSubview(b3)
        b3.textAlignment = .center
        b3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(b2image.snp.bottom).offset(40)
        }
        
        box.addSubview(b3image)
        b3image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(b3.snp.bottom).offset(20)
        }
        
        
        
        button.addTarget(self, action: #selector(nextA), for: .touchUpInside)
        button.cornersSet(by: .allCorners, radius: 25)
        button.setBgColor(color: .init(hex: "#6D90F5"))
        box.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -20 : -39)
                make.height.equalTo(50)
                make.top.equalTo(b3image.snp.bottom).offset(56)
            }
        }
        
        box.addSubview(clos)
        clos.snp.makeConstraints { make in
            make.width.height.equalTo(28)
            make.centerY.equalTo(b1)
            make.right.equalToSuperview().offset(-10)
        }
        
        clos.addTarget(self, action: #selector(cloasea), for: .touchUpInside)
    }
    
    
    @objc func nextA(){
       
        dismiss(animated: false)
        onKeluarButtonTapped?()
    }
    
    @objc func cloasea(){
     
        dismiss(animated: false)
    }
    
}



class FACEhandsModel: SmartCodable {
    var garnished: String?
    var profusely: [profuselyModel]?
    required init(){}
}

class profuselyModel: SmartCodable {
    var advice: String?
    var parental: String?
    var eyelid: String?
    required init(){}
}
