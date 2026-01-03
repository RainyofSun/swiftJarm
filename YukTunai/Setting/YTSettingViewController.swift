//
//  YTSettingViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit

class YTSettingView: UIControl {
    
    let imgview = UIImageView(image: UIImage(named: "s_cancel"))
    let t2 = UILabel.init(title: YTTools.areaTitle(a: "Account cancellation", b: "Pembatalan akun"),textColor: .init(hex: "#333333"),font: UIFont.systemFont(ofSize: 16, weight: .medium))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        let whie = UIView()
        whie.backgroundColor = UIColor(hex: "#EAF5FF")
        
        whie.cornersSet(by: .allCorners, radius: 8)
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.backgroundColor = UIColor(hex: "#2864D7")
        btn.cornersSet(by: UIRectCorner.allCorners, radius: 4)
        btn.isUserInteractionEnabled = false
        btn.setImage(image: "sett_arr")
        
        add(imgview) { v in
            imgview.snp.makeConstraints { make in
                make.top.centerX.equalToSuperview()
                make.size.equalTo(108)
            }
        }
        
        add(whie) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.top.equalTo(imgview.snp.bottom).offset(-54)
                make.bottom.equalToSuperview()
            }
        }
        
        whie.add(t2) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(60)
            }
        }
        
        whie.add(btn) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(33)
                make.top.equalTo(t2.snp.bottom).offset(25)
                make.height.equalTo(36)
                make.bottom.equalToSuperview().offset(-20)
            }
        }
        
        self.bringSubviewToFront(imgview)
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
        
        let box = UIView()
        box.backgroundColor = UIColor(hex: "#EAF5FF")
        box.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        
        let title = UILabel(title: "Pinjam Laju", textColor: .black, font: UIFont.boldSystemFont(ofSize: 20))
        let t2 = UILabel.init(title:  YTTools.areaTitle(a: "Version v1.0.1", b: "Versi v1.0.1"),textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 16))
        
        let image = UIImageView.init(image: UIImage.init(named: "s_logo"))
        
        view.add(box) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalToSuperview().offset(80 + statusBarHeight)
            }
        }
        
        box.add(image) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(12)
                make.size.equalTo(70)
            }
        }
        
        box.add(title) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(image.snp.bottom).offset(12)
            }
        }
        
        box.add(t2) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(title.snp.bottom).offset(12)
                make.bottom.equalToSuperview().offset(-12)
            }
        }
        
        let v2 = YTSettingView()
        view.add(v2) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(15)
                make.top.equalTo(box.snp.bottom).offset(16)
            }
        }
        
        
        let v3 = YTSettingView()
        v3.imgview.image = UIImage(named: "s_logout")
        v3.t2.text = LocalizationManager.shared().localizedString(forKey: "setting_lot")
        
        view.add(v3) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(v2.snp.right).offset(15)
                make.top.width.equalTo(v2)
                make.right.equalToSuperview().offset(-15)
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
        present(popupVC, animated: false, completion: nil)
        
        
        popupVC.onKeluarButtonTapped = {[weak self] in
            
            
            
            self?.viewModel.bottles(completion: { res in
                switch res {
                case .success(let success):
                    
                    YTUserDefaults.shared.transport = ""
                    NotificationCenter.default.post(name:Notification.Name("logout"),object: nil)
                    self?.navigationController?.popToRootViewController(animated: false)
                    let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
                    tabBar?.selectedIndex = 0
                    break
                case .failure(let failure):
                    SVProgressHUD.showError(withStatus: failure.description)
                }
            })
          
        }

    }
    
    @objc func add2(){
        let popupVC = FullScreenPopupViewController()
        popupVC.modalPresentationStyle = .overFullScreen

        // 设置回调
        popupVC.onKeluarButtonTapped = {[weak self] in
            self?.viewModel.lip(completion: { res in
                switch res {
                case .success(let success):
                    
                    YTUserDefaults.shared.transport = ""
                    NotificationCenter.default.post(name:Notification.Name("logout"),object: nil)
                    self?.navigationController?.popToRootViewController(animated: false)
                    let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
                    tabBar?.selectedIndex = 0
                    break
                case .failure(let failure):
                    SVProgressHUD.showError(withStatus: failure.description)
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
        popupView.layer.cornerRadius = 8
        popupView.layer.masksToBounds = true
        view.addSubview(popupView)
        
        let loanTip = loanTipView(frame: CGRectZero)
        loanTip.title.text = YTTools.areaTitle(a: "Logout", b: "Keluar")
        
        view.add(loanTip) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalTo(popupView).inset(30)
                make.bottom.equalTo(popupView.snp.top).offset(8)
            }
        }
        
        popupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        // 添加描述
        let descriptionLabel = UILabel()
        descriptionLabel.text = YTTools.areaTitle(a: "Are you sure you want to exit?", b: "Apakah Anda yakin ingin keluar?")
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        popupView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.verticalEdges.equalToSuperview().inset(40)
        }
        
        // 添加按钮
        let button = GradientLoadingButton(frame: CGRectZero)
        button.setTitle(YTTools.areaTitle(a: "Exit", b: "Keluar"))
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(keluarButtonTapped), for: .touchUpInside)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(popupView)
            make.top.equalTo(popupView.snp.bottom).offset(10)
            make.height.equalTo(48)
        }
        
        // 添加关闭按钮
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.right.equalTo(popupView)
            make.bottom.equalTo(loanTip.snp.top).offset(-10)
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

    // UI组件
    private let popupView = UIView()
    private let accountButton = GradientLoadingButton(frame: CGRectZero)
    private let checkBoxButton = UIButton.init(title: "", image: "pro_nor")
    
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

        let loanTip = loanTipView(frame: CGRectZero)
        loanTip.title.text = YTTools.areaTitle(a: "Deregister account", b: "Pembatalan akun")
        
        // 主容器
        popupView.backgroundColor = UIColor(hex: "#EAF5FF")
        popupView.layer.cornerRadius = 8
        popupView.layer.masksToBounds = true
        view.addSubview(popupView)
        
        view.add(loanTip) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalTo(popupView).inset(30)
                make.bottom.equalTo(popupView.snp.top).offset(8)
            }
        }
        
        popupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }

        // 关闭按钮
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.right.equalTo(popupView)
            make.bottom.equalTo(loanTip.snp.top).offset(-10)
            make.width.height.equalTo(40)
        }
        
        var pre: UIView?
        for i in 1...5 {
            let im = CancleItemView(frame: CGRectZero)
            im.numLab.text = "\(i)"
            im.content.text = LocalizationManager.shared().localizedString(forKey: "cancel_tip\(i)")
            
            popupView.add(im) { v in
                v.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    if i == 1 {
                        make.top.equalToSuperview()
                    } else {
                        make.top.equalTo(pre!.snp.bottom)
                    }
                }
            }
            pre = im
        }

        // 复选框和协议文字容器
        let agreementContainer = UIView()
        popupView.addSubview(agreementContainer)
        agreementContainer.snp.makeConstraints { make in
            make.top.equalTo(pre!.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-8)
        }

        // 协议文字
        let agreementLabel = UILabel()
        agreementLabel.text = LocalizationManager.shared().localizedString(forKey: "cancel_priss")
        agreementLabel.font = UIFont.systemFont(ofSize: 16)
        agreementLabel.textColor = .black
        agreementLabel.textAlignment = .left
        agreementLabel.numberOfLines = .zero
        agreementContainer.addSubview(agreementLabel)
        
        // 复选框按钮
        checkBoxButton.addTarget(self, action: #selector(toggleCheckBox), for: .touchUpInside)
        agreementContainer.addSubview(checkBoxButton)
        
        agreementLabel.snp.makeConstraints { make in
            make.left.equalTo(checkBoxButton.snp.right).offset(8)
            make.verticalEdges.equalToSuperview().inset(4)
            make.right.equalToSuperview().offset(-8)
        }

        checkBoxButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.height.equalTo(24)
            make.centerY.equalTo(agreementLabel)
        }
        
        // 确认按钮
        accountButton.setTitle(LocalizationManager.shared().localizedString(forKey: "ccancel_del"))
        accountButton.layer.cornerRadius = 8
        accountButton.layer.masksToBounds = true
        accountButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        view.addSubview(accountButton)
        accountButton.snp.makeConstraints { make in
            make.top.equalTo(popupView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(popupView)
            make.height.equalTo(48)
        }

        // 初始化按钮状态
        updateButtonState()
    }

    @objc private func toggleCheckBox() {
        isAgreed.toggle()
        checkBoxButton.isSelected = isAgreed
    }

    @objc private func updateButtonState() {
        if isAgreed {
            checkBoxButton.setImage(image: "pro_sel")
        } else {
            checkBoxButton.setImage(image: "pro_nor")
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
