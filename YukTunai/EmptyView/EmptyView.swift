//
//  Empty.swift
//  Toni
//
//  Created by 张文 on 2022/5/19.
//

import UIKit



open class EmptyDataSourceView: UIView {
    
    // 占位图
    var image: UIImage?
    
    // 标题
    var title: String?
    
    // 按钮
    var buttonTitle: String?
    var buttonImage : String = ""
    
    // 回调
    var action: (()->())?
    
    // 偏移
    var offsetY: CGFloat = 0.0
    
    var topOffset: CGFloat? = 0.0 //距离父视图顶部距离
    
    var scrollView: UIScrollView?

    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor(hex: "#62B0FE")
    }
    
    /// 布局显示
    func layoutSubViews(){
        
        let mainView = UIView()
        add(mainView) { v in
            mainView.snp.makeConstraints { make in
                make.centerY.equalTo(self).offset(self.offsetY)
                make.left.right.equalTo(self)
            }
        }
        // 图片
        var lable: UILabel?
        if let i = image {
            let imageView = UIImageView.init(image: i)
            mainView.add(imageView) { v in
                imageView.snp.makeConstraints { make in
                    make.top.equalTo(mainView)
                    make.width.height.equalTo(i.size.width)
                    make.centerX.equalTo(mainView)
                    if self.title == nil {
                        make.bottom.equalTo(mainView)
                    }
                }
            }
            
            if title != nil {
                lable = UILabel.init(title: title, textColor: .init(hex:"#8A8A8A"), font: UIFont.systemFont(ofSize: 14, weight: .regular), numOfLines: 0, alignment: .center)
                mainView.add(lable!) { v in
                    lable!.snp.makeConstraints { make in
                        make.top.equalTo(imageView.snp.bottom).offset(24)
                        make.centerX.equalTo(mainView)
                        if self.buttonTitle == nil {
                            make.bottom.equalTo(mainView)
                        }
                    }
                }
            }
            
            if buttonTitle != nil {
                let button = UIButton.init(title: buttonTitle!, font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium), color: UIColor(hex: "#2864D7"), image: "", bgColor: UIColor(hex: "#EAF5FF"))
                button.setTitle(title: buttonTitle!)
                button.setImage(image: buttonImage)
                button.cornersSet(by: UIRectCorner.allCorners, radius: 4)
                mainView.add(button) { v in
                    button.addTarget(self, action: #selector(doAction), for: .touchUpInside)
                    button.snp.makeConstraints { make in
                        make.top.equalTo(lable!.snp.bottom).offset(14)
                        make.centerX.bottom.equalTo(mainView)
                        make.height.equalTo(36)
                        make.width.equalTo(120)
                    }
                }
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func doAction(){
        action?()
    }

}

