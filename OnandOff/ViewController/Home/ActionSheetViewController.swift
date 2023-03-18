//
//  ActionSheetViewController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/12.
//

import UIKit
import SnapKit

final class ActionSheetViewController: UIViewController {
    weak var delegate: ActionSheetDelegate?
    weak var delegatePhoto: ActionSheetPhotoDelegate?
    var id: Int?
    
    private let frameView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        $0.layer.shadowOpacity = 0.6
        $0.layer.shadowOffset = .zero
    }
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    let titleLabel = UILabel().then {
        $0.font = .notoSans(size: 14, family: .Bold)
        $0.textColor = .black
    }
    
    let firstButton = UIButton(type: .system).then {
        $0.tag = 0
        var configure = UIButton.Configuration.plain()
        configure.imagePlacement = .leading
        configure.baseForegroundColor = .black
        configure.imagePadding = 20
        $0.configuration = configure
        $0.contentHorizontalAlignment = .leading
    }
    
    private let separatorLine = UIView().then {
        $0.backgroundColor = .text4
    }
    
    let secondButton = UIButton(type: .system).then {
        $0.tag = 1
        var configure = UIButton.Configuration.plain()
        configure.imagePlacement = .leading
        configure.baseForegroundColor = .black
        configure.imagePadding = 20
        $0.configuration = configure
        $0.contentHorizontalAlignment = .leading
    }
    
    init(title: String, firstImage: UIImage, firstText: String, secondImage: UIImage, secondText: String) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
        self.firstButton.setTitle(firstText, for: .normal)
        self.firstButton.setImage(firstImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.secondButton.setTitle(secondText, for: .normal)
        self.secondButton.setImage(secondImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layout()
        self.addTarget()
        self.view.backgroundColor = .clear
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Selector
    @objc private func didClickBackButton() {
        self.dismiss(animated: false)
    }
    
    @objc private func respondsToButton(_ sender: UIButton) {
        self.dismiss(animated: true) { [weak self] in
            sender.tag == 0 ? self?.delegate?.didClickFirstItem(id: self?.id ?? 0) : self?.delegate?.didClickSecondItem(id: self?.id ?? 0)
            sender.tag == 0 ? self?.delegatePhoto?.didClickFirstItem() : self?.delegatePhoto?.didClickSecondItem()
        }
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.view.addSubview(self.frameView)
        
        self.frameView.addSubview(self.backButton)
        self.frameView.addSubview(self.titleLabel)
        self.frameView.addSubview(self.firstButton)
        self.frameView.addSubview(self.separatorLine)
        self.frameView.addSubview(self.secondButton)
    }
    
    private func layout() {
        self.frameView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(self.view.snp.height).multipliedBy(0.24)
        }
        
        self.backButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(24)
            $0.width.height.equalTo(13)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }
        
        self.firstButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(50)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(12)
        }
        
        self.separatorLine.snp.makeConstraints {
            $0.top.equalTo(self.firstButton.snp.bottom).offset(2)
            $0.height.equalTo(1)
            $0.width.equalTo(UIScreen.main.bounds.width - 22)
            $0.centerX.equalToSuperview()
        }
        
        self.secondButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(50)
            $0.top.equalTo(self.separatorLine.snp.bottom).offset(2)
        }
    }
    
    private func addTarget() {
        self.backButton.addTarget(self, action: #selector(didClickBackButton), for: .touchUpInside)
        self.firstButton.addTarget(self, action: #selector(respondsToButton), for: .touchUpInside)
        self.secondButton.addTarget(self, action: #selector(respondsToButton), for: .touchUpInside)
    }
}
