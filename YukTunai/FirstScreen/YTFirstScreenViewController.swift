//
//  YTFirstScreenViewController.swift
//  YukTunai
//
//  Created by 张文 on 2024/11/18.
//

import UIKit

class YTFirstScreenViewControllercell: UICollectionViewCell {
    
    
    let imageV = UIImageView()
    let t2 = UILabel.init(title:"",textColor: .white,font: .systemFont(ofSize: 28,weight: .bold), alignment: .center)
    let t3 = UILabel.init(title:"",textColor: .white,font: .systemFont(ofSize: 18), alignment: .center)
    
    var imageName: String? {
        didSet {
            imageV.image = UIImage.init(named: imageName!)
            
        }
    }
    
    
    var iconName: String? {
        didSet {
            t2.text = iconName!
            
        }
    }
    
    var icon1Name: String? {
        didSet {
           
            t3.text = icon1Name!
            
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageV.contentMode = .scaleAspectFill
        contentView.addSubview(imageV)
        imageV.snp.makeConstraints { make in
            if YTTools.isIPhone6Series() {
                make.top.equalToSuperview().offset(-72)
            } else {
                make.top.equalToSuperview()
            }
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        contentView.add(t2) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(24)
                make.top.equalToSuperview().offset(statusBarHeight+88)
            }
        }
        
        t3.numberOfLines = 4
        contentView.add(t3) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(34)
                make.top.equalTo(t2.snp.bottom).offset(16)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init Error")
    }
}



class YTFirstScreenViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    var handle: (()->())?
    
    private var pageControl: UIPageControl!
    
    private var currentIndex: Int = 0
    
    let collectionView: YTBaseCollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let collectionView = YTBaseCollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        return collectionView
    }()

    @objc let nextButton = {
        let view = GradientLoadingButton.init(frame: CGRectZero)
        view.setTitle(LocalizationManager.shared().localizedString(forKey: "auth_btn"))
        return view
    }()
                                           
    fileprivate var pages:[String] {
        return ["guide_one", "guide_two"]
    }

    fileprivate var pages1:[String] {
        return [LocalizationManager.shared().localizedString(forKey: "guide_one_t"),
                LocalizationManager.shared().localizedString(forKey: "guide_two_t")]
    }
    
    fileprivate var pages2:[String] {
        return [LocalizationManager.shared().localizedString(forKey: "guide_one_content"),
                LocalizationManager.shared().localizedString(forKey: "guide_two_content"),]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.add(collectionView) { v in
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(YTFirstScreenViewControllercell.self, forCellWithReuseIdentifier: YTFirstScreenViewControllercell.identifier)
            v.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        nextButton.addTarget(self, action: #selector(scrollToNext), for: .touchUpInside)
        view.add(nextButton) { v in
            v.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(36)
                make.height.equalTo(50)
                make.bottom.equalToSuperview().offset(-75)
            }
        }
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.init(hex: "#FEC95D")
        pageControl.pageIndicatorTintColor = UIColor.init(hex: "#FFFFFF")
        view.add(pageControl) { v in
            v.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(nextButton.snp.top).offset(-50)
            }
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YTFirstScreenViewControllercell.identifier, for: indexPath) as? YTFirstScreenViewControllercell else {
            return UICollectionViewCell()
        }
        cell.imageName = pages[indexPath.row]
        cell.iconName = pages1[indexPath.row]
        cell.icon1Name = pages2[indexPath.row]
        return cell
    }
    
    
    @objc private func scrollToNext() {
        guard currentIndex + 1 < pages.count else {
            handle?()
            return
        }
        let nextIndex = currentIndex + 1
        if nextIndex >= pages.count {
            currentIndex = pages.count
        } else {
            collectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .left, animated: true)
            currentIndex = nextIndex
        }
        updatePageControl()
    }
    
    private func updatePageControl() {
        pageControl.currentPage = currentIndex % pages.count
        nextButton.setTitle(currentIndex == pages.count-1 ? LocalizationManager.shared().localizedString(forKey: "guide_com") : LocalizationManager.shared().localizedString(forKey: "auth_btn"))
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        fixeCurrentIndex()
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        fixeCurrentIndex()
    }
    
    private func fixeCurrentIndex() {
        let pageWidth = collectionView.frame.size.width
        let currentPage = Int(collectionView.contentOffset.x / pageWidth)
        currentIndex = currentPage
        updatePageControl()
    }
    
}





