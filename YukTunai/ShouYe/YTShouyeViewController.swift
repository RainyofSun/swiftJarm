//
//  YTShouyeViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit
import CoreLocation

class YTShouyeViewController: YTBaseViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate{
    
    let viewModel = ApiViewModel()
    
    let uploadS = upapisServices()
    
    var model: homeModel?
    
    let tableView = YTTableView()
    
    var refreshing: Bool = false
    
    let locationManager = YTLocationHelper.sharedInstance()
    
    let locationPermissionManager = LocationPermissionManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(true, animated: true)
        setBarBgHidden()
        
        view.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginOK), name: Notification.Name(rawValue: "loginOK"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: Notification.Name(rawValue: "logout"), object: nil)
        
        tableView.backgroundColor = UIColor.init(hex: "#2864D7")
        
        view.add(tableView) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 0, bottom: YTTools.isIPhone6Series() ? 55 : 90, right: 0))
            }
        }
        
        tableView.register(YTShouyeT1TableViewCell.self, forCellReuseIdentifier: YTShouyeT1TableViewCell.identifier)
        tableView.register(YTShouyeT2TableViewCell.self, forCellReuseIdentifier: YTShouyeT2TableViewCell.identifier)
        tableView.register(YTShouyeT3TableViewCell.self, forCellReuseIdentifier: YTShouyeT3TableViewCell.identifier)
        tableView.register(YTShouyeT4TableViewCell.self, forCellReuseIdentifier: YTShouyeT4TableViewCell.identifier)
        tableView.register(YTShouyeListItemTableViewCell.self, forCellReuseIdentifier: YTShouyeListItemTableViewCell.identifier)
        tableView.register(YTShouyeListItemHeaderTableViewCell.self, forCellReuseIdentifier: YTShouyeListItemHeaderTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        reloadDataS()
        
        addOb()
        
        uploadInfo()
        
        
        if YTUserDefaults.shared.gash == "2" {
            locationPermissionManager.checkLocationPermission(from: self)
        }
    }
    
    func reloadDataS(){
        
        DispatchQueue.main.asyncAfter(deadline: .now()){
            CKTrackingManager.shared().requestAuthorization { s, v in
                upapisServices.shard.googleMarket(avp: v as! [String:String]) { resuult in
                    switch resuult {
                    case .success(let success):
                        print("google upload success---------google upload success------google upload success")
                        break
                    case .failure(let failure):
                        print("google upload error---------google upload error------google upload error")
                        break
                    }
                }
            }
        }
        
        let deviceInfo = DeviceInformationModel.uploadDeviceInfos()
        upapisServices.shard.approach(avp: ["upper":deviceInfo]) { result in
            switch result {
            case .success(let success):
                print("device upload success---------device upload success------device upload success")
                break
            case .failure(let failure):
                print("device upload error---------device upload error------device upload error")
                break
            }
        }
        
        uploadInfo()
        
        if YTUserDefaults.shared.gash == "2" {
            locationPermissionManager.checkLocationPermission(from: self)
        }
        
        YTLocationHelper.sharedInstance().requestLocation(withTimeout: 5) {[weak self] location, error in
             if let location = location {
                 let geocoder = CLGeocoder.init()
                 geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                     guard self != nil else { return }
                     if let placemark = placemarks?.first {
                         let info =  YTLocationHelper.sharedInstance().locationDetail(placemark, loca: location) as! [String:String]
                         upapisServices.shard.courageous(avp: info) { r in
                             switch r {
                             case .success(_):
                                 print("shang bao weizhi xinxi chenggong ------------shang bao weizhi xinxi chenggong ------------shang bao weizhi xinxi chenggong ------------ ")
                                 break
                             case .failure(_):
                                 print("shang bao weizhi xinxi chu cuo ------------ ")
                                 break
                             }
                         }
                     }
                 }
             } else if error != nil {
                print("shang bao weizhi xinxi chu cuo ")
             }
         }
        
        refreshing = true
        
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
        
        viewModel.home {[weak self] re in
            switch re {
            case .success(let success):
                
                self?.refreshing = false
                
                SVProgressHUD.dismiss()
                
                self?.model = success?.upper
                
                self?.tableView.reloadData()
                
                break
            case .failure(let failure):
                self?.refreshing = false
//                SVProgressHUD.setDefaultStyle(.dark)
//                SVProgressHUD.setDefaultMaskType(.clear)
//                SVProgressHUD.dismiss(withDelay: 1.5)
//                SVProgressHUD.showError(withStatus: failure.description)
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadDataS()
        
        DispatchQueue.main.asyncAfter(deadline: .now()){
            CKTrackingManager.shared().requestAuthorization { s, v in
                upapisServices.shard.googleMarket(avp: v as! [String:String]) { resuult in
                    switch resuult {
                    case .success(let success):
                        print("google upload success---------google upload success------google upload success")
                        break
                    case .failure(let failure):
                        print("google upload error---------google upload error------google upload error")
                        break
                    }
                }
            }
        }
        
        let deviceInfo = DeviceInformationModel.uploadDeviceInfos()
        upapisServices.shard.approach(avp: ["upper":deviceInfo]) { result in
            switch result {
            case .success(let success):
                print("device upload success---------device upload success------device upload success")
                break
            case .failure(let failure):
                print("device upload error---------device upload error------device upload error")
                break
            }
        }
        
        
        
        YTLocationHelper.sharedInstance().requestLocation(withTimeout: 5) {[weak self] location, error in
             if let location = location {
                 let geocoder = CLGeocoder.init()
                 geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                     guard let self = self else { return }
                     if let placemark = placemarks?.first {
                         let info =  YTLocationHelper.sharedInstance().locationDetail(placemark, loca: location) as! [String:String]
                         upapisServices.shard.courageous(avp: info) { r in
                             switch r {
                             case .success(let success):
                                 print("shang bao weizhi xinxi chenggong ------------shang bao weizhi xinxi chenggong ------------shang bao weizhi xinxi chenggong ------------ ")
                                 break
                             case .failure(let failure):
                                 print("shang bao weizhi xinxi chu cuo ------------ ")
                                 break
                             }
                         }
                     }
                 }
             } else if let error = error {
                print("shang bao weizhi xinxi chu cuo ")
             }
         }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if refreshing {
            return
        }
        if scrollView.contentOffset.y < -90 {
            refreshing = true
            SVProgressHUD.show()
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.clear)
            reloadDataS()
        }
    }
    
    @objc func loginOK(){
        reloadDataS()
    }
    
    @objc func logout(){
        reloadDataS()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let item = model?.along?.filter({$0.directly == "eyelid"}),item.count > 0  else {
            return 4
        }
        
        return 1+(item.first?.marched ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if model?.along?.filter({$0.directly == "dexterous"}).first  != nil {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeListItemHeaderTableViewCell.identifier, for: indexPath) as? YTShouyeListItemHeaderTableViewCell else {
                    return UITableViewCell()
                }
                
                
                if let item = model?.along?.filter({$0.directly == "dexterous"}).first?.marched?.first {
                    // 小卡位
                    
                    cell.name.isHidden = false
                    
                    cell.subName.isHidden = false
                    
                    cell.price.isHidden = false
                    
                    cell.icon.isHidden = false
                    
                    cell.buttonname.isHidden = false
                    
                    cell.buttonicon.isHidden = false
                    
                    cell.lyBox.isHidden = false
                    
                    cell.icon1.isHidden = false
                    cell.l1t.isHidden = false
                    cell.l1tv.isHidden = false
                    
                    cell.bottomView.isHidden = false
                    
                    cell.icon2.isHidden = false
                    cell.l2t.isHidden = false
                    cell.l2tv.isHidden = false
                    
                    cell.icon.sd_setImage(with: URL.init(string: item.neck ?? ""))
                    
                    cell.name.text = item.bare
                    
                    cell.price.text = item.smoky
                    
                    cell.buttonname.text = item.coat
                    
                    cell.l1t.text = item.drunk
                    cell.l1tv.text = item.stalking
                    
                    cell.l2tv.text = item.lead
                    cell.l2t.text = item.sheet
                    
                    let t = UITapGestureRecognizer.init(target: self, action: #selector(xiaokaweidianji))
                    cell.bottomView.isUserInteractionEnabled = true
                    cell.bottomView.addGestureRecognizer(t)
                }
                

                return cell
            }else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeListItemTableViewCell.identifier, for: indexPath) as? YTShouyeListItemTableViewCell else {
                    return UITableViewCell()
                }
                
                if let item = model?.along?.filter({$0.directly == "eyelid"}).first?.marched?[indexPath.row-1] {
                    cell.topimage.sd_setImage(with: URL.init(string: item.neck ?? ""))
                    cell.topname.text = item.bare
                    cell.money.text = item.smoky
                    cell.centerrightButton.text = item.coat!
                    
                    cell.l1t.text = item.drunk!
                    
                    cell.l3t.text = item.sheet!
                    
                    cell.l1tv.text = item.stalking
                    
                    cell.l3tv.text = item.lead
                }
        
                return cell
            }
        } else {
            
            
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeT1TableViewCell.identifier, for: indexPath) as? YTShouyeT1TableViewCell else {
                    return UITableViewCell()
                }
                
                // 大卡位
                if let item = model?.along?.filter({$0.directly == "suabian"}).first?.marched?.first {
                                        
                    cell.name.isHidden = false
                    
                    cell.subName.isHidden = false
                    
                    cell.price.isHidden = false
                    
                    cell.icon.isHidden = false
                    
                    cell.lyBox.isHidden = false
                    
                    cell.l1t.isHidden = false
                    cell.l1tv.isHidden = false
                    
                    cell.l2t.isHidden = false
                    cell.l2tv.isHidden = false
                    
                    cell.icon.sd_setImage(with: URL.init(string: item.neck ?? ""))
                    
                    cell.name.text = item.bare
                    
                    cell.price.text = item.smoky
                    
                    cell.buttonicon.isHidden = false
                    cell.buttonicon.setTitle(title: item.coat ?? "")
                    cell.l1t.text = item.drunk
                    cell.l1tv.text = item.stalking
                    
                    cell.l2tv.text = item.lead
                    cell.l2t.text = item.sheet
                    
                    cell.buttonicon.addTarget(self, action: #selector(dakaweidianji), for: UIControl.Event.touchUpInside)
                }
                
                return cell
            }else if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeT2TableViewCell.identifier, for: indexPath) as? YTShouyeT2TableViewCell else {
                    return UITableViewCell()
                }
                
//                let t = UITapGestureRecognizer.init(target: self, action: #selector(z1))
//                cell.image1.isUserInteractionEnabled = true
//                cell.image1.addGestureRecognizer(t)
//                
//                let t2 = UITapGestureRecognizer.init(target: self, action: #selector(z2))
//                cell.image2.isUserInteractionEnabled = true
//                cell.image2.addGestureRecognizer(t2)
                
                return cell
            }else if indexPath.row == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeT3TableViewCell.identifier, for: indexPath) as? YTShouyeT3TableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }else if indexPath.row == 3 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeT4TableViewCell.identifier, for: indexPath) as? YTShouyeT4TableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
    
    @objc func dakaweidianji(){
        
        if YTUserDefaults.shared.transport.count == 0 {
            let loginVC = YTBaseNavigationController.init(rootViewController: YTLoginViewController())
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        
        if let item = model?.along?.filter({$0.directly == "suabian"}).first?.marched?.first {
            guard let id = item.wide else {
                return
            }
            
            SVProgressHUD.show()
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.clear)
            
            viewModel.gash(avp: ["erect" : id]) {[weak self] re in
                switch re {
                case .success(let success):
                    SVProgressHUD.dismiss()
                    
                    if YTUserDefaults.shared.gash == "1"{
                        
                        if let url = self?.model?.courageous?.loanUrl,  let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                            let v = YT2WebViewController.init(url: completeURL)
                            if let item = self?.model?.along?.filter({$0.directly == "suabian"}).first?.marched?.first {
                                v.buttonname.text =   item.coat
                            }
                           
                            self?.navigationController?.pushViewController(v, animated: true)
                            v.han = {[weak self] in
                                let vc = YTProductViewController()
                                vc.mID = id
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                        
                        return
                    }
                    
                    guard let url = success?.upper?.stride else {
                        return
                    }
                    
                    if url.hasPrefix("http") || url.hasPrefix("https") {
                        if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                            let webView = YTWebViewController.init(url: completeURL)
                            self?.navigationController?.pushViewController(webView, animated: true)
                        }
                    } else if  url.hasPrefix("yu://") {
                        if url.contains("yu://una.kno.s/arrogant") {
                            let pro = YTProductViewController.init()
                            pro.mID = id
                            self?.navigationController?.pushViewController(pro, animated: true)
                        }
                    }
                    
                    break
                case .failure(let failure):
                    SVProgressHUD.dismiss(withDelay: 1.5)
                    SVProgressHUD.showError(withStatus: failure.description)
                    break
                }
            }
        }
    }
    
    @objc func xiaokaweidianji(){
        if YTUserDefaults.shared.transport.count == 0 {
            let loginVC = YTBaseNavigationController.init(rootViewController: YTLoginViewController())
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        if let id = model?.along?.filter({$0.directly == "dexterous"}).first?.marched?.first?.wide {
            viewModel.gash(avp: ["erect" : id]) {[weak self] re in
                switch re {
                case .success(let success):
                    SVProgressHUD.dismiss()
                    
                    if YTUserDefaults.shared.gash == "1"{
                        
                        if let url = self?.model?.courageous?.loanUrl,  let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                            let v = YT2WebViewController.init(url: completeURL)
                            
                            if let item = self?.model?.along?.filter({$0.directly == "dexterous"}).first?.marched?.first {
                                v.buttonname.text =   item.coat
                            }
                           
                            self?.navigationController?.pushViewController(v, animated: true)
                            v.han = {[weak self] in
                                let vc = YTProductViewController()
                                vc.mID = id
                                self?.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                        
                        return
                    }
                    
                    
                    guard let url = success?.upper?.stride else {
                        return
                    }
        
                    
                    if url.hasPrefix("http") || url.hasPrefix("https") {
                        if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                            let webView = YTWebViewController.init(url: completeURL)
                            self?.navigationController?.pushViewController(webView, animated: true)
                        }
                    } else if  url.hasPrefix("yu://") {
                        if url.contains("yu://una.kno.s/arrogant") {
                            let pro = YTProductViewController.init()
                            pro.mID = id
                            self?.navigationController?.pushViewController(pro, animated: true)
                        }
                    }
                    
                    break
                case .failure(let failure):
                    SVProgressHUD.dismiss(withDelay: 1.5)
                    SVProgressHUD.showError(withStatus: failure.description)
                    break
                }
            }
        }
    }
    
    
    @objc func z1(){
        
        if YTUserDefaults.shared.transport.count == 0 {
            let loginVC = YTBaseNavigationController.init(rootViewController: YTLoginViewController())
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        if YTUserDefaults.shared.gash == "1" {
            if let url = model?.courageous?.loanUrl {
                if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                    let webView = YTWebViewController.init(url: completeURL)
                    navigationController?.pushViewController(webView, animated: true)
                }
            }
        } else {
            if let url = model?.courageous?.privateUrl {
                if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                    let webView = YTWebViewController.init(url: completeURL)
                    navigationController?.pushViewController(webView, animated: true)
                }
            }
        }
    }
    
    @objc func z2(){
        
        if YTUserDefaults.shared.transport.count == 0 {
            let loginVC = YTBaseNavigationController.init(rootViewController: YTLoginViewController())
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        if YTUserDefaults.shared.gash == "1" {
            if let url = model?.courageous?.preScore, url > 0 {
                let vc = YTYSHRViewController()
                vc.title3V.text = "\(url)%"
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = YTYSHViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            if let url = model?.courageous?.everystep {
                if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                    let webView = YTWebViewController.init(url: completeURL)
                    navigationController?.pushViewController(webView, animated: true)
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if model?.along?.filter({$0.directly == "dexterous"}).first  == nil {
            return
        }
        
        if YTUserDefaults.shared.transport.count == 0 {
            let loginVC = YTBaseNavigationController.init(rootViewController: YTLoginViewController())
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
            return
        }
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        
        if let id = model?.along?.filter({$0.directly == "eyelid"}).first?.marched?[indexPath.row-1].wide {
            viewModel.gash(avp: ["erect" : id]) {[weak self] re in
                switch re {
                case .success(let success):
                    SVProgressHUD.dismiss()
                    guard let url = success?.upper?.stride else {
                        return
                    }
                    
                    if url.hasPrefix("http") || url.hasPrefix("https") {
                        if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                            let webView = YTWebViewController.init(url: completeURL)
                            self?.navigationController?.pushViewController(webView, animated: true)
                        }
                    } else if  url.hasPrefix("yu://") {
                        if url.contains("yu://una.kno.s/arrogant") {
                            let pro = YTProductViewController.init()
                            pro.mID = id
                            self?.navigationController?.pushViewController(pro, animated: true)
                        }
                    }
                    
                    break
                case .failure(let failure):
                    SVProgressHUD.dismiss(withDelay: 1.5)
                    SVProgressHUD.showError(withStatus: failure.description)
                    break
                }
            }
        }
    }
    

}


extension Notification.Name {
    static let myNotification = Notification.Name("myNotification")
}


extension YTShouyeViewController {
    
    func addOb(){
        NotificationCenter.default.addObserver(forName: .myNotification, object: nil, queue: .main) {[weak self] notification in
            if YTUserDefaults.shared.gash == "1" {
                return
            }
            self?.locationManager.requestLocation(withTimeout: 15) {[weak self] location, error in
                if let location = location {
                    let geocoder = CLGeocoder.init()
                    geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                        guard let self = self else { return }
                        if let placemark = placemarks?.first {
                            let info = self.locationManager.locationDetail(placemark, loca: location)
                            var upInfo = ["dialect":YTIDFVKeychainHelper.retrieveIDFV(),
                                          "forward":"2",
                                          "mustaches":locationManager.longitude(from: location),
                                          "smooth":locationManager.latitude(from: location),
                                          "called":ASIdentifierManager.shared().advertisingIdentifier.uuidString]
                            
                            if let userInfo = notification.userInfo,
                               let a = userInfo["obliged"] as? String,
                               let b = userInfo["nasty"] as? String,
                               let c = userInfo["newcomers"] as? String {
                                upInfo["obliged"] = a
                                upInfo["nasty"] = b
                                upInfo["newcomers"] = c
                                
                                if let de = userInfo["procession"] as? String {
                                    upInfo["procession"] = de
                                }
                                
                                self.uploadS.tumult(avp: upInfo) { r in
                                    switch r {
                                    case .success(let success):
                                        print("shang bao maidian chenggong ------------shang bao weizhi maidian chenggong ------------shang bao weizhi maidian chenggong ------------ ")
                                        break
                                    case .failure(let failure):
                                        print("shang bao weizhi maidian chu cuo ------------ ")
                                        break
                                    }
                                }
                            }
                        }
                    }
                } else if let error = error {
                    var upInfo = ["dialect":YTIDFVKeychainHelper.retrieveIDFV(),
                                  "forward":"2",
                                  "mustaches":"",
                                  "smooth":"",
                                  "called":ASIdentifierManager.shared().advertisingIdentifier.uuidString]
                    
                    if let userInfo = notification.userInfo,
                       let a = userInfo["obliged"] as? String,
                       let b = userInfo["nasty"] as? String,
                       let c = userInfo["newcomers"] as? String {
                        upInfo["obliged"] = a
                        upInfo["nasty"] = b
                        upInfo["newcomers"] = c
                        
                        if let de = userInfo["procession"] as? String {
                            upInfo["procession"] = de
                        }
                        
                        self?.uploadS.tumult(avp: upInfo) { r in
                            switch r {
                            case .success(let success):
                                print("meiyou dingeweshang bao maidian chenggong ------------shang bao weizhi maidian chenggong ------------shang bao weizhi maidian chenggong ------------ ")
                                break
                            case .failure(let failure):
                                print("meiyou dingeweshang bao weizhi maidian chu cuo ------------ ")
                                break
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func uploadInfo(){
       locationManager.requestLocation(withTimeout: 15) {[weak self] location, error in
            if let location = location {
                let geocoder = CLGeocoder.init()
                geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                    guard let self = self else { return }
                    if let placemark = placemarks?.first {
                        let info = self.locationManager.locationDetail(placemark, loca: location) as! [String:String]
                        self.uploadS.courageous(avp: info) { r in
                            switch r {
                            case .success(let success):
                                print("shang bao weizhi xinxi chenggong ------------shang bao weizhi xinxi chenggong ------------shang bao weizhi xinxi chenggong ------------ ")
                                break
                            case .failure(let failure):
                                print("shang bao weizhi xinxi chu cuo ------------ ")
                                break
                            }
                        }
                    }
                }
            } else if let error = error {
               print("shang bao weizhi xinxi chu cuo ")
            }
        }
    }
    
}




class LocationPermissionManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let userDefaultsKey = "HasShownLocationPromptToday"
    private var presentingViewController: UIViewController?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    /// 检查定位权限，并决定是否弹窗
    func checkLocationPermission(from viewController: UIViewController) {
        presentingViewController = viewController
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .notDetermined:
            // 尚未请求过定位权限
            if !hasShownPermissionPromptToday() {
                requestLocationPermission()
            }
        case .denied, .restricted:
            // 定位权限被拒绝或受限，显示提示弹窗
            if !hasShownPermissionPromptToday() {
                showCustomAlert()
            }
        case .authorizedWhenInUse, .authorizedAlways:
            print("定位权限已授权")
        @unknown default:
            break
        }
    }
    
    /// 请求定位权限
    private func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
        recordPermissionPromptShown()
    }
    
    /// 显示自定义弹窗，引导用户到设置页面
    private func showCustomAlert() {
        guard let presentingViewController = presentingViewController else { return }
        GuideAlert.show(presentingViewController, alertType: AlertType(0))
        recordPermissionPromptShown()
    }
    
    /// 判断当天是否已弹出权限请求
    private func hasShownPermissionPromptToday() -> Bool {
        let lastShownDate = UserDefaults.standard.object(forKey: userDefaultsKey) as? Date
        let today = Calendar.current.startOfDay(for: Date())
        
        if let lastShownDate = lastShownDate {
            return Calendar.current.isDate(lastShownDate, inSameDayAs: today)
        }
        return false
    }
    
    /// 记录当天已弹出权限请求
    private func recordPermissionPromptShown() {
        let today = Calendar.current.startOfDay(for: Date())
        UserDefaults.standard.set(today, forKey: userDefaultsKey)
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("定位权限已授权")
        case .denied, .restricted:
            print("定位权限被拒绝或受限")
        case .notDetermined:
            print("用户尚未做出选择")
        @unknown default:
            break
        }
    }
}




import WebKit
import SnapKit


class YT2WebViewController: YTBaseViewController, WKNavigationDelegate, WKUIDelegate ,YTNavigationDelegate,WKScriptMessageHandler{
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
    func bca() {
        
    }
    

    func backAction() {
        
    }
    

    var webView: WKWebView!
    
    var url: String?
    
    var pid: String?
    
    let bottomView = UIView()
    
    let buttonname = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 24,weight: .semibold))
    
    let buttonicon = UIImageView.init(image: UIImage.init(named: "Frame1d3"))

    init(url: String? = nil) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        
  
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        config.userContentController = userContentController
      
        userContentController.add(self, name: "chosen")
        userContentController.add(self, name: "leaped")
        userContentController.add(self, name: "dropped")
        userContentController.add(self, name: "dog")
        userContentController.add(self, name: "seconds")
        
        
        bottomView.isUserInteractionEnabled = true
        let tt = UITapGestureRecognizer.init(target: self, action: #selector(addd))
        bottomView.addGestureRecognizer(tt)
        bottomView.backgroundColor = .init(hex: "#F9962F")
        bottomView.cornersSet(by: .allCorners, radius: 16)
        view.add(bottomView) { v in
            bottomView.isHidden = true
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(28)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -20 : -39)
                make.height.equalTo(50)
            }
            
            let box = UIView()
            bottomView.add(box) { v in
                v.snp.makeConstraints { make in
                    make.center.equalToSuperview()
                }
            }
            
            box.add(buttonname) { v in
                v.snp.makeConstraints { make in
                    make.left.bottom.top.equalToSuperview()
                }
            }
            
            box.add(buttonicon) { v in
                v.snp.makeConstraints { make in
                    make.right.equalToSuperview()
                    make.centerY.equalToSuperview()
                    make.left.equalTo(buttonname.snp.right).offset(10)
                }
            }
        }
        
        
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.configuration.userContentController = userContentController
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top).offset(-18)
            make.top.equalTo(statusBarHeight+44)
        }

        
        
        guard let _url = url, let target = URL(string: _url) else {
            return
        }
        let request = URLRequest(url: target)
        webView.load(request)
        
        self.bottomView.isHidden = false
        
    }
    
    var han: (()->())?

    @objc func addd(){
        navigationController?.popViewController(animated: false)
        han?()
    }
    
    
    func close(){
        navigationController?.popViewController(animated: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavigationBarHidden(false, animated: false)
        if let n = navigationController as? YTBaseNavigationController {
            n.vcDelegate = self
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let n = navigationController as? YTBaseNavigationController {
            n.vcDelegate = nil
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.setNavigationBarTitle(webView.title ?? "")
        DispatchQueue.main.asyncAfter(deadline: .now()+2){[weak self] in
            self?.setNavigationBarTitle(webView.title ?? "")
           
        }
    }

    
}



