//
//  YTProductViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit
import SVProgressHUD
import SmartCodable


class daysModel: SmartCodable {
    var placed: daysplacedModel?
    var combatants: Int?
   
    var legs: [dayslegsModel]?
    var quiet: daysquietModel?
    var addressed: daysaddressedModel?
    required init(){}
}

class chosenModel: SmartCodable {
    var seconds: chosenSubModel?
    var dropped: chosenSubModel?
    required init(){}
}


class chosenSubModel: SmartCodable {
    var downward: String?
    var leaped: String?
    required init(){}
}



class daysplacedModel: SmartCodable {
    var chosen: chosenModel?
    var neck: String?
    var brim: String?
    var frau: String?
    var bare: String?
    var bassgl: String?
    var wide: String?
    var turning: String?
    var arms: String?
    var replied: String?
    var coat: String?
    
    required init(){}
}

class dayslegsModel: SmartCodable {
    var downward: String?
    var hind: String?
    var directly: String?
    var stride: String?
    var floor: Int?
     var sit: String?
    var poodle: String?
    var shaved: String?
    var wretched: String?
    var busy: String?
    var opposite: String?
    var person: String?
    required init(){}
}




class daysquietModel: SmartCodable {
    var poodle: String?
    var stride: String?
    var directly: String?
    var downward: String?
    required init(){}
}



class daysaddressedModel: SmartCodable {
    var downward: String?
    var words: String?
    required init(){}
}



class YTPView: UIView {
    
    let image2 = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.setImage(UIImage(named: "sett_arr"), for: UIControl.State.normal)
        view.setImage(UIImage(named: "au_com"), for: UIControl.State.selected)
        view.cornersSet(by: UIRectCorner.allCorners, radius: 4)
        view.isUserInteractionEnabled = false
        return view
    }()
    
    init(iconN: String,name: String,isok: Bool) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(hex: "#EAF5FF")
        self.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        
        let image = UIImageView()
        image.sd_setImage(with: URL.init(string: iconN))
        image.cornersSet(by: UIRectCorner.allCorners, radius: 4)
        add(image) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(64)
                make.top.equalToSuperview().offset(4)
                make.centerX.equalToSuperview()
            }
        }
        
        
        let t2 = UILabel.init(title: name,textColor: .init(hex: "#141C35"),font: .systemFont(ofSize: 16), alignment: .center)
        add(t2) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalTo(image.snp.bottom).offset(6)
            }
        }
       
        image2.backgroundColor = isok ? UIColor(hex: "#24DD5B") : UIColor(hex: "#FF8827")
        image2.isSelected = isok
        
        add(image2) { v in
            v.snp.makeConstraints { make in
                make.top.equalTo(t2.snp.bottom).offset(12)
                make.height.equalTo(32)
                make.horizontalEdges.equalToSuperview().inset(32)
                make.bottom.equalToSuperview().offset(-20)
            }
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class YTProductViewController: YTBaseViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let c = tableView.dequeueReusableCell(withIdentifier: PPChanPunTableViewCell.identifier, for: indexPath) as! PPChanPunTableViewCell
            if let mm = model  {
                c.price.isHidden = false
                c.l1t.isHidden = false
                c.l2t.isHidden = false
                
                c.l1tv.isHidden = false
                
                c.l2tv.isHidden = false
                c.subName.isHidden = false
                c.lyBox.isHidden = false
                
                c.price.text = mm.placed?.brim
                c.l1t.text = mm.placed?.chosen?.seconds?.downward
                c.l2t.text = mm.placed?.chosen?.dropped?.downward
            
                c.l1tv.text = mm.placed?.chosen?.seconds?.leaped
                c.l2tv.text = mm.placed?.chosen?.dropped?.leaped
            }
           
            return c
        } else {
            let c = tableView.dequeueReusableCell(withIdentifier: cell2.identifier, for: indexPath) as! cell2
            if let mm = model  {
                c.listViews(mm.legs ?? [])
                
                c.handle = {[weak self] t in
                    self?.listAddkskiwk(g: t)
                }
            }
           
            return c
        }
    }
    
    
    
    let viewModel = ApiViewModel()
    
    var model: daysModel?
    
    let pV = UIView()
    
    let pvB = UIButton.init(title: "", image: "勾选")
    
    let protocolLable = UILabel(title: "",textColor: .init(hex: "#FEC95D"),font: .systemFont(ofSize: 13))
    
    let button = GradientLoadingButton(frame: CGRectZero)
    
    let table = YTTableView()
    
    var mID: String?
    
    func reloadModel(){
        viewModel.days(avp: ["erect" : mID!]) {[weak self] result in
            switch result {
           
            case .success(let success):
                
                
                guard let m = success?.upper else {
                    return
                }
                
                self?.model = m
                
                self?.setNavigationBarTitle(m.placed?.bare ?? "")
                
              
                self?.table.reloadData()
                
                self?.button.isHidden = false
                
                self?.table.isHidden = false
                self?.button.setTitle(m.placed?.coat ?? "")

                if (m.addressed?.downward ?? "").count != 0 {
                    self?.pV.isHidden = false
                    // 创建富文本字符串
                    let attributedString = NSMutableAttributedString(string: m.addressed?.downward ?? "", attributes: [.foregroundColor: UIColor.init(hex: "#FEC95D"), .font: UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.medium)])
                    self?.protocolLable.attributedText = attributedString
                } else {
                    self?.pV.isHidden = true
                }
                break
            case .failure(let failure):
                
                SVProgressHUD.showError(withStatus: failure.description)
                break
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadModel()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

       setBarBgHidden()
        
        button.isHidden = true
        button.addTarget(self, action: #selector(buy), for: .touchUpInside)
        button.cornersSet(by: .allCorners, radius: 8)
        
        view.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -22 : -34)
                make.height.equalTo(48)
            }
        }
        
        
        view.add(pV) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(30)
                make.bottom.equalTo(button.snp.top).offset(-12)
            }
            
            pV.add(pvB) { v in
                pvB.addTarget(self, action: #selector(check), for: .touchUpInside)
                pvB.isSelected = true
                pvB.setImage(image: "pro_sel")
                v.snp.makeConstraints { make in
                    make.top.bottom.left.equalToSuperview()
                    make.width.height.equalTo(18)
                }
            }
            
            pV.add(protocolLable) { v in
                protocolLable.isUserInteractionEnabled = true
                v.snp.makeConstraints { make in
                    make.verticalEdges.equalToSuperview()
                    make.right.equalToSuperview()
                    make.height.equalTo(56)
                    make.left.equalTo(pvB.snp.right).offset(10)
                }
                
                let protocolGestrue = UITapGestureRecognizer(target: self, action: #selector(protocola))
                v.addGestureRecognizer(protocolGestrue)
            }
        }
        
        table.backgroundColor = .clear

        table.delegate = self
        table.dataSource = self
        view.add(table) { v in
            v.snp.makeConstraints { make in
                make.left.right.top.equalToSuperview()
                make.bottom.equalTo(protocolLable.snp.top).offset(12)
            }
        }
     

        table.register(PPChanPunTableViewCell.self, forCellReuseIdentifier: PPChanPunTableViewCell.identifier)
        table.register(cell2.self, forCellReuseIdentifier: cell2.identifier)
        
        self.button.isHidden = true
        
        self.pV.isHidden = true
        
        self.table.isHidden = true
        
    }
 
    
    @objc func check(with button: UIButton) {
        button.setImage(image: button.isSelected ? "pro_sel选" : "pro_nor")
        button.isSelected = !button.isSelected
    }
    
    
    @objc func protocola(gesture: UITapGestureRecognizer){
        if let m  = model?.addressed?.words {
            if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: m)?.absoluteString {
                let webView = YTWebViewController.init(url: completeURL)
                navigationController?.pushViewController(webView, animated: true)
            }
        }
    }
    
    @objc func buy(){
        
        if let t = model?.quiet?.poodle  {
            SVProgressHUD.show()
            if t == "lip" {
                let v = YTProductFaceViewController()
                v.pid = model?.placed?.wide
                v.t = model?.quiet?.downward
                navigationController?.pushViewController(v, animated: true)
            } else if t == "upper" {
                let v = YTProductListViewController()
                v.pid = model?.placed?.wide
                v.t = model?.quiet?.downward
                navigationController?.pushViewController(v, animated: true)
            } else if t == "gash" {
                let v = YTProductdierViewController()
                v.pid = model?.placed?.wide
                v.t = model?.quiet?.downward
                navigationController?.pushViewController(v, animated: true)
            } else if t == "days" {
                let v = YTUserConnectViewController()
                v.pid = model?.placed?.wide
                v.t = model?.quiet?.downward
                navigationController?.pushViewController(v, animated: true)
            } else if t == "fought" {
                let v = YTDibankViewController()
                v.pid = model?.placed?.wide
                v.t = model?.quiet?.downward
                navigationController?.pushViewController(v, animated: true)
            }
            SVProgressHUD.dismiss()
            return
        }

        if (model?.addressed?.words ?? "").count != 0 && pvB.isSelected != true {
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please read and agree to the loan agreement!", b: "Silakan baca dan setuju dengan perjanjian pinjaman!"))
            return
        }
        
        
        let headers: [String:String] = ["frau":model?.placed?.frau ?? "",
                       "brim":model?.placed?.brim ?? "",
                       "turning":model?.placed?.turning ?? "",
                                        "replied":model?.placed?.replied ?? "","cicero":"1"]

        viewModel.uproar(avp:headers) { [weak self] re in
            switch re {
            case .success(let success):
                
                
                let data: [String: Any] = ["obliged": "8",
                                           "procession":"\(self?.model?.placed?.arms ?? "")",
                                           "nasty": "\(Date().timeIntervalSince1970)",
                                           "newcomers":"\(Date().timeIntervalSince1970)"]
                NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: data)

                if let url = success?.upper?.stride {
                    if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                        let webView = YTWebViewController.init(url: completeURL)
                        webView.isPro = true
                        self?.navigationController?.pushViewController(webView, animated: true)
                    }
                }
                
                break
            case .failure(let failure):
                SVProgressHUD.showInfo(withStatus: failure.description)
                break
            }
        }
    }
    
    @objc func listAddkskiwk(g tap: Int) {
        guard let item = model?.legs?[tap] else {
            return
        }
        
        let t = item.floor == 1 ? item.poodle : model?.quiet?.poodle
        let ttitle = item.floor == 1 ? item.downward : model?.quiet?.downward
        
        SVProgressHUD.show()
        if t == "lip" {
            let v = YTProductFaceViewController()
            v.pid = model?.placed?.wide
            v.t = ttitle
            navigationController?.pushViewController(v, animated: true)
        } else if t == "upper" {
            let v = YTProductListViewController()
            v.pid = model?.placed?.wide
            v.t = ttitle
            navigationController?.pushViewController(v, animated: true)
        } else if t == "gash" {
            let v = YTProductdierViewController()
            v.pid = model?.placed?.wide
            v.t = ttitle
            navigationController?.pushViewController(v, animated: true)
        } else if t == "days" {
            let v = YTUserConnectViewController()
            v.pid = model?.placed?.wide
            v.t = ttitle
            navigationController?.pushViewController(v, animated: true)
        } else if t == "fought" {
            let v = YTDibankViewController()
            v.pid = model?.placed?.wide
            v.t = ttitle
            navigationController?.pushViewController(v, animated: true)
        }
        
        SVProgressHUD.dismiss()
    }

}


class cell2: UITableViewCell {
    
    let listBoxView = UIView()

    var handle:((Int)->())?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        listBoxView.backgroundColor = .clear
        
        contentView.add(listBoxView) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(15)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func listViews(_ data: [dayslegsModel]) {

        // 清理旧视图（保留 UIImageView）
        listBoxView.subviews.forEach {
            if !($0 is UIImageView) {
                $0.removeFromSuperview()
            }
        }

        let spacing: CGFloat = 15

        var lastRowBottomView: UIView?
        var leftItem: UIView?

        for (index, item) in data.enumerated() {

            let v = YTPView(
                iconN: item.person ?? "",
                name: item.downward ?? "",
                isok: item.floor == 1
            )

            v.isUserInteractionEnabled = true
            v.tag = index
            v.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(listAdd(g:)))
            )

            listBoxView.addSubview(v)

            let isLeft = index % 2 == 0

            v.snp.makeConstraints { make in

                // 顶部约束（是否换行）
                if let lastBottom = lastRowBottomView {
                    make.top.equalTo(lastBottom.snp.bottom).offset(spacing)
                } else {
                    make.top.equalToSuperview()
                }

                if isLeft {
                    // 左列
                    make.left.equalToSuperview()

                    // 宽度 = 半屏（减去列间距）
                    make.width.equalToSuperview().multipliedBy(0.5).offset(-spacing / 2)
                } else {
                    // 右列
                    make.left.equalTo(leftItem!.snp.right).offset(spacing)
                    make.right.equalToSuperview()

                    // 宽度等于左列
                    make.width.equalTo(leftItem!)
                }
            }

            if isLeft {
                leftItem = v
            } else {
                // 一行结束
                lastRowBottomView = v
                leftItem = nil
            }

            // ⭐ 关键修正点：奇数个元素，最后一个在左列
            if index == data.count - 1 && isLeft {
                lastRowBottomView = v
            }
        }

        // 撑开容器高度
        if let last = lastRowBottomView {
            last.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
            }
        }
    }
    
    
    @objc func listAdd(g tap: UITapGestureRecognizer) {
        guard let t = tap.view else {
            return
        }
        handle?(t.tag)
    }

}
