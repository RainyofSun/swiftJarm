//
//  YTDibankViewController.swift
//  YukTunai
//
//  Created by whoami on 2024/11/23.
//

import UIKit

class YTDibankViewController: YTBaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    let viewModel = ApiViewModel()
    
    var model: homesModel?
    
    var t: String?
    
    var pid: String?
    
    var time: Date?
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Next", b: "Berikutnya"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)
    
    let table = YTTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setNavigationBarTitle(t ?? "")
        
        time = Date()
        
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
        
        
        
        
        
        
        
        viewModel.arrogant(avp: ["erect": pid!]) { [weak self] re in
            switch re {
            case .success(let success):
                

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
                
                
                
                SVProgressHUD.showInfo(withStatus: failure.description)
                break
            }
        }
        
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
            
            
            if let i = model?.discourse?[indexPath.row].rose?.filter({$0.directly == m.performance}).first {
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
            if m.roars == "1" {
                cell.t2.keyboardType = .numberPad
            } else {
                cell.t2.keyboardType = .default
            }
            if let m21 = model?.discourse?[indexPath.row].performance {
                cell.t2.text = m21
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
        
        
        
        let vc = YTConfirmBankViewController.init()
        vc.l = result
        vc.b2.text =  result["confirmCardNo"]
        vc.pid = pid
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: false)
        
        vc.onHandle = {[weak self] in
            
            let data: [String: Any] = ["obliged": "7", "nasty": "\(((self?.time) ?? Date()).timeIntervalSince1970)","newcomers":"\(Date().timeIntervalSince1970)"]
            NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: data)
            
            self?.navigationController?.popViewController(animated: true)
        }

    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           let currentText = textField.text ?? ""
           let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let m = roseModel.init()
        m.selected = true
        m.directly = newText
        model?.discourse?[textField.tag].rose?.insert(m, at: 0)
        return true
       }


}
