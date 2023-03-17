//
//  StandardAlertController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/18.
//

import UIKit

final class StandardAlertController: UIViewController{

    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark)).then {
        $0.alpha = 0.2
    }
    
    private lazy var alertView = UIStackView(arrangedSubviews: [titleLabel,messageLabel,actionStackView]).then {
        $0.layer.masksToBounds = true
        $0.axis = .vertical
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = .init(width: 0, height: 3)
    }
    
    private let titleLabel = PaddingLabel(padding: .init(top: 22, left: 14, bottom: 8, right: 14)).then {
        $0.textAlignment = .center
        $0.font = .notoSans(size: 14, family: .Bold)
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    private let messageLabel = PaddingLabel(padding: .init(top: 0, left: 14, bottom: 20, right: 14)).then {
        $0.textAlignment = .center
        $0.font = .notoSans(size: 12, family: .Bold)
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    private let actionStackView = UIStackView().then {
        $0.distribution = .fillEqually
    }
    
    init(title: String?, message: String?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    
        self.titleLabel.text = title
        self.messageLabel.text = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layout()
        self.configure()
        self.prepareAction()
    }
    
    //MARK: - Configure
    private func configure() {
        self.view.backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(willDismissVC), name: .dismissStandardAlert, object: nil)
    }
    
    private func prepareAction() {
        guard let first = self.actionStackView.arrangedSubviews.first else { return }
        guard let last = self.actionStackView.arrangedSubviews.last else { return }
        first.layer.cornerRadius = 12
        first.layer.maskedCorners = .layerMinXMaxYCorner
        last.layer.cornerRadius = 12
        last.layer.maskedCorners = .layerMaxXMaxYCorner
    }
    
    func addAction(_ action: UIButton) {
        self.actionStackView.addArrangedSubview(action)
    }
    
    func addAction(_ actions: [UIButton]) {
        actions.forEach {
            self.actionStackView.addArrangedSubview($0)
        }
    }
    
    /// 알림 제목 부분 색 변환 ( 하이라이트) 함수
    func titleHighlight(highlightString: String, color: UIColor) {
        guard let oldAttributeStr = self.titleLabel.attributedText else { return }
        let newAttributeStr = NSMutableAttributedString(attributedString: oldAttributeStr)
        newAttributeStr.addAttribute(.foregroundColor, value: color, range: ((self.titleLabel.text ?? "") as NSString).range(of: highlightString))
        
        self.titleLabel.attributedText = newAttributeStr
    }
    
    /// 알림 메시지 부분 색 변환 ( 하이라이트) 함수
    func messageHighlight(highlightString: String, color: UIColor) {
        guard let oldAttributeStr = self.messageLabel.attributedText else { return }
        let newAttributeStr = NSMutableAttributedString(attributedString: oldAttributeStr)
        newAttributeStr.addAttribute(.foregroundColor, value: color, range: ((self.messageLabel.text ?? "") as NSString).range(of: highlightString))
        
        self.messageLabel.attributedText = newAttributeStr
    }
    
    // MARK: - AddSubView
    private func addSubView() {
        self.view.addSubview(self.blurEffectView)
        self.view.addSubview(self.alertView)
    }
    
    // MARK: - Layout
    private func layout() {
        self.alertView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        self.blurEffectView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Selector
    @objc private func willDismissVC() {
        self.dismiss(animated: false)
    }
}
