//
//  YTSettingViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit


class YTSettingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        cornersSet(by: .allCorners, radius: 16)
        
        let image = UIImageView.init(image: UIImage.init(named: "FEWFEWFWE"))
        add(image) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(28)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(12)
            }
        }
        
        
        let t2 = UILabel.init(title:  YTTools.areaTitle(a: "Version", b: "Versi"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
        add(t2) { v in
            v.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(image.snp.right).offset(14)
            }
        }
        
        let t3 = UILabel.init(title: "V1.0",textColor: .init(hex: "#5F85F4"),font: .systemFont(ofSize: 16))
        add(t3) { v in
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(24)
                make.centerY.equalToSuperview()
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




class YTSettingView2: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        cornersSet(by: .allCorners, radius: 16)
        
        let image = UIImageView.init(image: UIImage.init(named: "FSV1"))
        add(image) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(28)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(12)
            }
        }
        
        
        let t2 = UILabel.init(title: YTTools.areaTitle(a: "Account cancellation", b: "Pembatalan akun"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
        add(t2) { v in
            v.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(image.snp.right).offset(14)
            }
        }
        
        let image2 = UIImageView.init(image: UIImage.init(named: "FWFW12323"))
        add(image2) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(20)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-19)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class YTSettingView3: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        cornersSet(by: .allCorners, radius: 16)
        
        let image = UIImageView.init(image: UIImage.init(named: "FWEFB12232444"))
        add(image) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(28)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(12)
            }
        }
        
        
        let t2 = UILabel.init(title: YTTools.areaTitle(a: "Logout", b: "Keluar"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
        add(t2) { v in
            v.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(image.snp.right).offset(14)
            }
        }
        
        let image2 = UIImageView.init(image: UIImage.init(named: "FWFW12323"))
        add(image2) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(20)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-19)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




class YTSettingViewController: YTBaseViewController {
    
    let viewModel = ApiViewModel()
    
    var model: victoriousModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarTitle( YTTools.areaTitle(a: "Settings", b: "Pengaturan"))
        
        view.backgroundColor = .init(hex: "#F2F4F4")
        
        let image = UIImageView.init(image: UIImage.init(named: "image 26"))
        view.add(image) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(128)
                make.top.equalToSuperview().offset(statusBarHeight+108)
                make.centerX.equalToSuperview()
            }
        }
        
        
        let v1 = YTSettingView()
        view.add(v1) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(13)
                make.height.equalTo(52)
                make.top.equalTo(image.snp.bottom).offset(45)
            }
        }
        
        
        let v2 = YTSettingView2()
        view.add(v2) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(13)
                make.height.equalTo(52)
                make.top.equalTo(v1.snp.bottom).offset(10)
            }
        }
        
        
        let v3 = YTSettingView3()
        view.add(v3) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(13)
                make.height.equalTo(52)
                make.top.equalTo(v2.snp.bottom).offset(10)
            }
        }
        
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(add1))
        v2.isUserInteractionEnabled = true
        v2.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(add2))
        v3.isUserInteractionEnabled = true
        v3.addGestureRecognizer(tap3)
        
    }
    
    
    
    @objc func add1(){
        let popupVC = YTFullScreenPopupViewController()
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.titleText = model?.downward ?? ""
        popupVC.descriptionText = model?.drawn ?? ""
        popupVC.provisionText = model?.hit ?? ""
        popupVC.agreementText = model?.succession ?? ""
        popupVC.buttonText = YTTools.areaTitle(a: "Account cancellation", b: "Pembatalan akun")
        present(popupVC, animated: false, completion: nil)
        
        
        popupVC.onKeluarButtonTapped = {[weak self] in
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.show()
            self?.viewModel.bottles(completion: { res in
                switch res {
                case .success(let success):
                    SVProgressHUD.dismiss()
                    YTUserDefaults.shared.transport = ""
                    NotificationCenter.default.post(name:Notification.Name("logout"),object: nil)
                    self?.navigationController?.popToRootViewController(animated: false)
                    let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
                    tabBar?.selectedIndex = 1
                    break
                case .failure(let failure):
                    SVProgressHUD.showError(withStatus: failure.description)
                    SVProgressHUD.dismiss(withDelay: 1.5)
                    SVProgressHUD.setDefaultStyle(.dark)
                    SVProgressHUD.setDefaultMaskType(.clear)
                }
            })
          
        }

    }
    
    @objc func add2(){
        let popupVC = FullScreenPopupViewController()
        popupVC.modalPresentationStyle = .overFullScreen

        // 设置回调
        popupVC.onKeluarButtonTapped = {[weak self] in
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.show()
            self?.viewModel.lip(completion: { res in
                switch res {
                case .success(let success):
                    SVProgressHUD.dismiss()
                    YTUserDefaults.shared.transport = ""
                    NotificationCenter.default.post(name:Notification.Name("logout"),object: nil)
                    self?.navigationController?.popToRootViewController(animated: false)
                    let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
                    tabBar?.selectedIndex = 1
                    break
                case .failure(let failure):
                    SVProgressHUD.showError(withStatus: failure.description)
                    SVProgressHUD.dismiss(withDelay: 1.5)
                    SVProgressHUD.setDefaultStyle(.dark)
                    SVProgressHUD.setDefaultMaskType(.clear)
                }
            })
          
        }

        // 展示弹窗
        present(popupVC, animated: false, completion: nil)
    }

   

}



import UIKit
import SnapKit

class FullScreenPopupViewController: UIViewController {
    
    // 回调闭包，用于通知外部
    var onKeluarButtonTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // 设置背景色
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        // 添加主容器视图
        let popupView = UIView()
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 16
        popupView.layer.masksToBounds = true
        view.addSubview(popupView)
        popupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(300)
        }
        
        // 添加图片
        let imageView = UIImageView(image: UIImage(named: "fewewfwefwefw")) // 替换为实际图片名称
        imageView.contentMode = .scaleAspectFit
        popupView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(262)
        }
        
        // 添加标题
        let titleLabel = UILabel()
        titleLabel.text = YTTools.areaTitle(a: "Logout", b: "Keluar")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        popupView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(140)
            make.centerX.equalToSuperview()
        }
        
        // 添加描述
        let descriptionLabel = UILabel()
        descriptionLabel.text = YTTools.areaTitle(a: "Are you sure you want to logout this application?", b: "Apakah Anda benar –benar pergi?")
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .red
        descriptionLabel.numberOfLines = 0
        popupView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        // 添加按钮
        let button = UIButton(type: .system)
        button.setTitle(YTTools.areaTitle(a: "Exit", b: "Keluar"), for: .normal)
        button.setFont(font: .systemFont(ofSize: 18,weight: .bold))
        button.backgroundColor = UIColor.orange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(keluarButtonTapped), for: .touchUpInside)
        popupView.addSubview(button)
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(287)
            make.height.equalTo(50)
        }
        
        // 添加关闭按钮
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(popupView.snp.bottom).offset(20)
            make.width.height.equalTo(40)
        }
    }
    
    @objc private func keluarButtonTapped() {
        // 调用回调闭包，通知外部
        onKeluarButtonTapped?()
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc private func dismissPopup() {
        self.dismiss(animated: false, completion: nil)
    }
}








import UIKit
import SnapKit

class YTFullScreenPopupViewController: UIViewController {
    
    // 回调闭包，用于通知外部
    var onKeluarButtonTapped: (() -> Void)?

    // 外部传入的内容
    var titleText: String = "Account cancellation"
    var descriptionText: String = "The account cannot be restored after cancellation. To ensure the security of your account please confirm that the services related to the account have been properly handled before application and pay attention to the following provisions:"
    var provisionText: String = "All loans have been repaidfwefwefwe fwefwefwfwfwe fwfwefwfwe fewfefwewe"
    var agreementText: String = "I have read and agreed to the above"
    var buttonText: String = "Account cancellation"

    // UI组件
    private let popupView = UIView()
    private let accountButton = UIButton(type: .system)
    private let checkBoxButton = UIButton.init(title: "", image: "Component 40")

    // 记录选择状态
    private var isAgreed = false {
        didSet {
            updateButtonState()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        // 设置背景色
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        // 主容器
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 16
        popupView.layer.masksToBounds = true
        view.addSubview(popupView)
        popupView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(28)
            make.right.equalToSuperview().offset(-28)
            make.centerY.equalToSuperview()
        }

       
        
        // 标题
        let titleLabel = UILabel()
        titleLabel.text = titleText
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        popupView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.right.equalToSuperview().inset(16)
        }

        
        
        let box = UIView.init(bgColor: .init(hex: "#F4F8FF"))
        box.cornersSet(by: .allCorners, radius: 12)
        popupView.addSubview(box)
        box.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(17)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            
            
            
        }

        // 描述文字
        let descriptionLabel = UILabel()
        descriptionLabel.text = descriptionText
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        box.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalToSuperview().inset(10)
        }

        // 条款文字
        let provisionLabel = UILabel()
        provisionLabel.text = provisionText
        provisionLabel.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        provisionLabel.textColor = UIColor.systemBlue
        provisionLabel.numberOfLines = 0
        provisionLabel.textAlignment = .left
        box.addSubview(provisionLabel)
        provisionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(10)
        }

        // 复选框和协议文字容器
        let agreementContainer = UIView()
        box.addSubview(agreementContainer)
        agreementContainer.snp.makeConstraints { make in
            make.top.equalTo(provisionLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-8)
        }

        // 复选框按钮
        checkBoxButton.addTarget(self, action: #selector(toggleCheckBox), for: .touchUpInside)
        agreementContainer.addSubview(checkBoxButton)
        checkBoxButton.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }

        // 协议文字
        let agreementLabel = UILabel()
        agreementLabel.text = agreementText
        agreementLabel.font = UIFont.systemFont(ofSize: 14)
        agreementLabel.textColor = .black
        agreementLabel.textAlignment = .left
        agreementContainer.addSubview(agreementLabel)
        agreementLabel.snp.makeConstraints { make in
            make.left.equalTo(checkBoxButton.snp.right).offset(8)
            make.right.centerY.equalToSuperview()
        }
        
        
        

        // 确认按钮
        accountButton.setTitle(buttonText, for: .normal)
        accountButton.layer.cornerRadius = 22
        accountButton.layer.masksToBounds = true
        accountButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        accountButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        popupView.addSubview(accountButton)
        accountButton.snp.makeConstraints { make in
            make.top.equalTo(box.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-20)
        }

        // 初始化按钮状态
        updateButtonState()

        // 关闭按钮
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(popupView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }

    @objc private func toggleCheckBox() {
        isAgreed.toggle()
        checkBoxButton.isSelected = isAgreed
    }

    @objc private func updateButtonState() {
        if isAgreed {
            checkBoxButton.setImage(image: "fwef1233433333")
            accountButton.backgroundColor = UIColor(red: 95/255, green: 133/255, blue: 244/255, alpha: 1)
            accountButton.setTitleColor(.white, for: .normal)
        } else {
            checkBoxButton.setImage(image: "Component 40")
            accountButton.backgroundColor = UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1)
            accountButton.setTitleColor(.lightGray, for: .normal)
        }
    }

    @objc private func confirmAction() {
        guard isAgreed else { return }
        // 回调闭包，用于通知外部
        onKeluarButtonTapped?()
        
        dismiss(animated: false)
    }

    @objc private func dismissPopup() {
        dismiss(animated: false, completion: nil)
    }
}
