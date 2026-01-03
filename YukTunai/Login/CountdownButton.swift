//
//  CountdownButton.swift
//  YukTunai
//
//  Created by Yu Chen  on 2026/1/1.
//

import UIKit

class CountdownButton: UIControl {

    // MARK: - Public Config

    /// 倒计时总时长（秒）
    var totalSeconds: Int = 60

    /// 默认文案
    var normalTitle: String = LocalizationManager.shared().localizedString(forKey: "login_v_code_btn")

    /// 倒计时文案回调
    var countingTitle: ((Int) -> String)?

    /// 倒计时结束文案
    var finishedTitle: String?

    // MARK: - Private

    private var timer: Timer?
    private var remainingSeconds: Int = 0

    private let titleLabel = UILabel()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - UI

    private func setupUI() {

        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titleLabel.text = normalTitle

        addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Touch

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isEnabled else { return }
        sendActions(for: .touchUpInside)
    }

    // MARK: - Countdown Control

    /// 开始倒计时
    func start() {
        isEnabled = false
        remainingSeconds = totalSeconds
        updateTitle()

        timer?.invalidate()
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true
        )
        RunLoop.main.add(timer!, forMode: .common)
    }

    /// 停止倒计时（不会自动恢复）
    func stop() {
        timer?.invalidate()
        timer = nil
    }

    /// 重置倒计时
    func reset() {
        stop()
        isEnabled = true
        titleLabel.text = finishedTitle ?? normalTitle
    }

    // MARK: - Timer

    @objc private func tick() {
        remainingSeconds -= 1
        if remainingSeconds <= 0 {
            reset()
        } else {
            updateTitle()
        }
    }

    private func updateTitle() {
        if let countingTitle = countingTitle {
            titleLabel.text = countingTitle(remainingSeconds)
        } else {
            titleLabel.text = "\(remainingSeconds)s"
        }
    }

    deinit {
        timer?.invalidate()
    }
}
