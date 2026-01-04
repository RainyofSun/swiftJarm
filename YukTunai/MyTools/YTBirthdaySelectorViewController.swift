//
//  YTBirthdaySelectorViewController.swift
//  YukTunai
//
//  Created by whoami on 2024/11/22.
//

import UIKit
import SnapKit
import SmartCodable

class YTBirthdaySelectorViewController: YTBaseViewController,UITableViewDataSource,UITabBarDelegate, UITableViewDelegate {

    let days = Array(1...31)
    
    let months = Array(1...12)
    
    let years: [Int] = {
            let currentYear = Calendar.current.component(.year, from: Date())
            return Array(1900...currentYear)
    }()
        
    var onHandleShow:((String)->())?
    
    let tipView = {
        let view = loanTipView(frame: CGRectZero)
        view.title.text = YTTools.areaTitle(a: "Select a time", b: "Pilih waktu")
        return view
    }()
    
    let closeButton = UIButton.init(title: "", image: "bacfewe")
    
        var selectedDay: Int?
        
        var selectedMonth: Int?
        
        var selectedYear: Int?
        
        var selectedDate: Date!
        
        var viewDefaultCenter: CGPoint = .zero
    
        
        let contentView1 = UIView()
        
        fileprivate let tableView = YTTableView.init(frame: .zero, style: .plain)
        
        fileprivate let tableView2 = YTTableView.init(frame: .zero, style: .plain)
        
        fileprivate let tableView3 = YTTableView.init(frame: .zero, style: .plain)
        
        
        let button1 = UIButton.init(title: YTTools.areaTitle(a: "Day", b: "Hari"), font: UIFont.init(name: "Helvetica", size: 18)!, color: .init(hex: "#AAAAAA"),bgColor: .white)
        
        let button2 = UIButton.init(title: YTTools.areaTitle(a: "Month", b: "Bulan"), font: UIFont.init(name: "Helvetica", size: 18)!, color: .init(hex: "#AAAAAA"),bgColor: .white)
        
        let button3 = UIButton.init(title: YTTools.areaTitle(a: "Year", b: "Tahun"), font: UIFont.init(name: "Helvetica", size: 18)!, color: .init(hex: "#AAAAAA"),bgColor: .white)

       
        let imageView = UIImageView(image: UIImage.init(named: "Groufwefwefwe2"))
        
        let bt1bg = UIImageView.init(image: UIImage.init(named: "fewfwefwf12232"))
        
        let t1 = UILabel.init(title: YTTools.areaTitle(a: "Please select a time", b: "Silakan pilih waktu"),textColor: .white,font: .systemFont(ofSize: 20,weight: .semibold))
     
        lazy var button : UIButton  = {
            let b = UIButton.init(title: YTTools.areaTitle(a: "Confrmation", b: "Konfirmasi"),font: .systemFont(ofSize: 18, weight: .bold), color: .white, image: "",bgColor: .init(hex: "#5F7FF4"))
            b.cornersSet(by: .allCorners, radius: 25)
            b.isUserInteractionEnabled = true
            b.addTarget(self, action: #selector(didi), for: .touchUpInside)
            return b
        }()
        
        let cbutton = UIButton.init(title: "",image: "关闭")
        
        
        init(select : Date!) {
            super.init(nibName: nil, bundle: nil)
            
            self.selectedDate = select
            
            view.isUserInteractionEnabled = true
            
            // 添加关闭按钮
            let closeButton = UIButton(type: .system)
            closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
            closeButton.tintColor = .white
            closeButton.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
            view.addSubview(closeButton)
            closeButton.snp.makeConstraints { make in
                make.right.equalTo(popupView)
                make.bottom.equalTo(loanTip.snp.top).offset(-10)
                make.width.height.equalTo(40)
            }
            
            view.backgroundColor = .init(hex: "000000",alpha: 0.8)
            
            view.add(contentView1) { v in
                contentView1.backgroundColor = .white
                contentView1.cornersSet(by: [.topLeft,.topRight], radius: 18)
                v.snp.makeConstraints { make in
                    make.bottom.equalToSuperview()
                    make.left.right.equalToSuperview()
                }
            }
            
            contentView1.add(tttt1) {v in
                v.textAlignment = .center
                v.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                    make.top.equalToSuperview().offset(13)
                }
            }
            
            contentView1.add(closeButton) {v in
                closeButton.addTarget(self, action: #selector(cloase), for: .touchUpInside)
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(18)
                    make.centerY.equalTo(tttt1)
                }
            }

            contentView1.add(button1) { v in
                button1.titleLabel?.textAlignment = .center
                v.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.top.equalTo(closeButton.snp.bottom).offset(58)
                    make.width.equalTo((UIScreen.main.bounds.width)/3)
                    make.height.equalTo(28)
                }
            }
            
            contentView1.add(button2) { v in
                button2.titleLabel?.textAlignment = .center
                v.snp.makeConstraints { make in
                    make.left.equalTo(button1.snp.right)
                    make.top.equalTo(closeButton.snp.bottom).offset(58)
                    make.width.equalTo((UIScreen.main.bounds.width)/3)
                    make.height.equalTo(28)
                }
            }
            
            contentView1.add(button3) { v in
                button3.titleLabel?.textAlignment = .center
                v.snp.makeConstraints { make in
                    make.left.equalTo(button2.snp.right)
                    make.top.equalTo(closeButton.snp.bottom).offset(58)
                    make.width.equalTo((UIScreen.main.bounds.width)/3)
                    make.height.equalTo(28)
                }
            }

            contentView1.add(tableView) { t in
                tableView.delegate = self
                tableView.dataSource = self
                tableView.tag = 0
                tableView.backgroundColor = .white
                tableView2.backgroundColor = .white
                tableView3.backgroundColor = .white
                t.snp.makeConstraints { make in
                    make.width.equalTo((UIScreen.main.bounds.width-18-18)/3)
                    make.top.equalTo(button1.snp.bottom).offset(8)
                    make.left.equalToSuperview()
                    make.height.equalTo(200)
                }
            }
            

            contentView1.add(tableView2) { t in
                tableView2.delegate = self
                tableView2.dataSource = self
                tableView2.tag = 1
                t.snp.makeConstraints { make in
                    make.width.equalTo(tableView.snp.width)
                    make.top.equalTo(button1.snp.bottom).offset(8)
                    make.left.equalTo(tableView.snp.right).offset(0)
                    make.height.equalTo(200)
                }
            }
            
           
            contentView1.add(tableView3) { t in
                tableView3.delegate = self
                tableView3.tag = 2
                tableView3.dataSource = self
                t.snp.makeConstraints { make in
                    make.height.equalTo(200)
                    make.width.equalTo(tableView2.snp.width)
                    make.top.equalTo(button1.snp.bottom).offset(8)
                    make.left.equalTo(tableView2.snp.right).offset(0)
                    make.right.equalToSuperview()
                   
                }
            }
            

            tableView.register(YTItemCell.self, forCellReuseIdentifier: YTItemCell.identifier)
            tableView2.register(YTItemCell.self, forCellReuseIdentifier: YTItemCell.identifier)
            tableView3.register(YTItemCell.self, forCellReuseIdentifier: YTItemCell.identifier)
            
            
            contentView1.add(button) {v in
                v.snp.makeConstraints { make in
                    make.left.right.equalToSuperview().inset(21)
                     make.top.equalTo(tableView3.snp.bottom).offset(62)
                    make.height.equalTo(50)
                    make.bottom.equalToSuperview().offset(YTTools.isIPhone6Series() ? -29 : -39)
                    
                }
                
            }

            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){[weak self] in
                self?.selectDate(date: select)
            }
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBarBgHidden()
        setNavigationBarHidden(true, animated: true)
    }
        
        @objc func cloase(){
            dismiss(animated: false)
        }
        
        @objc func didi(){
            
            guard let day = selectedDay,
                  let month = selectedMonth else {
                return
            }
            let year = years[selectedYear!]
            let dateString = "\(day)-\(month)-\(year)"
              
            onHandleShow?(dateString)
            cloase()
        }
        
      
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch tableView.tag {
            case 0:
                return days.count
            case 1:
                return months.count
            case 2:
                return years.count
            default:
                return 0
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: YTItemCell.identifier, for: indexPath) as?  YTItemCell else {
                return UITableViewCell()
            }
            
            switch tableView.tag {
            case 0:
                 cell.t1.text = "\(days[indexPath.row])"
                 cell.bgView.backgroundColor = (days[indexPath.row] == selectedDay)  ? UIColor.init(hex: "#ECF0FF",alpha: 1) : .clear
          
            case 1:
                cell.t1.text = "\(months[indexPath.row])"
                cell.bgView.backgroundColor = (months[indexPath.row] == selectedMonth)  ? UIColor.init(hex: "#ECF0FF",alpha: 1) : .clear
            case 2:
                cell.t1.text = "\(years[indexPath.row])"
                cell.bgView.backgroundColor = (indexPath.row == selectedYear)  ? UIColor.init(hex: "#ECF0FF",alpha: 1) : .clear
            default:
                break
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch tableView.tag {
            case 0:
                selectedDay = days[indexPath.row]
            case 1:
                selectedMonth = months[indexPath.row]
            case 2:
                selectedYear = indexPath.row
            default:
                break
            }
            
            tableView.reloadData()
        }
        
        
        func selectDate(date: Date) {
               let calendar = Calendar.current
            selectedDay = calendar.component(.day, from: date)
            selectedMonth = calendar.component(.month, from: date)
            selectedYear = calendar.component(.year, from: date)
               
               if let dayIndex = days.firstIndex(of: selectedDay!) {
                   selectedDay = dayIndex + 1
                   tableView.selectRow(at: IndexPath(row: dayIndex, section: 0), animated: true, scrollPosition: .middle)
                   tableView.scrollToRow(at: IndexPath(row: dayIndex, section: 0), at: .middle, animated: true)
                   
                   tableView.reloadData()
               }
               
               if let monthIndex = months.firstIndex(of: selectedMonth!) {
                   selectedMonth = monthIndex + 1
                   tableView2.selectRow(at: IndexPath(row: monthIndex, section: 0), animated: true, scrollPosition: .middle)
                   tableView2.scrollToRow(at: IndexPath(row: monthIndex, section: 0), at: .middle, animated: true)
                   tableView2.reloadData()
               }
               
               if let yearIndex = years.firstIndex(of: selectedYear!) {
                   selectedYear = yearIndex
                   tableView3.selectRow(at: IndexPath(row: yearIndex, section: 0), animated: true, scrollPosition: .middle)
                   tableView3.scrollToRow(at: IndexPath(row: yearIndex, section: 0), at: .middle, animated: true)
                   
               }

           }
        
        
    }




class YTItemCell: UITableViewCell {
    
    let t1 = UILabel.init(title:"",textColor: .init(hex: "#121212",alpha: 0.4),font: UIFont.init(name: "Helvetica", size: 18)!)
    

    let bgView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.backgroundColor = .clear
        
        backgroundColor = .clear
        
        contentView.add(bgView) { v in
            v.snp.makeConstraints { make in
                make.bottom.top.equalToSuperview()
                make.height.equalTo(44)
                make.left.right.equalToSuperview().inset(18)
            }
        }
        
        bgView.add(t1) { v in
            v.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.cornersSet(by: .allCorners, radius: 18)
   
    }
}




