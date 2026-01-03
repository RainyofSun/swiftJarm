//
//  QuestonViewController.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/3.
//

import UIKit
import MJRefresh

class QuestionCell: UITableViewCell {
    
    let cosnwView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#EAF5FF")
        view.cornersSet(by: UIRectCorner.allCorners, radius: 8)
        return view
    }()
    
    let titlskw: UILabel = UILabel(title: "", textColor: .black, font: UIFont.boldSystemFont(ofSize: 14))
    let subtitlskw: UILabel = UILabel(title: "", textColor: .black, font: UIFont.systemFont(ofSize: 14))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.add(cosnwView) { v in
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15))
            }
        }
        
        self.cosnwView.add(titlskw) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(15)
                make.top.equalToSuperview().offset(15)
            }
        }
        
        self.cosnwView.add(subtitlskw) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalTo(titlskw)
                make.top.equalTo(titlskw.snp.bottom).offset(8)
                make.bottom.equalToSuperview().offset(-15)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class QuestonViewController: YTBaseViewController {

    let viewModel = ApiViewModel()
    
    let titleswl = UILabel(title: LocalizationManager.shared().localizedString(forKey: "sqasd"), textColor: .white, font: UIFont.boldSystemFont(ofSize: 40))
    let tableView: UITableView = {
        let view = UITableView(frame: CGRectZero, style: UITableView.Style.plain)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    let leftStar: UIImageView = UIImageView(image: UIImage(named: "leftStar"))
    let rightStar: UIImageView = UIImageView(image: UIImage(named: "right_start"))
    
    var dataSource: [glassesItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.add(titleswl) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(navigationBarHeight + statusBarHeight)
            }
        }
        
        self.view.add(leftStar) { v in
            v.snp.makeConstraints { make in
                make.right.equalTo(titleswl.snp.left).offset(-12)
                make.top.equalTo(titleswl).offset(22)
            }
        }
        
        self.view.add(rightStar) { v in
            v.snp.makeConstraints { make in
                make.left.equalTo(titleswl.snp.right).offset(28)
                make.top.equalTo(titleswl.snp.top).offset(-10)
            }
        }
        
        tableView.register(QuestionCell.self, forCellReuseIdentifier: QuestionCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.add(tableView) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.top.equalTo(leftStar.snp.bottom).offset(5)
                make.bottom.equalToSuperview().offset(-10)
            }
        }
        
        addRefresh()
    }
    
    func addRefresh(){
        let HeaderRefresh = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.loadd()
        })
        HeaderRefresh.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        HeaderRefresh.setTitle("", for: .idle)
        HeaderRefresh.setTitle(YTTools.areaTitle(a: "Release to load more data", b: "Lepaskan untuk memuat lebih banyak data"), for: .pulling)
        HeaderRefresh.setTitle(YTTools.areaTitle(a:"Loading data",b:"Memuat data"), for: .refreshing)
        HeaderRefresh.lastUpdatedTimeLabel?.isHidden = true
        tableView.mj_header = HeaderRefresh
        self.tableView.mj_header?.beginRefreshing()
    }
    
    func loadd(){
        viewModel.question { [weak self] r in
            switch r {
            case .success(let m):
                
                guard let d = m?.upper else {
                    self?.tableView.mj_header?.endRefreshing()
                    return
                }
                guard let _sour = d.marched else {
                    return
                }
                
                self?.dataSource.removeAll()
                self?.dataSource.append(contentsOf: _sour)
                self?.tableView.mj_header?.endRefreshing()
                self?.tableView.reloadData()
                break
            case .failure(let e):
                self?.tableView.mj_header?.endRefreshing()
                SVProgressHUD.showError(withStatus: e.description)
                break
            }
        }
    }
}

extension QuestonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let _cell = tableView.dequeueReusableCell(withIdentifier: QuestionCell.identifier, for: indexPath) as? QuestionCell else {
            return UITableViewCell()
        }
        
        _cell.titlskw.text = dataSource[indexPath.row].strike
        _cell.subtitlskw.text = dataSource[indexPath.row].seized
        
        return _cell
    }
}
