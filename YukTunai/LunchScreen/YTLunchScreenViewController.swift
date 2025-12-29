

import UIKit
import SnapKit
import FBSDKCoreKit
import Network



class ApiViewModel: NSObject {
    
    let service = InitApiServices()
    
    func renowning(avp: [String : String], completion: @escaping (Result<CKBaseNetModel<zhongjianModel>?, YKError>) -> Void) {
        service.renowning(avp: avp) { r in
            completion(r)
        }
    }
    
    func uproar(avp: [String : String], completion: @escaping (Result<CKBaseNetModel<uproarModel>?, YKError>) -> Void) {
        service.uproar(avp: avp) { r in
            completion(r)
        }
    }
    
    
    func impertinent(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<impertinentModel>?, YKError>) -> Void) {
        service.impertinent(avp: avp) { r in
            completion(r)
        }
    }
    
    func absurd(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        service.absurd(avp: avp) { r in
            completion(r)
        }
    }
    
    
    func arrogant(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<homesModel>?, YKError>) -> Void) {
        service.arrogant(avp: avp) { r in
            completion(r)
        }
    }
    
    func offensive(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        service.offensive(avp: avp) { r in
            completion(r)
        }
    }
    
    func junge(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<homesModel>?, YKError>) -> Void) {
        service.junge(avp: avp) { r in
            completion(r)
        }
    }
    
    func homes(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<homesModel>?, YKError>) -> Void) {
        service.homes(avp: avp) { r in
            completion(r)
        }
    }
    
    func went(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        service.went(avp: avp) { r in
            completion(r)
        }
    }
    
    func dummer(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        service.dummer(avp: avp) { r in
            completion(r)
        }
    }
    
    func duels(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        service.duels(avp: avp) { r in
            completion(r)
        }
    }
    
    
    
    func hands(avp: [String:Any],completion: @escaping(Result<CKBaseNetModel<FACEhandsModel>?, YKError>) -> Void) {
        service.hands(avp: avp) { r in
            completion(r)
        }
    }
    
    func fought(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<marchedFaceModel>?, YKError>) -> Void) {
        service.fought(avp:avp) { r in
            completion(r)
        }
    }
    
    func days(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<daysModel>?, YKError>) -> Void) {
        service.days(avp:avp) { r in
            completion(r)
        }
    }
    
    func gash(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<HomegashmODEL>?, YKError>) -> Void) {
        service.gash(avp:avp) { r in
            completion(r)
        }
    }
    
    func home(completion: @escaping(Result<CKBaseNetModel<homeModel>?, YKError>) -> Void) {
        service.home { r in
            completion(r)
        }
    }
    
    func schlaeger(h: String,avp: [String:String],completion: @escaping(Result<CKBaseNetModel<schlaegerModel>?, YKError>) -> Void) {
        service.schlaeger(h: h, avp: avp) { r in
            completion(r)
        }
    }
    
    func suabian(avp: String,completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        service.suabian(avp: avp) { r in
            completion(r)
        }
    }
    
    func bottles(completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        service.bottles() { r in
            completion(r)
        }
    }
    
    func dexterous(avp: String,completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        service.dexterous(avp: avp) { r in
            completion(r)
        }
    }
    
    func lip(completion: @escaping(Result<CKBaseNetModel<EmptyModel>?, YKError>) -> Void) {
        service.lip { r in
            completion(r)
        }
    }
    
    
    func eyelid(avp: [String:String],completion: @escaping(Result<CKBaseNetModel<eyelidModel>?, YKError>) -> Void) {
        service.eyelid(avp: avp) { r in
            completion(r)
        }
    }
    
    
    
    func info(completion: @escaping (Result<CKBaseNetModel<infoModel>?, YKError>) -> Void) {
        service.info() { r in
            completion(r)
        }
    }
    
}





class YTLunchScreenViewController: UIViewController {
    
    let viewModel = ApiViewModel()

    var button: UIButton = UIButton.init(title: "Try again", font: .systemFont(ofSize: 18), color: .white)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hex: "#EDF0FE")
        
       
        
        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self?.startApp()
                } else {
                    self?.button.isHidden = false
                }
            }
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)

        

        
        let image = UIImageView.init(image: UIImage.init(named: "image 26"))
        view.add(image) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(128)
                make.top.equalToSuperview().offset(216)
                make.centerX.equalToSuperview()
            }
        }
        
    
        button.isHidden = true
        button.setBgColor(color: .init(hex: "#6D90F5"))
        button.cornersSet(by: .allCorners, radius: 52/2)
        button.addTarget(self, action: #selector(agin), for: .touchUpInside)
        view.add(button) { v in
            v.snp.makeConstraints { make in
                make.height.equalTo(52)
                make.width.equalTo(272)
                make.centerX.equalToSuperview()
                make.top.equalTo(image.snp.bottom).offset(171)
            }
        }
        
    }
    

    deinit {
        print("fewfewfew")
    }
    
    @objc func agin(){
        button.isHidden = true
        SVProgressHUD.show()
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        startApp(need: true)
    }
    
    func initApi(){
      
                 button.isHidden = true
                        let firstScreen = YTFirstScreenViewController()
                                if !YTUserDefaults.shared.firstStart {
                                    SVProgressHUD.dismiss()
                                    firstScreen.handle = {
                                       
                                        YTUserDefaults.shared.firstStart = true
                                        let tabViewC = YTBaseTabBarViewController.init()
        
                                        let home =  YTZhongJianViewController()
                                        home.tabBarItem.image = UIImage.init(named: "Property 1=order-off")!.withRenderingMode(.alwaysOriginal)
                                        home.tabBarItem.selectedImage = UIImage.init(named: "Property 1=order-on")!.withRenderingMode(.alwaysOriginal)
                                        let homeVc = YTBaseNavigationController.init(rootViewController: home)
                                        tabViewC.addChild(homeVc)
        
                                        let order =  YTShouyeViewController()
                                        let orderVc = YTBaseNavigationController.init(rootViewController: order)
                                        order.tabBarItem.image = UIImage.init(named: "home1232dd")!.withRenderingMode(.alwaysOriginal)
                                        order.tabBarItem.selectedImage = UIImage.init(named: "home")!.withRenderingMode(.alwaysOriginal)
                                        tabViewC.addChild(orderVc)
        
                                        let center =  YKWoViewController()
                                        center.tabBarItem.image = UIImage.init(named: "Property 1=me-off")!.withRenderingMode(.alwaysOriginal)
                                        center.tabBarItem.selectedImage = UIImage.init(named: "Property 1=me-on")!.withRenderingMode(.alwaysOriginal)
                                        let centerVc = YTBaseNavigationController.init(rootViewController: center)
                                        tabViewC.addChild(centerVc)
        
        
        
                                        UIApplication.shared.windows.first?.rootViewController  = tabViewC
        
                                        tabViewC.selectedIndex = 1
                                    }
                                    UIApplication.shared.windows.first?.rootViewController = firstScreen
                                } else {
                                    SVProgressHUD.dismiss()
                                    let tabViewC = YTBaseTabBarViewController.init()
        
                                    let home =  YTZhongJianViewController()
                                    home.tabBarItem.image = UIImage.init(named: "Property 1=order-off")!.withRenderingMode(.alwaysOriginal)
                                    home.tabBarItem.selectedImage = UIImage.init(named: "Property 1=order-on")!.withRenderingMode(.alwaysOriginal)
                                    let homeVc = YTBaseNavigationController.init(rootViewController: home)
                                    tabViewC.addChild(homeVc)
        
                                    let order =  YTShouyeViewController()
                                    let orderVc = YTBaseNavigationController.init(rootViewController: order)
                                    order.tabBarItem.image = UIImage.init(named: "home1232dd")!.withRenderingMode(.alwaysOriginal)
                                    order.tabBarItem.selectedImage = UIImage.init(named: "home")!.withRenderingMode(.alwaysOriginal)
                                    tabViewC.addChild(orderVc)
        
                                    let center =  YKWoViewController()
                                    center.tabBarItem.image = UIImage.init(named: "Property 1=me-off")!.withRenderingMode(.alwaysOriginal)
                                    center.tabBarItem.selectedImage = UIImage.init(named: "Property 1=me-on")!.withRenderingMode(.alwaysOriginal)
                                    let centerVc = YTBaseNavigationController.init(rootViewController: center)
                                    tabViewC.addChild(centerVc)
                                    UIApplication.shared.windows.first?.rootViewController  = tabViewC
        
                                    tabViewC.selectedIndex = 1
                                }
                    }
                


    
   
    func startApp(need: Bool = false){
        if need {
            SVProgressHUD.show()
        }
         
        viewModel.schlaeger(h:HOST,avp: [
            "schlaeger":"\(DeviceInformationModel.getCurrentLanguage())",
            "suabian":"\(DeviceInformationModel.isProxyEnabled() ? 1:0)",
            "dexterous":"\(DeviceInformationModel.isVPNConnected() ? 1:0)"]) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                
                guard let m = model?.upper else {
                    SVProgressHUD.dismiss()
                    return
                }
                
                YTUserDefaults.shared.gash = "\(m.gash!)"

                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    let launchOptions = appDelegate.applaunchOptions
                    Settings.shared.appID = m.fought?.duels ?? ""
                    Settings.shared.clientToken = m.fought?.went ?? ""
                    Settings.shared.displayName = m.fought?.homes ?? ""
                    Settings.shared.appURLSchemeSuffix = m.fought?.hands ?? ""
                    ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: launchOptions)
                }

                self.button.isHidden = true

               // if YTUserDefaults.shared.gash == 2 {
                    YTAddressTools.shared.load()
                //}r
                
                self.initApi()
                
                SVProgressHUD.dismiss()
                
            case .failure(let e):
                
                self.viewModel.service.defaultjsons(lj: HOMEJSON) {[weak self] result in
                    switch result {
                    case .success(let success):
                        guard let m = success?.upper else {
                            return
                        }
                        self?.tryDomains(domains: m, completion: {[weak self] l in
                            self?.button.isHidden = true
                        })
                        break
                    case .failure(let failure):
                        self?.button.isHidden = false
                        SVProgressHUD.setDefaultStyle(.dark)
                        SVProgressHUD.setDefaultMaskType(.clear)
                        SVProgressHUD.dismiss(withDelay: 1.5)
                       
                        break
                    }
                }
              
                break
            }
        }
    }
    
    
    func tryDomains(domains: [homeURLList], completion: @escaping (String?) -> Void) {
        var remainingDomains = domains
        
        func attemptNext() {
            guard let domain = remainingDomains.first?.yu else {
                // 所有域名都尝试失败
                button.isHidden = false
                completion(nil)
                return
            }
            
            remainingDomains.removeFirst() // 移除已经尝试的域名
            
            if domain == HOST {
                attemptNext()
                return
            }
           
            requestDefaultDomain(defaultDomain: domain) { r in
                if r {
                    HOST = domain
                } else {
                    attemptNext()
                }
            }
            
        }
        
        attemptNext() // 开始尝试第一个域名
    }
   
    
    
    func requestDefaultDomain(defaultDomain: String, completion: @escaping (Bool) -> Void) {
       
        viewModel.schlaeger(h:defaultDomain,avp: [
            "schlaeger":"\(DeviceInformationModel.getCurrentLanguage())",
            "suabian":"\(DeviceInformationModel.isProxyEnabled() ? 1:0)",
            "dexterous":"\(DeviceInformationModel.isVPNConnected() ? 1:0)"]) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let model):
                
                guard let m = model?.upper else {
                    SVProgressHUD.dismiss()
                    return
                }
                
                YTUserDefaults.shared.gash = "\(m.gash!)"

                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    let launchOptions = appDelegate.applaunchOptions
                    Settings.shared.appID = m.fought?.duels ?? ""
                    Settings.shared.clientToken = m.fought?.went ?? ""
                    Settings.shared.displayName = m.fought?.homes ?? ""
                    Settings.shared.appURLSchemeSuffix = m.fought?.hands ?? ""
                    ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: launchOptions)
                }

                self.button.isHidden = true

               // if YTUserDefaults.shared.gash == 2 {
                    YTAddressTools.shared.load()
                //}r
                
                self.initApi()
                
                self.button.isHidden = true
                
                completion(true)
            case .failure(let e):
                
               
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.dismiss(withDelay: 1.5)
                
                completion(false)
                break
            }
        }
    }
}
