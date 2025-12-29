//
//  YTYSHRViewController.swift
//  YukTunai
//
//  Created by whoami on 2024/12/1.
//

import UIKit

class YTYSHRViewController: YTBaseViewController {

    
    let imag = UIImageView(image: UIImage.init(named: "Frame 1322"))
    
    let title1V: UILabel = UILabel.init(title:  YTTools.areaTitle(a: "Congratulations", b: "Selamat"),textColor: .init(hex: "#2BDB53"),font: .systemFont(ofSize: 24, weight: .bold))
    
    let title2V: UILabel = UILabel.init(title: YTTools.areaTitle(a:"your review rate is",b: "tingkat penelitian Anda adalah"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 18, weight: .regular))
    
    let title3V: UILabel = UILabel.init(title: "",textColor: .init(hex: "#2BDB53"),font: .systemFont(ofSize: 42, weight: .bold))
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Apply now", b: "Terapkan sekarang"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setNavigationBarTitle(YTTools.areaTitle(a: "Pre-review", b: "Pre-review"))
        
        let box = UIView()
        box.backgroundColor = .white
        view.add(box) { v in
            v.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
        
        box.addSubview(imag)
        box.addSubview(title1V)
        box.addSubview(title2V)
        box.addSubview(title3V)
        
        imag.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        title1V.textAlignment = .center
        title1V.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imag.snp.bottom).offset(40)
        }
        
        
        title2V.textAlignment = .center
        title2V.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(title1V.snp.bottom).offset(6)
        }
        
        title3V.textAlignment = .center
        title3V.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(title2V.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
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
        
    }
    
    
    @objc func nextA(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func bTapped() {
        navigationController?.popToRootViewController(animated: true)
    }

}
