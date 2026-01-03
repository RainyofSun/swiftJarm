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
        view.backgroundColor = .clear
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
            
            
            if (m.joined ?? "").count == 0 {
                cell.toprightButton.isHidden = true
            } else {
                cell.toprightButton.setTitle(title: (m.joined ?? ""))
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
                
                let l1t = UILabel.init(title: item.element.downward,textColor: .init(hex: "#9B9B9B"),font: .systemFont(ofSize: 12))
                let l1tv = UILabel.init(title: item.element.lustily,textColor: .init(hex: "#212121"),font: .systemFont(ofSize: 13))
               
                l1t.textAlignment = .center
                l1tv.textAlignment = .center
                
                box3.addSubview(box)
                box.snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview().inset(16)
                    make.width.equalTo((UIScreen.main.bounds.width-13-13)/CGFloat(list.count))
                    if of == nil {
                        make.left.equalToSuperview()
                    } else {
                        make.left.equalTo(of!.snp.right)
                    }
                }
                
                of = box
                
                box.addSubview(l1t)
                box.addSubview(l1tv)
                
                l1t.snp.makeConstraints { make in
                    make.top.left.right.equalToSuperview()
                }
                
                l1tv.snp.makeConstraints { make in
                    make.left.right.bottom.equalToSuperview()
                    make.top.equalTo(l1t.snp.bottom).offset(4)
                }
            }
            
        }
    }
    
    
    let topimage = UIImageView()
    
    let topname = UILabel.init(title: "",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 12, weight: .bold))
    
    let toprightButton = UIButton.init(title: "",font: .systemFont(ofSize: 13), color: .init(hex: "#F9962F"))
    
    let money = UILabel.init(title: "",textColor: .init(hex: "#5B82F4"),font: .systemFont(ofSize: 26,weight: .bold))
    
    let centerrightButton = UIButton.init(title: YTTools.areaTitle(a: "View", b: "Melihat"),font: .systemFont(ofSize: 18), color: .white)
    
    
  
    
    let box3 = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .init(hex: "#F2F4F4")
        
        selectionStyle = .none
        
        centerrightButton.isUserInteractionEnabled = false
        
        
        let box = UIView()
        box.backgroundColor = .white
        box.cornersSet(by: .allCorners, radius: 12)
        contentView.add(box) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 5, left: 13, bottom: 5, right: 13))
            }
        }
        
        
        let box1 = UIView()
        box.add(box1) { v in
            v.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(32)
            }
            
            let leftBox = UIView()
            leftBox.backgroundColor = .init(hex: "#D4DFFF")
            box1.add(leftBox) { v in
                leftBox.cornersSet(by: .bottomRight, radius: 14)
                v.snp.makeConstraints { make in
                    make.left.top.bottom.equalToSuperview()
                }
                
                leftBox.add(topimage) { v in
                    topimage.cornersSet(by: .allCorners, radius: 4)
                    v.snp.makeConstraints { make in
                        make.left.equalToSuperview().offset(14)
                        make.centerY.equalToSuperview()
                        make.width.height.equalTo(21)
                    }
                }
                
                leftBox.add(topname) { v in
                    v.snp.makeConstraints { make in
                        make.left.equalTo(topimage.snp.right).offset(6)
                        make.centerY.equalToSuperview()
                        make.right.equalToSuperview().offset(-21)
                    }
                }
                
            }
            
            
            
            box1.add(toprightButton) { v in
                v.snp.makeConstraints { make in
                    make.right.equalToSuperview().offset(-12)
                    make.centerY.equalToSuperview()
                }
            }

        }
        
        let box2 = UIView()
        box.add(box2) { v in
            v.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.top.equalTo(box1.snp.bottom)
            }
            
            box2.add(money) { v in
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(14)
                    make.top.bottom.equalToSuperview().inset(16)
                }
            }
            
            box2.add(centerrightButton) { v in
                v.cornersSet(by: .allCorners, radius: 18)
                v.backgroundColor = .init(hex: "#5F85F4")
                v.snp.makeConstraints { make in
                    make.width.equalTo(86)
                    make.height.equalTo(36)
                    make.right.equalToSuperview().offset(-12)
                    make.centerY.equalToSuperview()
                }
            }
        }
        
        
       
        box.add(box3) { v in
            v.snp.makeConstraints { make in
                make.left.bottom.right.equalToSuperview()
                make.top.equalTo(box2.snp.bottom)
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
    
    var bringeth: String?
    
    required init(){}
}


class zhongjianListMdModel: SmartCodable {
    
    var downward:String?
    var lustily:String?
    
    required init(){}
}
