//
//  StandardActionSheet.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/20.
//

import UIKit

final class StandardActionSheetViewcontroller: UIViewController {    
    private let backButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark)).then {
        $0.alpha = 0.2
    }
    
    private lazy var actionSheetView = UIStackView(arrangedSubviews: [titleLabel,actionStackView]).then {
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
    
    private let actionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    init(title: String?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    
        self.titleLabel.text = title
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
        self.addTarget()
    }
    
    //MARK: - Configure
    private func configure() {
        self.view.backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(willDismissVC), name: .dismissStandardActionSheet
                                               , object: nil)
    }
    
    private func prepareAction() {
        guard let first = self.actionStackView.arrangedSubviews.first as? StandardActionSheetAction else { return }
        first.lineLayer.isHidden = true
    }
    
    func addAction(_ action: StandardActionSheetAction) {
        self.actionStackView.addArrangedSubview(action)
    }
    
    func addAction(_ actions: [StandardActionSheetAction]) {
        actions.forEach {
            self.actionStackView.addArrangedSubview($0)
        }
    }
    
    //MARK: - Selector
    @objc private func willDismissVC() {
        self.dismiss(animated: true)
    }
    
    // MARK: - AddSubView
    private func addSubView() {
        self.view.addSubview(self.blurEffectView)
        self.view.addSubview(self.actionSheetView)
        self.actionSheetView.addSubview(self.backButton)
    }
    
    // MARK: - Layout
    private func layout() {
        self.actionSheetView.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.backButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(20)
            $0.width.height.equalTo(18)
        }

        self.blurEffectView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(self.actionSheetView.snp.centerY)
        }
    }
    
    // MARK: - AddTarget
    private func addTarget() {
        self.backButton.addTarget(self, action: #selector(self.willDismissVC), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.willDismissVC))
        self.blurEffectView.addGestureRecognizer(tap)
    }
}
