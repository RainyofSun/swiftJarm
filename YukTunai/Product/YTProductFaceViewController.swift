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
    var bigTitle = UILabel(title: "", textColor: UIColor.white, font: UIFont.boldSystemFont(ofSize: 40), alignment: .center)
    
    var pid: String?
    var t: String?
    
    var time: Date?
    
    var time2: Date?
    
    let box1 = UIImageView(image: UIImage(named: "tip_top"))
    
    let bimae = UIImageView.init(image: UIImage.init(named: "card_ff"))
    let bimae1 = UIImageView.init(image: UIImage.init(named: "camera_kk"))
    
    let box2 = UIImageView(image: UIImage(named: "tip_top"))
    
    let b2image = UIImageView.init(image: UIImage.init(named: "card_jj"))
    let bimae2 = UIImageView.init(image: UIImage.init(named: "camera_kk"))
    
    let b1 = UILabel.init(title: "",textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 16, weight: .bold))
    
    let b2 = UILabel.init(title: "",textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 16, weight: .bold))
    
    let button = {
        let view = GradientLoadingButton()
        view.setTitle(YTTools.areaTitle(a: "Next", b: "Berikutnya"))
        view.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        return view
    }()
    
    let imagePicker = UIImagePickerController()
    
    var current: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.time = Date()
        self.bigTitle.text = self.t
        self.view.backgroundColor = UIColor(hex: "#2864D7")
        
        setbgTopImgViewShow()
        self.setbgImgViewHidden()
        
        self.topBgImgView.add(self.bigTitle) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.width.equalToSuperview().dividedBy(2)
                make.top.equalToSuperview().offset(navigationBarHeight + statusBarHeight)
            }
        }
        
        bimae.contentMode = .scaleAspectFill
        b2image.contentMode = .scaleAspectFill
        bimae.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        b2image.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        
        imagePicker.delegate = self
        
        
        view.addSubview(box1)
        view.addSubview(box2)
        box1.addSubview(b1)
        box2.addSubview(b2)
        box1.addSubview(bimae)
        box2.addSubview(b2image)
        bimae.addSubview(bimae1)
        b2image.addSubview(bimae2)
        
        box1.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(bigTitle.snp.bottom).offset(32)
        }
        
        b1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(18)
        }
        
        bimae.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalTo(b1.snp.bottom).offset(25)
            make.height.equalTo((UIScreen.main.bounds.size.width - 30) * 0.52)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        bimae1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(54)
        }
        
        box2.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(box1.snp.bottom).offset(10)
        }
        
        b2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(18)
        }
        
        b2image.snp.makeConstraints { make in
            make.horizontalEdges.height.equalTo(bimae)
            make.top.equalTo(b2.snp.bottom).offset(25)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        bimae2.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(54)
        }
        
        button.addTarget(self, action: #selector(nextA), for: .touchUpInside)
        
        view.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(15)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -20 : -39)
                make.height.equalTo(48)
            }
        }
        
        let t1 = UITapGestureRecognizer.init(target: self, action: #selector(takeFace))
        let t2 = UITapGestureRecognizer.init(target: self, action: #selector(takeBank))
        
        box1.isUserInteractionEnabled = true
        box2.isUserInteractionEnabled = true
        
        box1.addGestureRecognizer(t1)
        box2.addGestureRecognizer(t2)
        
        load()
    }
    
    
    func load(){
        
        viewmodLE.fought(avp: ["erect": pid!]) {[weak self] re in
            switch re {
            case .success(let success):
                
                self?.model = success?.upper
                self?.b1.text = success?.upper?.marched?.doctor
                self?.b2.text = success?.upper?.marched?.supper
                  
                if let i1 = success?.upper?.marched?.thou,i1.count > 0  {
                    self?.bimae.sd_setImage(with: URL.init(string: i1),placeholderImage: UIImage.init(named: "Group 1788"))
                    self?.bimae1.image = UIImage(named: "auth_comslw")
                }
                
                if let i2 = success?.upper?.marched?.flushed,i2.count > 0 {
                    self?.b2image.sd_setImage(with: URL.init(string: i2),placeholderImage: UIImage.init(named: "Group 1788(1)"))
                    self?.bimae2.image = UIImage(named: "auth_comslw")
                }
                
                break
            case .failure(let failure):
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
            let vc = YTProductFaceKTPViewController()
             vc.modalPresentationStyle = .overFullScreen
             vc.b1.text = model?.marched?.supper
             self.time2 = Date()
             present(vc, animated: false)
            vc.onKeluarButtonTapped = {[weak self] in
                self?.checkCameraPermission(type: 1)
            }
           return
        }
    }
    
    @objc func takeFace(){
        if let i1 = model?.marched?.thou,i1.count == 0  {
            current = 0
            let vc = YTProductFaceKTPViewController()
            vc.t = t
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
            let vc = YTProductFaceKTPViewController()
            self.time2 = Date()
             vc.modalPresentationStyle = .overFullScreen
             vc.b1.text = model?.marched?.supper
            vc.showFace()
             present(vc, animated: false)
            vc.onKeluarButtonTapped = {[weak self] in
                self?.checkCameraPermission(type: 1)
            }
           return
        }
    }

    @objc func nextA(){
        
        
        if let i1 = model?.marched?.thou,i1.count == 0  {
            current = 0
            let vc = YTProductFaceKTPViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.b1.text = model?.marched?.doctor
            vc.t = t
            present(vc, animated: false)
            vc.onKeluarButtonTapped = {[weak self] in
                self?.checkCameraPermission(type: 0)
            }
           return
        }
        
        if let i2 = model?.marched?.flushed,i2.count == 0 {
            current = 1
            let vc = YTProductFaceKTPViewController()
            self.time2 = Date()
             vc.modalPresentationStyle = .overFullScreen
             vc.b1.text = model?.marched?.supper
            vc.showFace()
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
            present(imagePicker, animated: true) {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func showPermissionAlert() {
        SVProgressHUD.dismiss()
        GuideAlert.show(self, alertType: AlertType_Camera)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
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
        let img = image.compressImage(maxLength: 1024*500)
        SVProgressHUD.show()
        viewmodLE.hands(avp: ["hope": img,"directly":"11","face":"1"]) {[weak self] r in
            SVProgressHUD.dismiss()
            switch r {
            case .success(let success):
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
                SVProgressHUD.showError(withStatus: failure.description)
               break
            }
        }
    }
    
    func didUploadUserFace(with image: UIImage){
        let img = image.compressImage(maxLength: 1024*500)
        viewmodLE.hands(avp: ["ourProfiles": img,"directly":"10","face":"1"]) {[weak self] r in
            switch r {
            case .success(let success):
                let data: [String: Any] = ["obliged": "3", "nasty": "\(((self?.time2) ?? Date()).timeIntervalSince1970)","newcomers":"\(Date().timeIntervalSince1970)"]
                NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: data)
                self?.load()
                break
            case .failure(let failure):
                SVProgressHUD.showError(withStatus: failure.description)
                
               break
            }
        }
    }
}

class YTProductFaceKTPViewController: YTBaseViewController {
    
    var onKeluarButtonTapped: (() -> Void)?
    var t: String?
    
    let topimshw = UIImageView(image: UIImage(named: "auth_top_skw"))
    let box = UIImageView(image: UIImage(named: "tip_top"))
    
    let b1 = UILabel.init(title: "",textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 16, weight: .bold))
    
    let b2 = UILabel.init(title: YTTools.areaTitle(a: "Please the PAN card on a flat surface to avoid reflection or shading", b: "Letakkan kartu KTP pada permukaan yang datar untuk menghindari pantulan atau bayangan"),textColor: .init(hex: "#ffffff"),font: .systemFont(ofSize: 14))
    
    let b2image = UIImageView.init(image: UIImage.init(named: "card_ff"))
    let b2image1 = UIImageView.init(image: UIImage.init(named: "auth_comslw"))
    
    let button = {
        let view = GradientLoadingButton(frame: CGRectZero)
        view.setTitle(YTTools.areaTitle(a: "Next", b: "Berikutnya"))
        view.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        return view
    }()
    
    let b3image = UIImageView.init(image: UIImage.init(named: YTTools.areaTitle(a: "error3", b:"error1")))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarTitle(t ?? "")
        self.setbgImgViewHidden()
        self.view.backgroundColor = UIColor(hex: "#2864D7")
        
        self.view.add(topimshw) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.top.equalToSuperview()
            }
        }
        
        view.addSubview(box)
        box.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(topimshw.snp.bottom).offset(-25 )
        }
        
        box.addSubview(b1)
        b1.numberOfLines = 0
        b1.textAlignment = .center
        b1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        box.addSubview(b2image)
        b2image.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalTo(b1.snp.bottom).offset(25)
            make.height.equalTo((UIScreen.main.bounds.size.width - 30) * 0.52)
        }
        
        b2image.add(b2image1) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
            }
        }
        
        b2.numberOfLines = 0
        b2.textAlignment = .center
        box.addSubview(b2)
        
        b2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.top.equalTo(b2image.snp.bottom).offset(20)
        }
        
        box.addSubview(b3image)
        b3image.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(b2image)
            make.top.equalTo(b2.snp.bottom).offset(20)
            make.height.equalTo((UIScreen.main.bounds.size.width - 30) * 0.29)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        button.addTarget(self, action: #selector(nextA), for: .touchUpInside)
        self.view.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(15)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -20 : -39)
                make.height.equalTo(48)
            }
        }
    }
    
    override func bTapped() {
        dismiss(animated: false)
    }
    
    func showFace() {
        b2.text = YTTools.areaTitle(a: "Please take a photo with a clean and bright background.", b: "Harap mengambil foto dengan latar belakang yang bersih dan terang")
        b2image.image = UIImage(named: "card_jj")
        b3image.image = UIImage.init(named: YTTools.areaTitle(a: "error4", b:"error2"))
    }
    
    @objc func nextA(){
        SVProgressHUD.show()
        dismiss(animated: false)
        onKeluarButtonTapped?()
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
