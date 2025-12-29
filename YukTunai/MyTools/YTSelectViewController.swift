//
//  YTSelectViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/21.
//

import UIKit

class YTSelectViewController: YTBaseViewController,UITableViewDelegate,UITableViewDataSource {

    var onKeluarButtonTapped: ((String?) -> Void)?
    
    var model: [roseModel]? {
        didSet {
            tableView.reloadData()
        }
    }

    let tableView = YTTableView()
    
    let box = UIView()
    
    let b1 = UILabel.init(title: YTTools.areaTitle(a: "Select", b: "SelectMemilih"),textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 22, weight: .bold))
    
    let clos = UIButton.init(title: "", image: "bacfewe")
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Confirmation", b: "Konfirmasi"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    
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
        
        
        box.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(b1.snp.bottom).offset(40)
            make.height.equalTo(280)
        }
        
        
        button.addTarget(self, action: #selector(nextA), for: .touchUpInside)
        button.cornersSet(by: .allCorners, radius: 25)
        button.setBgColor(color: .init(hex: "#6D90F5"))
        box.add(button) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(20)
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
        
        tableView.register(YTSelectViewCellController.self, forCellReuseIdentifier: YTSelectViewCellController.identifier)
    }
    
    
    @objc func nextA(){
        let i = model!.filter({$0.selected == true}).first?.ensued
        onKeluarButtonTapped?(i)
        dismiss(animated: false)
    }
    
    @objc func cloasea(){
       
        dismiss(animated: false)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model ?? []).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YTSelectViewCellController.identifier, for: indexPath) as? YTSelectViewCellController else {
            return UITableViewCell()
        }
        
        if let m = model?[indexPath.row] {
            cell.b1.text = m.ensued
            if m.selected {
                cell.b1.textColor = .init(hex: "#5F7FF4")
                cell.box.backgroundColor = .init(hex: "#ECF0FF")
            } else {
                cell.b1.textColor = .init(hex: "#121212",alpha: 0.5)
                cell.box.backgroundColor = .white
            }
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model?.forEach({$0.selected = false})
        model?[indexPath.row].selected = true
        tableView.reloadData()
    }
  

}



class YTSelectViewCellController: UITableViewCell {
    
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
