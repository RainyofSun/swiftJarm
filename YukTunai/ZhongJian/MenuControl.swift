//
//  MenuControl.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/2.
//

import UIKit

class MenuControl: UIControl {

    // MARK: - Public

    var titles: [String] = [] {
        didSet { reloadData() }
    }

    /// 当前选中下标（外部可直接设置）
    private(set) var selectedIndex: Int = 0

    /// 点击回调
    var onSelectIndex: ((Int) -> Void)?

    /// 文字颜色
    var normalColor: UIColor = .white
    var selectedColor: UIColor = .white

    /// 指示器高度
    var indicatorHeight: CGFloat = 2

    // MARK: - Private

    private let stackView = UIStackView()
    private let indicatorView = UIView()
    private var labels: [UILabel] = []
    private var didLayoutOnce = false
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)

        indicatorView.backgroundColor = selectedColor
        addSubview(indicatorView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - Data

    private func reloadData() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        labels.removeAll()

        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textColor = index == selectedIndex ? selectedColor : normalColor

            // 关键点：文字自动缩小
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.7
            label.numberOfLines = 1

            label.tag = index
            label.isUserInteractionEnabled = true
            label.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(itemTapped(_:)))
            )

            labels.append(label)
            stackView.addArrangedSubview(label)
        }

        layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
            self.updateIndicator(animated: false)
        })
    }

    // MARK: - Action

    @objc private func itemTapped(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else { return }
        setSelectedIndex(view.tag, animated: true, notify: true)
    }

    // MARK: - Public API

    /// 外部设置选中下标
    func setSelectedIndex(_ index: Int, animated: Bool = true) {
        setSelectedIndex(index, animated: animated, notify: true)
    }

    // MARK: - Core Logic

    private func setSelectedIndex(_ index: Int, animated: Bool, notify: Bool) {
        guard index >= 0, index < labels.count else { return }

        selectedIndex = index

        for (i, label) in labels.enumerated() {
            label.textColor = (i == index) ? selectedColor : normalColor
        }

        updateIndicator(animated: animated)

        if notify {
            onSelectIndex?(index)
        }
    }

    private func updateIndicator(animated: Bool) {
        guard selectedIndex >= 0, selectedIndex < labels.count else { return }

        let label = labels[selectedIndex]

        // 1. 文字宽度的一半
        let textWidth = textWidth(for: label)
        let indicatorWidth = textWidth * 0.5

        // 2. indicator frame
        let targetFrame = CGRect(
            x: label.center.x - indicatorWidth / 2,
            y: bounds.height - indicatorHeight,
            width: indicatorWidth,
            height: indicatorHeight
        )
        
        if animated {
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           options: [.curveEaseInOut],
                           animations: {
                self.indicatorView.frame = targetFrame
            })
        } else {
            indicatorView.frame = targetFrame
        }
    }
    
    private func textWidth(for label: UILabel) -> CGFloat {
        guard let text = label.text, let font = label.font else { return 0 }
        let size = (text as NSString).size(withAttributes: [.font: font])
        return ceil(size.width)
    }
}
