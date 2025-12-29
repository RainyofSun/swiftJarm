//
//  YTAddressViewController.swift
//  YukTunai
//
//  Created by whoami on 2024/11/26.
//

import UIKit


class YTAddressItem: UIView {
    
    
    let a1 = UILabel.init(title: "District",textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 16))
    
    let image = UIImageView.init(image: UIImage.init(named: "FWFW12323"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
     
        
        add(image) {v in
            v.snp.makeConstraints { make in
                make.right.equalToSuperview()
                make.height.width.equalTo(18)
                make.centerY.equalToSuperview()
            }
        }
        
        add(a1) { v in
            v.snp.makeConstraints { make in
                make.left.top.bottom.equalToSuperview()
                make.height.equalTo(22)
                make.right.equalTo(image.snp.left)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}



class YTAddressViewController: YTBaseViewController,UITableViewDataSource,UITabBarDelegate, UITableViewDelegate {
    
    
    
    var onKeluarButtonTapped: ((String?) -> Void)?
    
    let tableView = YTTableView()
    
    let box = UIView()
    
    let b1 = UILabel.init(title: YTTools.areaTitle(a: "Select address", b: "SelectMemilih"),textColor: .init(hex: "#000000"),font: .systemFont(ofSize: 22, weight: .bold))
    
    let b2 = UILabel.init(title: YTTools.areaTitle(a: "Please Select City", b: "Silakan pilih alamat"),textColor: .init(hex: "#000000"),font: .systemFont(ofSize: 16, weight: .bold))
    
    let clos = UIButton.init(title: "", image: "bacfewe")
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Confirmation", b: "Konfirmasi"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    var s1: Int?
    
    var s2: Int?
    
    var s3: Int?
    
    var defaultModel: [followedModels]?
    
    var model:[followedModels]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    let a1 = YTAddressItem.init()
    
    let a2 = YTAddressItem.init()
    
    let a3 = YTAddressItem.init()
    
    init(defualt: String?,defaultModel:[followedModels],model: [followedModels]) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.defaultModel = defaultModel
        
        if let d = defualt {
            if let t = YTTools.findIndexes(from: d, in: defaultModel) {
                
                s1 = t.index1
                s2 = t.index2
                s3 = t.index3
                
                let v = YTTools.getLookingValues(model: defaultModel, index1: t.index1, index2: t.index2, index3: t.index3)
                a1.a1.text = v?.level1Looking ?? ""
                a2.a1.text = v?.level2Looking ?? ""
                a3.a1.text = v?.level3Looking ?? ""
                
                a1.a1.textColor = .init(hex: "#151940")
                a2.a1.textColor = .init(hex: "#151940")
                a3.a1.textColor = .init(hex: "#151940")
                
                let m = defaultModel[t.index1].followed?[t.index2].followed
                m?.forEach({$0.choised = false})
                m?[t.index3].choised = true
                self.model = m
            } else {
                self.model = model
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var handle:((String)->Void)?
    
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
        b1.textAlignment = .center
        b1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(13)
        }
        
        let listBu = UIView()
        box.addSubview(listBu)
        listBu.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(26)
            make.top.equalTo(b1.snp.bottom).offset(40)
            
            listBu.add(a1) { v in
              
                v.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.top.equalToSuperview()
                }
            }
            
            listBu.add(a2) { v in
              
                v.snp.makeConstraints { make in
                    make.top.equalTo(a1.snp.bottom).offset(12)
                    make.left.right.equalToSuperview()
                }
            }
            
            listBu.add(a3) { v in
                
                v.snp.makeConstraints { make in
                    make.top.equalTo(a2.snp.bottom).offset(12)
                    make.left.right.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            }
        }
        
        let li = UIView.init(bgColor: .init(hex: "#D8D8D8"))
        box.addSubview(li)
        li.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.left.right.equalToSuperview().inset(26)
            make.top.equalTo(listBu.snp.bottom).offset(16)
        }
        
        
        box.addSubview(b2)
        b2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(26)
            make.top.equalTo(li.snp.bottom).offset(16)
        }
        
        box.addSubview(tableView)
        tableView.register(YTAddressCellController.self, forCellReuseIdentifier: YTAddressCellController.identifier)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(26)
            make.top.equalTo(b2.snp.bottom).offset(16)
            make.height.equalTo(280)
        }
        
        
        button.addTarget(self, action: #selector(nextA), for: .touchUpInside)
        button.cornersSet(by: .allCorners, radius: 25)
        button.setBgColor(color: .init(hex: "#6D90F5"))
        box.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(26)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -20 : -39)
                make.height.equalTo(50)
                make.top.equalTo(tableView.snp.bottom).offset(36)
            }
        }
        
        box.addSubview(clos)
        clos.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(b1)
            make.left.equalToSuperview().offset(18)
        }
        
        clos.addTarget(self, action: #selector(cloasea), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let at = UITapGestureRecognizer.init(target: self, action: #selector(a1a))
        a1.addGestureRecognizer(at)
        
        let at2 = UITapGestureRecognizer.init(target: self, action: #selector(a2a))
        a2.addGestureRecognizer(at2)
        
    }
    
    @objc func cloasea(){
        
        dismiss(animated: false)
    }
    
    
    @objc func nextA(){
        
        guard let indx = s1,
              let secend = s2,
              let third = s3 else {
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.showError(withStatus: "Silakan pilih alamat lengkap")
            SVProgressHUD.dismiss(withDelay: 1.5)
            return
        }
        
        // 取出对应的数据
        let v = YTTools.extractLookingValues(model: defaultModel!, index1: indx, index2: secend, index3: third)
        
        handle?(v ?? "")
        
        dismiss(animated: false)
    }
    
    
    func findeSelectedInt() -> Int {
        if  s1 == nil {
            return 0
        } else if s2 == nil {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YTAddressCellController.identifier, for: indexPath) as?  YTAddressCellController else {
            return UITableViewCell()
        }
        
        
        if let name = model?[indexPath.row]  {
            cell.b1.text = name.ensued
            if name.choised {
                cell.b1.textColor = .init(hex: "#5F7FF4")
                cell.box.backgroundColor = .init(hex: "#ECF0FF")
            } else {
                cell.b1.textColor = .init(hex: "#121212",alpha: 0.6)
                cell.box.backgroundColor = .clear
                
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if findeSelectedInt() == 0 {
            s2 = nil
            s3 = nil
            s1 = indexPath.row
            let m = model?[indexPath.row].ensued
            a1.a1.text = m
            a1.a1.textColor =  .init(hex: "#151940")
            
            a2.a1.text =  "District"
            a2.a1.textColor =  .init(hex: "#5F7FF4")
            a3.a1.text = "District"
            a3.a1.textColor = .init(hex: "#5F7FF4")
            let ne = model?[indexPath.row].followed
            
            ne?.forEach({$0.choised = false})
            model = ne
            
        } else if findeSelectedInt() == 1 {
            s3 = nil
            s2 = indexPath.row
            
            let m = model?[indexPath.row].ensued
            a2.a1.text = m
            a3.a1.text = "District"
            a2.a1.textColor = .init(hex: "#151940")
            a3.a1.textColor =  .init(hex: "#5F7FF4")
            let ne = model?[indexPath.row].followed
            
            ne?.forEach({$0.choised = false})
            model = ne
            
        } else {
            
            s3 = indexPath.row
            let m = model?[indexPath.row].ensued
            a3.a1.text = m
            a3.a1.textColor = .init(hex: "#151940")
            model?.forEach({$0.choised = false})
            model?[indexPath.row].choised = true
            tableView.reloadData()
        }
    }
    
    @objc func a1a(){
        if s1 == nil {
            return
        }
        let models = defaultModel
        self.model = models
        s2 = nil
        s3 = nil
        s3 = nil
        a2.a1.text = "District"
        a3.a1.text = "District"
        a2.a1.textColor = .init(hex: "#5771F9")
        a2.a1.textColor = .init(hex: "#5771F9")
        a3.a1.textColor = .init(hex: "#5771F9")
        
        let m = model?[s1!].ensued
        a1.a1.text = m
        
        let o = defaultModel
        o?.forEach({$0.choised = false})
        o?[s1!].choised = true
        model = o
        
        s1 = nil
    }
    
    @objc func a2a(){
        if s2 == nil {
            return
        }
        s3 = nil
        
        a3.a1.text = "District"
        
        let m = defaultModel?[s1!].followed?[s2!].ensued
        a2.a1.text = m
        
        a3.a1.text = "District"
        a3.a1.textColor =  .init(hex: "#5771F9")
        
        let o = defaultModel?[s1!].followed?[s2!].followed
        o?.forEach({$0.choised = false})
        o?[s2!].choised = true
        model = o
    }
    
}











class YTAddressCellController: UITableViewCell {
    
    let b1 = UILabel.init(title: "",textColor: .init(hex: "#121212",alpha: 0.6),font: .systemFont(ofSize: 18))
    
    let box = UIView()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.add(box) { v in
            box.cornersSet(by: .allCorners, radius: 12)
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(22)
                make.top.bottom.equalToSuperview().inset(12)
            }
        }
        
        box.addSubview(b1)
        b1.textAlignment = .center
        b1.cornersSet(by: .allCorners, radius: 12)
        b1.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 8, left: 12, bottom: 8, right: 12))
        }
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
