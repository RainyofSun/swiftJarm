//
//  YTYSHViewController.swift
//  YukTunai
//
//  Created by whoami on 2024/12/1.
//

import UIKit

class YTYSHViewController: YTBaseViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
   
    let viewmodel = InitApiServices()
    
    let table = YTTableView()
    
    var md:reddddd?
    
    let button = UIButton.init(title: YTTools.areaTitle(a: "Next", b: "Berikutnya"), font: .systemFont(ofSize: 18, weight: .bold), color: .white)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setNavigationBarTitle("Pre-review")
        
        button.isHidden = true
        button.addTarget(self, action: #selector(submitData), for: .touchUpInside)
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
        table.isHidden = true
        
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        viewmodel.rrrrrr {[weak self] r in
            switch r {
            case .success(let b):
                SVProgressHUD.dismiss()
                self?.table.reloadData()
                self?.md = b?.upper
                self?.button.isHidden = false
                self?.table.isHidden = false
                break
            case .failure(let e):
                break
            }
        }
        
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductListItemView.identifier, for: indexPath) as? ProductListItemView else {
            return UITableViewCell()
        }
        
        cell.t2.placeholder = YTTools.areaTitle(a: "Please enter", b: "Silakan masukkan")
        cell.t2.delegate = self
        
        cell.t2.tag = indexPath.row
        
        if indexPath.row == 0 {
            cell.t1.text = YTTools.areaTitle(a: "Name", b: "Nama")
            cell.t2.text = md?.ensued ?? ""
            cell.t2.keyboardType = .default
        } else if indexPath.row == 1 {
            cell.t1.text = YTTools.areaTitle(a: "Phone Number", b: "Nomor Telepon")
            cell.t2.keyboardType = .numberPad
            cell.t2.text = md?.full ?? ""
        } else if indexPath.row == 2 {
            cell.t1.text = YTTools.areaTitle(a: "ID Number", b: "Nomor ID")
            cell.t2.keyboardType = .numberPad
            cell.t2.text = md?.tumult ?? ""
        } else if indexPath.row == 3 {
            cell.t1.text = YTTools.areaTitle(a: "Bank Card Number", b: "Bank Card Number")
            cell.t2.keyboardType = .numberPad
            cell.t2.text = md?.pipe ?? ""
        }
        
        return cell
    }
    
    var texts: [Int:String] = [:]
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           let currentText = textField.text ?? ""
           let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        texts[textField.tag] = newText
            return true
       }
    
    @objc func submitData(){
    
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.dismiss(withDelay: 1.5)
        
        guard let a1 = texts[0] else {
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter name!", b: "Silakan masukkan nama!"))
            return
        }
        
        guard let a2 = texts[1] else {
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter phone number!", b: "Silakan masukkan nomor telepon!"))
            return
        }
        
        guard let a3 = texts[2] else {
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter ID number!", b: "Silakan masukkan nomor ID!"))
            return
        }
        
        guard let a4 = texts[3] else {
            SVProgressHUD.showInfo(withStatus: YTTools.areaTitle(a: "Please enter bank card number!", b: "Silakan masukkan nomor kartu bank!"))
            return
        }
        
        SVProgressHUD.show()
        viewmodel.hjnca(avp: ["ensued":"\(a1)",
                              "absurd":"\(a2)",
                              "tumult":"\(a3)",
                              "bankNumber":"\(a4)",]) {[weak self] result in
            switch result {
            case .success(let success):
                let vc = YTYSHRViewController()
                vc.title3V.text = "\(success?.upper?.soft ?? "")%"
                self?.navigationController?.pushViewController(vc, animated: true)
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
    

}
