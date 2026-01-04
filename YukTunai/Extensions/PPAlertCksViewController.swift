//
//  PPAlertCksViewController.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/4.
//

import UIKit

class PPAlertCksViewController: UIViewController {

    let loanTileView: loanTipView = loanTipView(frame: CGRectZero)
    let contentView: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor(hex: "#EAF5FF")
        view.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        return view
    }()
    
    let closeBtn: UIButton = {
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.tintColor = .white
        return closeButton
    }()
    
    let subBtn: GradientLoadingButton = {
        let view = GradientLoadingButton(frame: CGRectZero)
        view.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        view.setTitle(YTTools.areaTitle(a: "Confrmation", b: "Konfirmasi"))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        self.closeBtn.addTarget(self, action: #selector(closeAlertController), for: UIControl.Event.touchUpInside)
        self.subBtn.addTarget(self, action: #selector(submitContent), for: UIControl.Event.touchUpInside)
        
        self.view.add(contentView) { v in
            v.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.horizontalEdges.equalToSuperview().inset(20)
            }
        }
        
        self.view.add(loanTileView) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalTo(contentView).inset(40)
                make.bottom.equalTo(contentView.snp.top).offset(10)
            }
        }
        
        self.view.add(closeBtn) { v in
            v.snp.makeConstraints { make in
                make.right.equalTo(contentView)
                make.bottom.equalTo(loanTileView.snp.top).offset(-10)
                make.width.height.equalTo(40)
            }
        }
        
        self.view.add(subBtn) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalTo(contentView)
                make.top.equalTo(contentView.snp.bottom).offset(12)
                make.height.equalTo(48)
            }
        }
    }
    
    @objc func closeAlertController() {
        dismiss(animated: false)
    }

    @objc func submitContent() {
        
    }
}
