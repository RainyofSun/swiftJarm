//
//  YKWoViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit
import SDWebImage

class YKWoViewController: YTBaseViewController {
    
    let viewModel = ApiViewModel()
    
    let scrollView = YTScrollView()
    
    let contentView = UIView()
    
    let t2 = UILabel.init(title: "",textColor: .white,font: .systemFont(ofSize: 20,weight: .bold))
    
    let icon1 = UIImageView.init(image: UIImage.init(named: "Group 1749"))
    
    let t11 = UILabel.init(title: "",textColor: .black,font: .systemFont(ofSize: 16))
    
    let icon2 = UIImageView.init(image: UIImage.init(named: "Group 1750"))
    
    let t22 = UILabel.init(title: "",textColor: .black,font: .systemFont(ofSize: 16))
   
    let repayView = woItemView(frame: CGRectZero, woType: WotItemsType.Repayment)
    let applyView = woItemView(frame: CGRectZero, woType: WotItemsType.Apply)
    let finishView = woItemView(frame: CGRectZero, woType: WotItemsType.Finished)
    
    let box2 = UIView()
    
    var model: infoModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        repayView.addTarget(self, action: #selector(clikcTopTielsw(sender: )), for: UIControl.Event.touchUpInside)
        applyView.addTarget(self, action: #selector(clikcTopTielsw(sender: )), for: UIControl.Event.touchUpInside)
        finishView.addTarget(self, action: #selector(clikcTopTielsw(sender: )), for: UIControl.Event.touchUpInside)
        
        setNavigationBarHidden(true, animated: true)
        box2.backgroundColor = .clear
        
        view.add(scrollView) { v in
            v.alwaysBounceVertical = true
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        scrollView.add(contentView) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalToSuperview()
            }
        }
        
        let icon = UIImageView.init(image: UIImage.init(named: "avatar"))
        contentView.add(icon) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(statusBarHeight + 20)
                make.centerX.equalToSuperview()
            }
        }
        
        
        contentView.add(t2) { v in
            v.snp.makeConstraints { make in
                make.top.equalTo(icon.snp.bottom).offset(12)
                make.centerX.equalToSuperview()
            }
        }
        
        
        let t3 = UILabel.init(title: YTTools.areaTitle(a: "Welcome to our products", b: "Selamat datang di produk kami"),textColor: .init(hex: "#ffffff"),font: .systemFont(ofSize: 14))
        contentView.add(t3) { v in
            v.snp.makeConstraints { make in
                make.top.equalTo(t2.snp.bottom).offset(5)
                make.centerX.equalToSuperview()
            }
        }
        
        contentView.add(applyView) { v in
            v.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(15)
                make.top.equalTo(t3.snp.bottom).offset(20)
            }
        }
        
        contentView.add(repayView) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(applyView.snp.right).offset(10)
                make.width.top.equalTo(applyView)
            }
        }
        
        contentView.add(finishView) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(repayView.snp.right).offset(10)
                make.top.width.equalTo(repayView)
                make.right.equalToSuperview().offset(-15)
            }
        }
       
        contentView.add(box2) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.top.equalTo(applyView.snp.bottom).offset(14)
            }
        }
        
        let tip = UILabel(title: LocalizationManager.shared().localizedString(forKey: "mine_tip"), textColor: UIColor.black, font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium))
        let tipImg = UIImageView(image: UIImage(named: "tip"))
        
        contentView.add(tipImg) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalTo(box2.snp.bottom).offset(20)
                make.height.equalTo((UIScreen.main.bounds.width - 30) * 0.23)
                make.bottom.equalToSuperview().offset(-20)
            }
        }
        
        tipImg.add(tip) { v in
            v.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-11)
                make.width.equalToSuperview().multipliedBy(0.7)
                make.centerY.equalToSuperview()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginOK), name: Notification.Name(rawValue: "loginOK"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: Notification.Name(rawValue: "logout"), object: nil)
    }
    
    @objc func loginOK(){
        viewModel.info {[weak self] result in
            switch result {
            case .success(let success):
                
                self?.model = success?.upper
                self?.lists(withs: (success?.upper?.along)!)
                self?.t2.text = success?.upper?.inverted?.absurd
            case .failure(let failure):
                break
            }
        }
    }
    
    @objc func logout(){
        viewModel.info {[weak self] result in
            switch result {
            case .success(let success):
                
                self?.model = success?.upper
                self?.lists(withs: (success?.upper?.along)!)
                self?.t2.text = success?.upper?.inverted?.absurd
            case .failure(let failure):
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.info {[weak self] result in
            switch result {
            case .success(let success):
                
                self?.model = success?.upper
                self?.lists(withs: (success?.upper?.along)!)
                self?.t2.text = success?.upper?.inverted?.absurd
            case .failure(let failure):
                break
            }
        }
        
    }

    func lists(withs data: [alongModel]){
        
        box2.subviews.forEach { item in
            item.removeFromSuperview()
        }
        
        t11.text = data[0].downward ?? ""
        t22.text = data[1].downward ?? ""
        
        
        var pre: UIView?
        for i in 2..<data.count {
            let im = YTWoView.init(iconN: data[i].courageous ?? "", name: data[i].downward ?? "")
            im.tag = i
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(click(tap:)))
            im.addGestureRecognizer(tap)
            box2.add(im) { v in
                v.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.height.equalTo(56)
                    if i-2 == 0 {
                        make.top.equalToSuperview()
                    } else {
                        make.top.equalTo(pre!.snp.bottom).offset(8)
                        
                        if i == data.count - 1 {
                            make.bottom.equalToSuperview()
                        }
                    }
                }
            }
            pre = im
        }
    }
    
    @objc func clikcTopTielsw(sender: woItemView) {
        guard let _tabVC = UIApplication.shared.keyWindow?.rootViewController as? YTBaseTabBarViewController else {
            return
        }
        
        _tabVC.selectedIndex = 1
        
        guard let _nav = _tabVC.viewControllers?[1] as? YTBaseNavigationController, let _rotw = _nav.topViewController as? YTZhongJianViewController else {
            return
        }
        
        switch sender.type {
        case .Apply:
            _rotw.indesww = 1
        case .Repayment:
            _rotw.indesww = 2
        case .Finished:
            _rotw.indesww = 3
        }
    }

    
    @objc func click(tap: UITapGestureRecognizer){
        guard let v = tap.view else {
            return
        }
        guard let url = model?.along?[v.tag].stride else {
            return
        }
        if url.hasPrefix("http") || url.hasPrefix("https") {
            if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                let webView = YTWebViewController.init(url: completeURL)
                navigationController?.pushViewController(webView, animated: true)
            }
        } else if  url.hasPrefix("yu://") {
            if url.contains("yu://una.kno.s/junge") {
                let vc = YTSettingViewController()
                vc.model = model?.victorious
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}

class YTWoView: UIView {
    
    
    init(iconN: String,name: String) {
        super.init(frame: .zero)
        
        cornersSet(by: UIRectCorner.allCorners, radius: 8)
        backgroundColor = UIColor(hex: "#EAF5FF")
        
        let image = UIImageView()
        image.sd_setImage(with: URL.init(string: iconN))
        add(image) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(28)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(12)
            }
        }
        
        
        let t2 = UILabel.init(title: name,textColor: .init(hex: "#333333"),font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium))
        
        add(t2) { v in
            v.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(image.snp.right).offset(14)
            }
        }
        
        let image2 = UIImageView.init(image: UIImage.init(named: "black_arr"))
        add(image2) { v in
            v.snp.makeConstraints { make in
                make.width.height.equalTo(20)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-19)
            }
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}






import WebKit
import SnapKit
import StoreKit

class YTWebViewController: YTBaseViewController, WKNavigationDelegate, WKUIDelegate ,YTNavigationDelegate,WKScriptMessageHandler{
    
    func bca() {
        
    }
    

    func backAction() {
        
    }
    
    var isPro: Bool = false

    var webView: WKWebView!
    
    var url: String?
    
    let topView = UIView()
    
    let t = Date().timeIntervalSince1970
    
    init(url: String? = nil) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(topView)

 
        let config = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        config.userContentController = userContentController
      
        userContentController.add(self, name: "chosen")
        userContentController.add(self, name: "leaped")
        userContentController.add(self, name: "dropped")
        userContentController.add(self, name: "dog")
        userContentController.add(self, name: "seconds")
        
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.configuration.userContentController = userContentController
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(statusBarHeight+44)
        }

        
        
        guard let _url = url, let target = URL(string: _url) else {
            return
        }
        let request = URLRequest(url: target)
        webView.load(request)
        
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
                if message.name == "chosen" {
                    close()
                } else if message.name == "leaped" {
                    goToHome()
                } else if message.name == "dropped" {
                    openRevew()
                } else if message.name == "seconds" {
                    if let messageBody = message.body as? String {
                        targetAction(with: messageBody)
                    } else if let messageDatas = message.body as? [String] {
                        guard let item = messageDatas.first else {
                            return
                        }
                        targetAction(with: item)
                    }
                } else if message.name == "dog" {
                  storms()
                }
    }
    
    func targetAction(with item: String) {
        if let url = YTPublicRequestURLTool.createURLWithParameters(component: item)?.absoluteString {
            if url.hasPrefix("http") || url.hasPrefix("https") {
                if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                    let webView = YTWebViewController.init(url: completeURL)
                    navigationController?.pushViewController(webView, animated: true)
                }
            } else if  url.hasPrefix("yu://") {
                if url.contains("yu://una.kno.s/arrogant?erect") {
                    guard let parameters = extractParameters(from: url), let id = parameters["erect"] else {
                        return
                    }
                    let productVC = YTProductViewController()
                    productVC.mID = id
                    navigationController?.pushViewController(productVC, animated: true)
                }
            }
        }
    }
    
    func close(){
        navigationController?.popViewController(animated: true)
    }
    
    func openRevew(){
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func storms(){
        let data: [String: Any] = ["obliged": "9", "nasty": "\(Date().timeIntervalSince1970)","newcomers":"\(Date().timeIntervalSince1970)"]
        NotificationCenter.default.post(name: .myNotification, object: nil, userInfo: data)

    }
    
    func  goToHome(){
        navigationController?.popToRootViewController(animated: false)
        let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
        tabBar?.selectedIndex = 0
    }
    
    
    override func bTapped() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            guard let children = navigationController?.children else {
                return
            }
            if children.contains(where: {$0.isKind(of: YTProductViewController.self)}){
                if isPro {
                    self.navigationController?.popToRootViewController(animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
  
    
    func extractParameters(from urlString: String) -> [String: String]? {
        guard let url = URL(string: urlString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
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



extension YTWebViewController {
    
    func quantum(){
        navigationController?.popToRootViewController(animated: false)
        let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
        tabBar?.selectedIndex = 0
    }
    
    func achieve(){
        navigationController?.popViewController(animated: true)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
  
        let url  : String = navigationAction.request.url?.absoluteString ?? ""
        let urlString = URL(string: url)

        if url.contains("mobikwik://") ||
            url.contains("phonepe://") ||
            url.contains("paytm://") ||
            url.contains("paytmmp://") ||
            url.contains("gpay://") ||
            url.contains("upi://") {
            
            decisionHandler(.cancel)
            UIApplication.shared.open(urlString!, options: [:]) { (success) in }
            
        } else {
            decisionHandler(.allow)
        }
    }
    
}
