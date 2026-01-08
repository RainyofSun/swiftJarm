//
//  YTSelectViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/21.
//

import UIKit
import BRPickerView

class YTSelectViewController: PPAlertCksViewController {

    var onKeluarButtonTapped: ((String?) -> Void)?
    
    var model: roseModel?
    
    let selectbgview: UIView = {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor(hex: "#2864D7")
        view.cornersSet(by: UIRectCorner.allCorners, radius: 4)
        return view
    }()
    
    private lazy var suwjeypickerView: BRTextPickerView = {
        let _pickView = BRTextPickerView(pickerMode: BRTextPickerMode.componentSingle)
        let style: BRPickerStyle = BRPickerStyle()
        style.hiddenDoneBtn = true
        style.hiddenCancelBtn = true
        style.hiddenTitleLine = true
        style.pickerColor = .clear
        style.pickerTextColor = UIColor.black
        style.pickerTextFont = UIFont.boldSystemFont(ofSize: 16)
        style.selectRowTextColor = UIColor.white
        style.selectRowTextFont = UIFont.boldSystemFont(ofSize: 16)
        style.pickerHeight = 305
        style.separatorColor = UIColor.clear
        _pickView.pickerStyle = style
        return _pickView
    }()
    
    private lazy var pickerContentView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 305))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.addSubview(self.pickerContentView)
        self.suwjeypickerView.addPicker(to: self.pickerContentView)
        
        self.suwjeypickerView.singleChangeBlock = {[weak self] (models: BRTextModel?, indes: Int) in
            self?.model = roseModel()
            self?.model?.ensued = models?.text
            self?.model?.directly = models?.code
        }
        
        self.suwjeypickerView.singleResultBlock = {[weak self] (models: BRTextModel?, indes: Int) in
            self?.model = roseModel()
            self?.model?.ensued = models?.text
            self?.model?.directly = models?.code
        }
        
        self.pickerContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(305)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self.suwjeypickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.insertSubview(selectbgview, belowSubview: self.pickerContentView)
        selectbgview.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.centerY.equalTo(pickerContentView)
        }
    }
    
    func reloadSindlwPickerViews(moelsw: [roseModel]) {
        var slws_arskw: [[String: String]] = []
        
        moelsw.forEach { element in
            if let _ke = element.directly, let _text = element.ensued {
                slws_arskw.append(["code": _ke, "text": _text])
            }
        }
        
        self.suwjeypickerView.dataSourceArr = NSArray.br_modelArray(withJson: slws_arskw, mapper: nil)
        self.suwjeypickerView.addPicker(to: self.pickerContentView)
    }
    
    override func submitContent() {
        self.suwjeypickerView.doneBlock?()
        if let _siw = self.model?.ensued {
            onKeluarButtonTapped?(_siw)
        }
        
        self.closeAlertController()
    }
}
