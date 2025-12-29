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
    
    let image2 = UIImageView.init(image: UIImage.init(named: "Frame 316"))
    
    init(iconN: String,name: String,isok: Bool) {
        super.init(frame: .zero)
        
     
        let image = UIImageView()
        image.sd_setImage(with: URL.init(string: iconN))
        add(image) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(40)
                make.top.bottom.equalToSuperview().inset(12)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(12)
            }
        }
        
        
        let t2 = UILabel.init(title: name,textColor: .init(hex: "#141C35"),font: .systemFont(ofSize: 16))
        add(t2) { v in
            v.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(image.snp.right).offset(14)
            }
        }
        
       
        image2.image = UIImage.init(named: isok ? "Fraew23me 315" : "Frame 316")
        add(image2) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(32)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-23)
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
            let c = tableView.dequeueReusableCell(withIdentifier: cell1.identifier, for: indexPath) as! cell1
            c.backgroundColor = .init(hex: "#EBEFFE")
            
            if let mm = modeee  {
                c.icon.sd_setImage(with: URL.init(string: (modeee?.placed!.neck)!))
                c.price.text = modeee?.placed?.brim
    //                self?.name.text = m.placed?.bassgl
                
                
                c.l1t.text = modeee?.placed?.chosen?.seconds?.downward
                c.l2t.text = modeee?.placed?.chosen?.dropped?.downward
            
                c.l1tv.text = modeee?.placed?.chosen?.seconds?.leaped
                c.l2tv.text = modeee?.placed?.chosen?.dropped?.leaped

                let c1 = modeee?.legs?.filter({$0.floor == 1}).count
                if c1 ?? 0 > 0 {
                    c.updateProgress(completedItems: c1 ?? 0, totalItems: modeee?.legs?.count ?? 0)
                }
                
            }
           
            return c
        } else {
            let c = tableView.dequeueReusableCell(withIdentifier: cell2.identifier, for: indexPath) as! cell2
            
            c.backgroundColor = .init(hex: "#EBEFFE")
            
            if let mm = modeee  {
                c.listViews(modeee?.legs ?? [])
                
                c.handle = {[weak self] t in
                    self?.listAdd(g: t)
                }
            }
           
            return c
        }
    }
    
    
    
    let viewModel = ApiViewModel()
    
    var model: daysModel?
    
  
    let pV = UIView()
    
    let pvB = UIButton.init(title: "", image: "勾选")
    
    let protocolLable = UILabel(title: "",textColor: .init(hex: "#A2A2A2"),font: .systemFont(ofSize: 12))
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Apply now", b: "Menerapkan"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
  
    let table = YTTableView()
    
    var mID: String?
    
    var modeee:daysModel?
    
    func reloadModel(){
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        viewModel.days(avp: ["erect" : mID!]) {[weak self] result in
            switch result {
           
            case .success(let success):
                
                
                guard let m = success?.upper else {
                    return
                }
                
                self?.model = success?.upper
                
                self?.modeee = success?.upper
                
                self?.setNavigationBarTitle(m.placed?.bare ?? "")
                
              
                self?.table.reloadData()
                
                self?.button.isHidden = false
                
                self?.pV.isHidden = false
                
                self?.table.isHidden = false
                
                if (m.addressed?.words ?? "").count == 0 {
                    self?.pV.isHidden = true
                }
                
                SVProgressHUD.dismiss()
                
                break
            case .failure(let failure):
                SVProgressHUD.dismiss(withDelay: 1.5)
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
        button.cornersSet(by: .allCorners, radius: 25)
        button.setBgColor(color: .init(hex: "#6D90F5"))
        view.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -22 : -34)
                make.height.equalTo(50)
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
                pvB.setImage(image: "勾选12212")
                v.snp.makeConstraints { make in
                    make.top.bottom.left.equalToSuperview()
                    make.width.height.equalTo(18)
                }
            }
            
            pV.add(protocolLable) { v in
                protocolLable.isUserInteractionEnabled = true
                // 创建富文本字符串
                let fullText = YTTools.areaTitle(a: "I've read and agreed with <Loan Agreement>", b: "Saya sudah membaca dan setuju dengan <Perjanjian Pinjaman>")
                let privacyText = YTTools.areaTitle(a: "<Loan Agreement>", b: "<Perjanjian Pinjaman>")
                let attributedString = NSMutableAttributedString(string: fullText)
                let privacyRange = (fullText as NSString).range(of: privacyText)
                
                attributedString.addAttribute(.foregroundColor, value: UIColor.init(hex: "#999999"), range: (fullText as NSString).range(of: YTTools.areaTitle(a: "<Loan Agreement>", b: "<Perjanjian Pinjaman>")))
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
                
                let protocolGestrue = UITapGestureRecognizer(target: self, action: #selector(protocola))
                v.addGestureRecognizer(protocolGestrue)
            }
        }
        
        
        view.backgroundColor = .init(hex: "#EBEFFE")
        
        table.backgroundColor = .init(hex: "#EBEFFE")

        
        table.delegate = self
        table.dataSource = self
        view.add(table) { v in
            //v.alwaysBounceVertical = true
            v.snp.makeConstraints { make in
                make.left.right.top.equalToSuperview()
                make.bottom.equalTo(protocolLable.snp.top).offset(12)
            }
        }
     

        table.register(cell1.self, forCellReuseIdentifier: cell1.identifier)
        table.register(cell2.self, forCellReuseIdentifier: cell2.identifier)
        
        self.button.isHidden = true
        
        self.pV.isHidden = true
        
        self.table.isHidden = true
        
    }
 
    
    @objc func check(with button: UIButton) {
        button.setImage(image: button.isSelected ? "勾选" : "勾选12212")
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
        
        if  let t = model?.quiet?.poodle  {
            
            if t == "lip" {
                let v = YTProductFaceViewController()
                v.pid = model?.placed?.wide
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
            
            return
        }
        
        
        
        if (model?.addressed?.words ?? "").count != 0 && pvB.isSelected != true {
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.dismiss(withDelay: 1.5)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please read and agree to the loan agreement!", b: "Silakan baca dan setuju dengan perjanjian pinjaman!"))
            return
        }
        
        
        let headers: [String:String] = ["frau":model?.placed?.frau ?? "",
                       "brim":model?.placed?.brim ?? "",
                       "turning":model?.placed?.turning ?? "",
                                        "replied":model?.placed?.replied ?? "","cicero":"1"]
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        viewModel.uproar(avp:headers) { [weak self] re in
            switch re {
            case .success(let success):
                SVProgressHUD.dismiss()
                
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
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
                SVProgressHUD.showInfo(withStatus: failure.description)
                break
            }
        }
    }
    
    
    
    
    @objc func listAdd(g tap: Int) {
        if (model?.legs?[tap].floor ?? 0 ) == 1 {
            
            guard let item = model?.legs?[tap] else {
                return
            }
            
            guard let t = item.poodle else {
                return
            }
            if t == "lip" {
                let v = YTProductFaceViewController()
                v.pid = model?.placed?.wide
                navigationController?.pushViewController(v, animated: true)
            } else if t == "upper" {
                let v = YTProductListViewController()
                v.pid = model?.placed?.wide
                v.t = (item.downward ?? "")
                navigationController?.pushViewController(v, animated: true)
            } else if t == "gash" {
                let v = YTProductdierViewController()
                v.pid = model?.placed?.wide
                v.t = (item.downward ?? "")
                navigationController?.pushViewController(v, animated: true)
            } else if t == "days" {
                let v = YTUserConnectViewController()
                v.pid = model?.placed?.wide
                v.t = (item.downward ?? "")
                navigationController?.pushViewController(v, animated: true)
            } else if t == "fought" {
                let v = YTDibankViewController()
                v.pid = model?.placed?.wide
                v.t = (item.downward ?? "")
                navigationController?.pushViewController(v, animated: true)
            }
        } else {
            guard let item = model?.legs?[tap] else {
                return
            }
            
            guard let t = model?.quiet?.poodle else {
                return
            }
            if t == "lip" {
                let v = YTProductFaceViewController()
                v.pid = model?.placed?.wide
                navigationController?.pushViewController(v, animated: true)
            } else if t == "upper" {
                let v = YTProductListViewController()
                v.pid = model?.placed?.wide
                v.t = (item.downward ?? "")
                navigationController?.pushViewController(v, animated: true)
            } else if t == "gash" {
                let v = YTProductdierViewController()
                v.pid = model?.placed?.wide
                v.t = (item.downward ?? "")
                navigationController?.pushViewController(v, animated: true)
            } else if t == "days" {
                let v = YTUserConnectViewController()
                v.pid = model?.placed?.wide
                v.t = (item.downward ?? "")
                navigationController?.pushViewController(v, animated: true)
            } else if t == "fought" {
                let v = YTDibankViewController()
                v.pid = model?.placed?.wide
                v.t = (item.downward ?? "")
                navigationController?.pushViewController(v, animated: true)
            }
        }
    }

}






class cell1: UITableViewCell {
    
    let name = UILabel.init(title: YTTools.areaTitle(a: "Loan amount", b: "Jumlah pinjaman"),textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 16))
    
    let price = UILabel.init(title: "",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 38,weight: .bold))
    
    let icon = UIImageView()
    
    let icon1 = UIImageView.init(image: UIImage.init(named: "Group 1347123"))
    let l1t = UILabel.init(title: "fewfwe",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 13))
    let l1tv = UILabel.init(title: "",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 14,weight: .bold))
    
    
    let icon2 = UIImageView.init(image: UIImage.init(named: "Group 1349123"))
    let l2t = UILabel.init(title: "Interest rate",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 13))
    let l2tv = UILabel.init(title: "",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 14,weight: .bold))
    
    let lineView = UIProgressView()
    
    let titlev = UILabel.init(title: "Certification conditions",textColor: .init(hex: "#141C35"),font: .systemFont(ofSize: 16,weight: .bold))
    
    func updateProgress(completedItems: Int, totalItems: Int) {
            guard totalItems > 0 else { return }
            let progress = Float(completedItems) / Float(totalItems)
            lineView.setProgress(progress, animated: true)
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        lineView.progressTintColor = .init(hex: "#00EB91")
        lineView.trackTintColor = .init(hex: "#FFFFFF")
        
      
        let image = UIImageView.init(image: UIImage.init(named: "Rectangle"))
        contentView.add(image) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview()
            }
        }
     
        
        let box = UIView()
        contentView.add(box) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalToSuperview().offset(92)
              
            }
            
            box.add(icon) { v in
                icon.cornersSet(by: .allCorners, radius: 12)
                v.snp.makeConstraints { make in
                    make.height.width.equalTo(44)
                    make.left.equalToSuperview().offset(24)
                    make.top.equalToSuperview()
                }
            }
            
            box.add(name) { v in
                v.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalToSuperview().offset(20)
                }
            }
            
            box.add(price) { v in
                v.snp.makeConstraints { make in
                    make.centerX.equalToSuperview()
                    make.top.equalTo(name.snp.bottom).offset(10)
                   
                }
            }
            
            
            let bbox = UIView()
            box.add(bbox) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(33)
                    make.top.equalTo(price.snp.bottom).offset(15)
                    make.width.equalTo((UIScreen.main.bounds.width-33-33)/2)
                    make.bottom.equalToSuperview()
                }
                
                bbox.add(icon1) { v in
                    v.snp.makeConstraints { make in
                        make.left.equalToSuperview()
                        make.top.equalToSuperview()
                    }
                }
                
                bbox.add(l1t) { v in
                    v.snp.makeConstraints { make in
                        make.left.equalTo(icon1.snp.right).offset(10)
                        make.top.equalTo(icon1)
                    }
                }
                
                bbox.add(l1tv) { v in
                    v.snp.makeConstraints { make in
                        make.left.equalTo(icon1.snp.right).offset(10)
                        make.top.equalTo(l1t.snp.bottom).offset(4)
                        make.bottom.equalToSuperview()
                    }
                }
            }
            
            let bbox2 = UIView()
            box.add(bbox2) { v in
                v.snp.makeConstraints { make in
                    make.right.equalToSuperview().inset(33)
                    make.top.equalTo(price.snp.bottom).offset(15)
                    make.width.equalTo((UIScreen.main.bounds.width-33-33)/2)
                }
                
                bbox2.add(icon2) { v in
                    v.snp.makeConstraints { make in
                        make.left.equalToSuperview().offset(30)
                        make.top.equalToSuperview()
                    }
                }
                
                bbox2.add(l2t) { v in
                    v.snp.makeConstraints { make in
                        make.left.equalTo(icon2.snp.right).offset(10)
                        make.top.equalTo(icon1)
                    }
                }
                
                bbox2.add(l2tv) { v in
                    v.snp.makeConstraints { make in
                        make.left.equalTo(icon2.snp.right).offset(10)
                        make.top.equalTo(l1t.snp.bottom).offset(4)
                        make.bottom.equalToSuperview()
                    }
                }
            }
        }
        

        contentView.add(lineView) { v in
            v.backgroundColor = .white
            v.cornersSet(by: .allCorners, radius: 6)
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(13)
                make.height.equalTo(13)
                make.top.equalTo(box.snp.bottom).offset(22)
            }
        }
        
        contentView.add(titlev) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(13)
                make.top.equalTo(lineView.snp.bottom).offset(16)
                make.bottom.equalToSuperview().offset(-12)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


class cell2: UITableViewCell {
    
    let listBoxView = UIView()
    
    
    let listView = UIImageView.init(image: UIImage.init(named: "Rectangle 45"))
    
    
    var handle:((Int)->())?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.add(listBoxView) { v in
            v.snp.makeConstraints { make in
                
                make.bottom.equalToSuperview().offset(-18)
                make.left.right.equalToSuperview().inset(13)
                make.top.equalToSuperview().offset(16)
            }
        }
        
        listBoxView.add(listView) { v in
            listView.isUserInteractionEnabled = true
            v.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.bottom.equalToSuperview()
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func listViews(_ data: [dayslegsModel]) {
        
        listView.subviews.forEach { item in
            if item.isKind(of: UIImageView.self) {
                return
            }
            item.removeFromSuperview()
        }
        
        var pre: UIView?
        data.enumerated().forEach { item in
            let v = YTPView.init(iconN: item.element.person ?? "", name:item.element.downward ?? "", isok: (item.element.floor! == 1 ? true : false)  )
            v.isUserInteractionEnabled = true
            v.tag = item.offset
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(listAdd(g:)))
            v.addGestureRecognizer(tap)
            listView.add(v) { subView in
                subView.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    if item.offset == 0 {
                        make.top.equalToSuperview()
                    } else {
                        make.top.equalTo(pre!.snp.bottom)
                        
                        if item.offset == data.count - 1 {
                            make.bottom.equalToSuperview().offset(-12)
                        }
                    }
                }
                pre = subView
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
