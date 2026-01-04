//
//  YTBirthdaySelectorViewController.swift
//  YukTunai
//
//  Created by whoami on 2024/11/22.
//

import UIKit
import SnapKit
import SmartCodable
import BRPickerView

class YTBirthdaySelectorViewController: PPAlertCksViewController {
        
    var onHandleShow:((String)->())?
    
    let selectbgview: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor(hex: "#2864D7")
        view.cornersSet(by: UIRectCorner.allCorners, radius: 4)
        return view
    }()
    
    let button1 = UIButton.init(title: YTTools.areaTitle(a: "Day", b: "Hari"), font: UIFont.init(name: "Helvetica", size: 16)!, color: .init(hex: "#FFFFFF"))
    
    let button2 = UIButton.init(title: YTTools.areaTitle(a: "Month", b: "Bulan"), font: UIFont.init(name: "Helvetica", size: 18)!, color: .init(hex: "#FFFFFF"))
    
    let button3 = UIButton.init(title: YTTools.areaTitle(a: "Year", b: "Tahun"), font: UIFont.init(name: "Helvetica", size: 18)!, color: .init(hex: "#FFFFFF"))
    
    private lazy var timePickerView: BRDatePickerView = {
        let picker = BRDatePickerView(frame: CGRectZero)
        picker.minDate = NSDate.br_setYear(1949, month: 3, day: 12)
        picker.maxDate = NSDate.now
        picker.pickerMode = .YMD
        let pickerStyle = BRPickerStyle()
        pickerStyle.hiddenDoneBtn = true
        pickerStyle.hiddenCancelBtn = true
        pickerStyle.hiddenTitleLine = true
        pickerStyle.pickerColor = .clear
        pickerStyle.pickerTextColor = UIColor.black
        pickerStyle.pickerTextFont = UIFont.boldSystemFont(ofSize: 16)
        pickerStyle.selectRowTextColor = UIColor.white
        pickerStyle.selectRowTextFont = UIFont.boldSystemFont(ofSize: 16)
        pickerStyle.separatorColor = UIColor.clear
        pickerStyle.pickerHeight = 305
        picker.pickerStyle = pickerStyle
        
        return picker
    }()
    
    private lazy var pickerContentView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 305))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loanTileView.title.text = YTTools.areaTitle(a: "Please select a time", b: "Silakan pilih waktu")
        
        let btnBox = UIView()
        btnBox.backgroundColor = UIColor(hex: "#FF8827")
        
        contentView.add(btnBox) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.top.equalToSuperview().offset(25)
                make.height.equalTo(40)
            }
            
            btnBox.add(button1) { v in
                button1.titleLabel?.textAlignment = .center
                v.snp.makeConstraints { make in
                    make.left.verticalEdges.equalToSuperview()
                }
            }
            
            btnBox.add(button2) { v in
                button2.titleLabel?.textAlignment = .center
                v.snp.makeConstraints { make in
                    make.left.equalTo(button1.snp.right)
                    make.verticalEdges.width.equalTo(button1)
                }
            }
            
            btnBox.add(button3) { v in
                button3.titleLabel?.textAlignment = .center
                v.snp.makeConstraints { make in
                    make.left.equalTo(button2.snp.right)
                    make.verticalEdges.width.equalTo(button2)
                    make.right.equalToSuperview()
                }
            }
        }
        
        contentView.addSubview(self.pickerContentView)
        self.timePickerView.addPicker(to: self.pickerContentView)
        
        self.timePickerView.resultBlock = {[weak self] (selesssctDate: Date?, selectValue: String?) in
            guard let _date = selesssctDate else {
                return
            }
            
            if let time = NSDate.br_string(from: _date, dateFormat: "yyyy-MM-dd") {
                self?.onHandleShow?(time)
            }
        }
        
        self.pickerContentView.snp.makeConstraints { make in
            make.top.equalTo(btnBox.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(305)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self.timePickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.insertSubview(selectbgview, belowSubview: self.pickerContentView)
        selectbgview.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.centerY.equalTo(pickerContentView)
        }
    }
        
    override func submitContent() {
        self.timePickerView.doneBlock?()
        self.closeAlertController()
    }
}
