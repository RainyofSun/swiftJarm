//
//  YTZhongJianViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit
import MJRefresh
import SmartCodable

class YTZhongJianViewController: YTBaseViewController, UITableViewDelegate,UITableViewDataSource {
    
    let viewModel = ApiViewModel()
    var indesww: Int?

    var tableView: UITableView = {
        let view = UITableView(frame: CGRectZero, style: UITableView.Style.plain)
        view.backgroundColor = UIColor(hex: "#62B0FE")
        view.separatorStyle = .none
        return view
    }()
    
    var model:zhongjianModel? {
        didSet {
            tableView.reloadData()
            if (model?.along ?? []).count == 0 {
                tableView.empty.show(emptyImage: UIImage.init(named: "order_empty")!,
                                     emptyTitle: YTTools.areaTitle(a: "There are currently noorders available.", b: "Saat ini tidak ada pesanan yang tersedia.") ,
                                     buttonTitle: YTTools.areaTitle(a: "Apply loan", b: "Ajukan Sekarang"),
                                     offsetY: -40,
                                     canBunces: true) {[weak self] in
                    self?.tableView.mj_header?.beginRefreshing {[weak self] in
                        self?.requst()
                    }
                }
            } else {
                tableView.empty.hidden()
            }
        }
    }
    
    var pid: String? {
        didSet {
            tableView.mj_header?.beginRefreshing()
        }
    }
    
    let menu = MenuControl(frame: CGRectZero)
    
    func loadd(with i: String){
        viewModel.renowning(avp: ["reads":i]) {[weak self] r in
            switch r {
            case .success(let m):
                
                guard let d = m?.upper else {
                    self?.tableView.mj_header?.endRefreshing()
                    return
                }
                self?.model = d
                self?.tableView.mj_header?.endRefreshing()
                break
            case .failure(let e):
                self?.tableView.mj_header?.endRefreshing()
                    self?.model = nil
                    SVProgressHUD.showError(withStatus: e.description)
                break
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setNavigationBarTitle(YTTools.areaTitle(a: "Order", b: "Memesan"))
        //if YTUserDefaults.shared.gash == 2 {
        YTAddressTools.shared.load()
        //}
        
        self.view.backgroundColor = UIColor(hex: "#2864D7")
        
        menu.titles = [LocalizationManager.shared().localizedString(forKey: "order_all"),
                       LocalizationManager.shared().localizedString(forKey: "order_apply"),
                       LocalizationManager.shared().localizedString(forKey: "order_repay"),
                       LocalizationManager.shared().localizedString(forKey: "order_finis"),]

        menu.onSelectIndex = {[weak self] index in
            switch index {
            case 0:
                self?.pid = "4"
            case 1:
                self?.pid = "7"
            case 2:
                self?.pid = "6"
            case 3:
                self?.pid = "5"
            default:
                self?.pid = "4"
            }
            
            self?.tableView.mj_header?.beginRefreshing {[weak self] in
                self?.requst()
            }
        }

        view.add(menu) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.top.equalToSuperview().offset(navigationBarHeight + safeAreaTop + 10)
                make.height.equalTo(45)
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(YTZhongJianCellView.self, forCellReuseIdentifier: YTZhongJianCellView.identifier)
        
        view.add(tableView) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.top.equalTo(menu.snp.bottom)
                make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -55 : -90)
            }
        }
        self.addRefresh()
        
        self.setbgImgViewHidden()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _index = self.indesww {
            self.menu.setSelectedIndex(_index,)
        } else {
            self.menu.setSelectedIndex(0)
        }
    }
    
    func addRefresh(){
        let HeaderRefresh = MJRefreshNormalHeader.init()
        HeaderRefresh.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        HeaderRefresh.setTitle("", for: .idle)
        HeaderRefresh.setTitle(YTTools.areaTitle(a: "Release to load more data", b: "Lepaskan untuk memuat lebih banyak data"), for: .pulling)
        HeaderRefresh.setTitle(YTTools.areaTitle(a:"Loading data",b:"Memuat data"), for: .refreshing)
        HeaderRefresh.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header = HeaderRefresh
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (model?.along ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: YTZhongJianCellView.identifier, for: indexPath) as? YTZhongJianCellView else {
            return UITableViewCell()
        }
        
        if let m = model?.along?[indexPath.row] {
            
            cell.topimage.sd_setImage(with: URL.init(string: m.neck ?? ""))
            cell.topname.text = m.bare
            cell.money.text = m.bringeth
            cell.m = m.followed
            cell.statckLab.text = m.coat
            
            if (m.joined ?? "").count == 0 {
                cell.toprightButton.isHidden = true
            } else {
                cell.toprightButton.setAttributedTitle(NSAttributedString(string: m.joined ?? "", attributes: [.foregroundColor: UIColor(hex: "#2864D7"), .font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium), .underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: UIColor(hex: "#2864D7")]), for: UIControl.State.normal)
                cell.tag = indexPath.row
                cell.toprightButton.addTarget(self, action: #selector(aa(with:)), for: .touchUpInside)
            }
            
        }
        
        return cell
    }
    
    func requst(){
        guard let ids = pid else {
            return
        }
        loadd(with: ids)
    }
    
    @objc func aa(with buton: UIButton){
        if let m = model?.along?[buton.tag],let u = m.chorus  {
            if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: u)?.absoluteString {
                let webView = YTWebViewController.init(url: completeURL)
                navigationController?.pushViewController(webView, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let m = model?.along?[indexPath.row],let url = m.brings  {
            
            if url.hasPrefix("http") || url.hasPrefix("https") {
                if let completeURL = YTPublicRequestURLTool.createURLWithParameters(component: url)?.absoluteString {
                    let webView = YTWebViewController.init(url: completeURL)
                    navigationController?.pushViewController(webView, animated: true)
                }
            } else if  url.hasPrefix("yu://") {
                if url.contains("yu://una.kno.s/dummer") {
                    self.navigationController?.popToRootViewController(animated: false)
                    let tabBar = UIApplication.shared.windows.first?.rootViewController as? UITabBarController
                    tabBar?.selectedIndex = 1
                } else if url.contains("yu://una.kno.s/arrogant?erect") {
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
}

class YTZhongJianCellView: UITableViewCell {
    
    var m: [zhongjianListMdModel]? {
        didSet {
            guard let list = m else {
                return
            }
            
            box3.subviews.forEach({$0.removeFromSuperview()})
            
            var of: UIView?
            
            list.enumerated().forEach { item in
                let box = UIView()
                
                let l1t = UILabel.init(title: item.element.downward,textColor: .init(hex: "#2864D7"),font: .systemFont(ofSize: 16))
                let l1tv = UILabel.init(title: item.element.lustily,textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 16))
                
                box3.add(box) { v in
                    v.snp.makeConstraints { make in
                        make.left.right.equalToSuperview()
                        make.height.equalTo(30)
                        if item.offset == 0 {
                            make.top.equalToSuperview()
                        } else {
                            make.top.equalTo(of!.snp.bottom)
                            if item.offset == list.count - 1 {
                                make.bottom.equalToSuperview()
                            }
                        }
                    }
                }
                
                of = box
                
                box.addSubview(l1t)
                box.addSubview(l1tv)
                
                l1t.snp.makeConstraints { make in
                    make.left.centerY.equalToSuperview()
                }
                
                l1tv.snp.makeConstraints { make in
                    make.left.equalTo(l1t.snp.right).offset(8)
                    make.centerY.equalToSuperview()
                }
            }
            
        }
    }
    
    
    let topimage = UIImageView()
    
    let topname = UILabel.init(title: "",textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 16, weight: .bold))
    
    // url
    let toprightButton = UIButton.init(title: "",font: .systemFont(ofSize: 13), color: .init(hex: "#2864D7"))
    
    let money = UILabel.init(title: "",textColor: .init(hex: "#333333"),font: .systemFont(ofSize: 26,weight: .bold))
    
    let centerrightButton = UIButton.init(title: YTTools.areaTitle(a: "Check", b: "Lihat"),font: .systemFont(ofSize: 18), color: .white)
    let statckLab = UILabel(title: "", textColor: UIColor.black, font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium))
    
    let box3 = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        
        selectionStyle = .none
        
        centerrightButton.isUserInteractionEnabled = false
        
        let box = UIView()
        box.backgroundColor = UIColor(hex: "#EAF5FF")
        box.cornersSet(by: .allCorners, radius: 8)
        contentView.add(box) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 5, left: 15, bottom: 5, right: 15))
            }
        }
        
        let rightView = UIView()
        rightView.backgroundColor = UIColor(hex: "#FFAC30")
        rightView.cornersSet(by: [.topRight, .bottomLeft], radius: 8)
        
        box.add(rightView) { v in
            v.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(2)
                make.right.equalToSuperview().offset(-2)
            }
        }
        
        rightView.add(statckLab) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(7)
            }
        }
        
        box.add(topimage) { v in
            topimage.cornersSet(by: .allCorners, radius: 4)
            v.snp.makeConstraints { make in
                make.left.top.equalToSuperview().offset(15)
                make.width.height.equalTo(21)
            }
        }
        
        box.add(topname) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(topimage.snp.right).offset(6)
                make.centerY.equalTo(topimage)
                make.width.equalToSuperview().multipliedBy(0.6)
            }
        }
        
        box.add(money) { v in
            v.snp.makeConstraints { make in
                make.top.equalTo(topimage.snp.bottom).offset(12)
                make.left.equalTo(topimage)
            }
        }
        
        box.add(box3) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalTo(money.snp.bottom).offset(12)
            }
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(hex: "#0D952F", alpha: 0.2)
        
        box.add(lineView) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalTo(box3.snp.bottom).offset(12)
                make.height.equalTo(1)
            }
        }
        
        box.add(centerrightButton) { v in
            v.cornersSet(by: .allCorners, radius: 8)
            v.backgroundColor = .init(hex: "#2864D7")
            v.snp.makeConstraints { make in
                make.width.equalTo(86)
                make.height.equalTo(36)
                make.top.equalTo(lineView.snp.bottom).offset(18)
                make.right.equalToSuperview().offset(-12)
                make.bottom.equalToSuperview().offset(-18)
            }
        }
        
        box.add(toprightButton) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(topimage)
                make.centerY.equalTo(centerrightButton)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class zhongjianModel: SmartCodable {

    var along: [zhongjianListModel]?
  
    
   
    
    required init(){}
}



class zhongjianListModel: SmartCodable {
    
    
    var followed: [zhongjianListMdModel]?
    
    var joined: String?
    var chorus: String?
    var brings: String?
    
    var bare: String?
    var neck: String?
    var coat: String?
    var bringeth: String?
    
    required init(){}
}


class zhongjianListMdModel: SmartCodable {
    
    var downward:String?
    var lustily:String?
    
    required init(){}
}
