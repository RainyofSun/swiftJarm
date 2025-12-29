//
//  YTProductListViewController.swift
//  YukTunai
//  diyyixiang
//  Created by whoami on 2024/11/23.
//

import UIKit
import SmartCodable



class homesModel: SmartCodable {
    var discourse: [discourseModel]?
    required init(){}
}

class discourseModel: SmartCodable {
    var downward: String?   //标题
    var hind: String? //提示
    var eyelid: String?  //上传的键名
    var pronounced: String?  //类型
    var performance: String?  //回显值
    var directly: String?  //回显key
    var roars: String?  //inputType=1 使用数字键盘
    var rose:[roseModel]?
    required init(){}
}



class roseModel: SmartCodable {
    var ensued: String?
    var directly: String?
    var selected: Bool = false
    required init(){}
}



class YTProductListViewController: YTBaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    let viewModel = ApiViewModel()
    
    var model: homesModel?
    
    var t: String?
    
    var pid: String?
    
    var time: Date?
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Next", b: "Berikutnya"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    let table = YTTableView()
    
    let uploadS = upapisServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        time = Date()
        
        uploadS.full { retul in
            switch retul {
            case .success(let success):
//                SVProgressHUD.showInfo(withStatus: "获取地址骶椎成功")
                (success?.upper)!.forEach {[weak self] item in
                    YTAddressTools.shared.savefollowed(item)
                }
                break
            case .failure(let failure):
//                SVProgressHUD.showInfo(withStatus: "获取地址骶椎失败----\(failure)")
                break
            }
        }
        
        view.backgroundColor = .white
        
        setNavigationBarTitle(t ?? "")
        
        
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
        
        
        view.add(table) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.bottom.equalTo(button.snp.top).offset(-20)
                make.top.equalTo(cBar.snp.bottom).offset(10)
            }
        }
        table.delegate = self
        table.dataSource = self
        table.register(ProductListItemView.self, forCellReuseIdentifier: ProductListItemView.identifier)
        table.register(ProductListSelectItemView.self, forCellReuseIdentifier: ProductListSelectItemView.identifier)
        table.register(ProductListCityItemView.self, forCellReuseIdentifier: ProductListCityItemView.identifier)
        
        
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        viewModel.homes(avp: ["erect": pid!]) { [weak self] re in
            switch re {
            case .success(let success):
                SVProgressHUD.dismiss()
                
                self?.setNavigationBarTitle(self?.t ?? "")
                
                var m = success?.upper

                for item in m!.discourse! {
                    if (item.rose ?? []).count == 0 {
                        let m = roseModel.init()
                        m.selected = true
                        m.directly = item.performance
                        item.rose?.insert(m, at: 0)
                    } else {
                        for i in item.rose! {
                            if i.directly! == item.directly {
                                i.selected = true
                            }
                        }
                    }
                }
                
                
                self?.model = m
                
                self?.table.reloadData()
                
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.discourse ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let m = model?.discourse?[indexPath.row] else {
            return UITableViewCell()
        }
        
        if m.pronounced == "hands" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListSelectItemView.identifier, for: indexPath) as? ProductListSelectItemView else {
                return UITableViewCell()
            }
            cell.t1.text = m.downward
            cell.t2.placeholder = m.hind
            
            
            if let i = model?.discourse?[indexPath.row].rose?.filter({$0.ensued == m.performance}).first {
                cell.t2.text = i.ensued
            }
           
            
            cell.handl = {[weak self] in
                let vc = YTSelectViewController.init()
               
                vc.modalPresentationStyle = .overFullScreen
               
                self?.present(vc, animated: false)
                vc.model = m.rose
                
                vc.onKeluarButtonTapped = { model in
                    cell.t2.text = model
                }
            }
            return cell
        } else if m.pronounced == "duels" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListItemView.identifier, for: indexPath) as? ProductListItemView else {
                return UITableViewCell()
            }
            cell.t1.text = m.downward
            cell.t2.placeholder = m.hind
            cell.t2.delegate = self
            cell.t2.tag = indexPath.row
            if let m21 = model?.discourse?[indexPath.row].performance {
                cell.t2.text = m21
            }
            if m.roars == "1" {
                cell.t2.keyboardType = .numberPad
            } else {
                cell.t2.keyboardType = .default
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListCityItemView.identifier, for: indexPath) as? ProductListCityItemView else {
                return UITableViewCell()
            }
            cell.t1.text = m.downward
            cell.t2.placeholder = m.hind
            
            if let m21 = model?.discourse?[indexPath.row].performance {
                cell.t2.text = m21
            }
            
            
            cell.handl = {[weak self] in
                let pathaddress = YTAddressTools.init()
                let addressmodel = pathaddress.loadfollowedModels()
                let m21 = self?.model?.discourse?[indexPath.row].performance ?? ""
                let vc = YTAddressViewController.init(defualt: m21, defaultModel: addressmodel, model: addressmodel)
                vc.modalPresentationStyle = .overFullScreen
                self?.present(vc, animated: false)
                
                vc.handle = {v in
                    let m = roseModel.init()
                    m.selected = true
                    m.directly = v
                    self?.model?.discourse?[indexPath.row].rose?.insert(m, at: 0)
                    self?.model?.discourse?[indexPath.row].performance = v
                    cell.t2.text = v
                }
            }
           
            
            
            return cell
        }
        
        
    }

    
    @objc func nextA(){
        var result: [String: String] = [:]
        // 遍历每个对象
        for item in model!.discourse! {
            // 找到 rose 数组中 selected 为 1 的直接值
            if let selectedRose = item.rose!.first(where: { $0.selected == true }) {
                result[item.eyelid!] = selectedRose.directly!
            }
        }
        result["erect"] = pid!

        
        print(result)
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        viewModel.went(avp: result) {[weak self] r in
            switch r {
            case .success(let success):
                SVProgressHUD.dismiss()
                
                let data: [String: Any] = ["obliged": "4", "nasty": "\(((self?.time) ?? Date()).timeIntervalSince1970)","newcomers":"\(Date().timeIntervalSince1970)"]
                NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: data)
                
                self?.navigationController?.popViewController(animated: true)
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

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           let currentText = textField.text ?? ""
           let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let m = roseModel.init()
        m.selected = true
        m.directly = newText
        model?.discourse?[textField.tag].rose?.insert(m, at: 0)
//        model?.discourse?[textField.tag].performance = newText
        return true
       }
    
}







class ProductListItemView: UITableViewCell {
    
    let t1 = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
    
    let box = UIView.init(bgColor: .init(hex: "#F4F8FF"))
    
    let t2 = YTTextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(t1)
        t1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(13)
        }
        
        contentView.addSubview(box)
        box.cornersSet(by: .allCorners, radius: 12)
        box.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(t1.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
        
        t2.font = .systemFont(ofSize: 16)
        t2.textColor = .init(hex: "#212121")
        box.addSubview(t2)
        t2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.bottom.top.equalToSuperview()
            make.right.equalToSuperview().offset(-13)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



class ProductListSelectItemView: UITableViewCell {
    
    let t1 = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
    
    let box = UIView.init(bgColor: .init(hex: "#F4F8FF"))
    
    let t2 = YTTextField()
    
    let imagec = UIImageView.init(image: UIImage.init(named: "feeev1223"))
    
    var handl:(()->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(t1)
        t1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(13)
        }
        
        contentView.addSubview(box)
        box.cornersSet(by: .allCorners, radius: 12)
        box.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(t1.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
        
        t2.isUserInteractionEnabled = false
        t2.font = .systemFont(ofSize: 16)
        t2.textColor = .init(hex: "#212121")
        box.addSubview(t2)
      
        
        box.addSubview(imagec)
        imagec.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-13)
        }
        
        t2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.bottom.top.equalToSuperview()
            make.right.equalTo(imagec.snp.left).offset(-13)
        }
        
        let t = UITapGestureRecognizer.init(target: self, action: #selector(click))
        box.addGestureRecognizer(t)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func click(){
        print("fwefew")
        handl?()
    }
}



class ProductListCityItemView: UITableViewCell {
    
    let t1 = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
    
    let box = UIView.init(bgColor: .init(hex: "#F4F8FF"))
    
    let t2 = YTTextField()
    
    var handl:(()->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(t1)
        t1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(13)
        }
        
        contentView.addSubview(box)
        box.cornersSet(by: .allCorners, radius: 12)
        box.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(t1.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(52)
            make.bottom.equalToSuperview()
        }
        
        t2.font = .systemFont(ofSize: 16)
        t2.isUserInteractionEnabled = false
        t2.textColor = .init(hex: "#212121")
        box.addSubview(t2)
        t2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.bottom.top.equalToSuperview()
            make.right.equalToSuperview().offset(-13)
        }
        
        box.isUserInteractionEnabled = true
        let t = UITapGestureRecognizer.init(target: self, action: #selector(click))
        box.addGestureRecognizer(t)
        
    }
    
    @objc func click(){
        print("fwefew")
        handl?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
