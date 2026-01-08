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
    var chanpinId: String?
    private var isHandlingClick = false
    private var isHandlingSelection = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarHidden(true, animated: true)
        setBarBgHidden()
        setbgImgViewHidden()
        
        tableView.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(loginOK), name: Notification.Name(rawValue: "loginOK"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: Notification.Name(rawValue: "logout"), object: nil)
        
        tableView.backgroundColor = UIColor.init(hex: "#2864D7")
        
        let bottom = YTTools.isIPhone6Series() ? 55 : (self.tabBarController?.tabBar.bounds.height ?? 49)
        view.add(tableView) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 0, left: 0, bottom: bottom, right: 0))
            }
        }
        
        tableView.register(YTShouyeT1TableViewCell.self, forCellReuseIdentifier: YTShouyeT1TableViewCell.identifier)
        tableView.register(YTShouyeT2TableViewCell.self, forCellReuseIdentifier: YTShouyeT2TableViewCell.identifier)
        tableView.register(YTShouyeT3TableViewCell.self, forCellReuseIdentifier: YTShouyeT3TableViewCell.identifier)
        tableView.register(YTShouyeT4TableViewCell.self, forCellReuseIdentifier: YTShouyeT4TableViewCell.identifier)
        tableView.register(YTShouyeListItemTableViewCell.self, forCellReuseIdentifier: YTShouyeListItemTableViewCell.identifier)
        tableView.register(YTShouyeListItemFirstTableViewCell.self, forCellReuseIdentifier: YTShouyeListItemFirstTableViewCell.identifier)
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
                
                self?.model = success?.upper
                
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
                
                break
            case .failure(let failure):
                self?.refreshing = false
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if YTTools.isIpad() && !NetworkStatusMonitor.shared.isConnected {
            SVProgressHUD.showInfo(withStatus: LocalizationManager.shared().localizedString(forKey: "neiw_tswp"))
        }
        
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
            if let _add = model?.addressed?.downward, _add.count > 0 {
                return 4
            } else {
                return 3
            }
        }
        
        return 1+(item.first?.marched ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeT1TableViewCell.identifier, for: indexPath) as? YTShouyeT1TableViewCell else {
                return UITableViewCell()
            }
            
            var item: marchedModel?
            if let smalCardModel = model?.along?.filter({$0.directly == "dexterous"}).first?.marched?.first {
                item = smalCardModel
                chanpinId = item?.wide
            }
            
            if let bigCardModel = model?.along?.filter({$0.directly == "suabian"}).first?.marched?.first {
                item = bigCardModel
                chanpinId = item?.wide
            }
            
            cell.name.isHidden = false
            
            cell.subName.isHidden = false
            
            cell.price.isHidden = false
            
            cell.icon.isHidden = false
            
            cell.lyBox.isHidden = false
            
            cell.l1t.isHidden = false
            cell.l1tv.isHidden = false
            
            cell.l2t.isHidden = false
            cell.l2tv.isHidden = false
            
            cell.icon.sd_setImage(with: URL.init(string: item?.neck ?? ""))
            
            cell.name.text = item?.bare
            
            cell.price.text = item?.smoky
            cell.subName.text = item?.dim
            cell.buttonicon.isHidden = false
            cell.buttonicon.setTitle(title: item?.coat ?? "")
            cell.l1t.text = item?.drunk
            cell.l1tv.text = item?.stalking
            
            cell.l2tv.text = item?.lead
            cell.l2t.text = item?.sheet
                        
            return cell
        }
        else {
            // 小卡位
            if model?.along?.filter({$0.directly == "dexterous"}).first  != nil {
                var cell: YTShouyeListItemTableViewCell?
                
                if indexPath.row == 1 {
                    if let _skwk_cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeListItemFirstTableViewCell.identifier, for: indexPath) as? YTShouyeListItemFirstTableViewCell {
                        cell = _skwk_cell
                    }
                } else {
                    if let _skwk_cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeListItemTableViewCell.identifier, for: indexPath) as? YTShouyeListItemTableViewCell {
                        cell = _skwk_cell
                    }
                }
                    
                if let item = model?.along?.filter({$0.directly == "eyelid"}).first?.marched?[indexPath.row-1] {
                    cell?.topimage.sd_setImage(with: URL.init(string: item.neck ?? ""))
                    cell?.topname.text = item.bare
                    cell?.money.text = item.smoky
                    cell?.centerrightButton.setTitle(item.coat ?? "")
                    
                    cell?.l1t.text = item.drunk!
                    
                    cell?.l3t.text = item.sheet!
                    
                    cell?.l1tv.text = item.stalking
                    
                    cell?.l3tv.text = item.lead
                }
                
                return cell ?? UITableViewCell()
            } else {
               if indexPath.row == 1 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: YTShouyeT2TableViewCell.identifier, for: indexPath) as? YTShouyeT2TableViewCell else {
                        return UITableViewCell()
                    }
                    
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
                    cell.tip2.text = model?.addressed?.downward
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    
    @objc func kaweidianji() {

        // 防止重复点击
        guard !isHandlingClick else {
            return
        }
        isHandlingClick = true

        if YTUserDefaults.shared.transport.count == 0 {
            let loginVC = YTBaseNavigationController(rootViewController: YTLoginViewController())
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: true) { [weak self] in
                self?.isHandlingClick = false
                self?.isHandlingSelection = false
            }
            return
        }

        guard let id = chanpinId else {
            isHandlingClick = false
            isHandlingSelection = false
            return
        }

        viewModel.gash(avp: ["erect" : id]) { [weak self] re in
            guard let self = self else { return }

            // ⚠️ 无论成功失败，最终都要解锁
            defer {
                self.isHandlingClick = false
                self.isHandlingSelection = false
            }

            switch re {
            case .success(let success):

                guard let url = success?.upper?.stride else { return }

                if url.hasPrefix("http") || url.hasPrefix("https") {
                    if let completeURL = YTPublicRequestURLTool
                        .createURLWithParameters(component: url)?
                        .absoluteString {

                        let webView = YTWebViewController(url: completeURL)
                        self.navigationController?.pushViewController(webView, animated: true)
                    }
                } else if url.hasPrefix("yu://"),
                          url.contains("yu://una.kno.s/arrogant") {

                    let pro = YTProductViewController()
                    pro.mID = id
                    self.navigationController?.pushViewController(pro, animated: true)
                }

            case .failure:
                break
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
            if let url = model?.courageous?.aboutUrl {
                if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                    let webView = YTWebViewController.init(url: completeURL)
                    navigationController?.pushViewController(webView, animated: true)
                }
            }
        } else {
            if let url = model?.addressed?.words {
                if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                    let webView = YTWebViewController.init(url: completeURL)
                    navigationController?.pushViewController(webView, animated: true)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 立刻取消选中态（视觉 + 逻辑都重要）
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            // 防止重复点击
            guard !isHandlingSelection else { return }
            isHandlingSelection = true
            kaweidianji()
        } else {
            
            // 大卡位点击
            if model?.along?.filter({$0.directly == "suabian"}).first  != nil {
                if indexPath.row == 2 {
                    // 常见问题
                    self.navigationController?.pushViewController(QuestonViewController(), animated: true)
                }
                
                if indexPath.row == 3 {
                    // 协议
                    z1()
                }
            }
            
            // 小卡位点击
            if model?.along?.filter({$0.directly == "dexterous"}).first  != nil {
                if let id = model?.along?.filter({$0.directly == "eyelid"}).first?.marched?[indexPath.row-1].wide {
                    chanpinId = id
                }
                
                // 防止重复点击
                guard !isHandlingSelection else { return }
                isHandlingSelection = true
                kaweidianji()
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
        GuideAlert.show(presentingViewController, alertType: AlertType_Location)
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



class NetworkStatusMonitor {
    static let shared = NetworkStatusMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    var isConnected: Bool = false
    var isCellular: Bool = false

    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            self.isCellular = path.usesInterfaceType(.cellular)
        }
        monitor.start(queue: queue)
    }
}
