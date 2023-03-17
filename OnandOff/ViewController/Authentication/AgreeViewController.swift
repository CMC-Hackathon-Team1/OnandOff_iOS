//
//  AgreeViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/17.
//

import UIKit

final class AgreeViewController: UIViewController {
    // MARK: - Properties
    var allFlag: Bool = false
    var ageFlag: Bool = false
    var serviceFlag: Bool = false
    var infoFlag: Bool = false
    
    var isValid: Bool {
        return (ageFlag == true && serviceFlag == true && infoFlag == true)
    }
    
    private lazy var allAgreeView: CheckView = {
        return CheckView(firstSentence: "", secondSentence: "약관 전체동의", checkButton: allAgreeButton, imageName: "")
    }()
    
    private lazy var allAgreeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.1529411765, green: 0.1450980392, blue: 0.1215686275, alpha: 1)
        button.snp.makeConstraints { $0.height.width.equalTo(16) }
        button.clipsToBounds = true
        button.layer.cornerRadius = 16 / 2
        button.addTarget(self, action: #selector(didTapAllAgreeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
        return view
    }()
    
    private lazy var ageAgreeView: CheckView = {
        return CheckView(firstSentence: "(필수) ", secondSentence: "만 14세 이상입니다", checkButton: ageAgreeButton, imageName: "")
    }()
    
    private lazy var ageAgreeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.1529411765, green: 0.1450980392, blue: 0.1215686275, alpha: 1)
        button.snp.makeConstraints { $0.height.width.equalTo(16) }
        button.clipsToBounds = true
        button.layer.cornerRadius = 16 / 2
        button.addTarget(self, action: #selector(didTapAgeAgreeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var serviceAgreeView: CheckView = {
        return CheckView(firstSentence: "(필수) ", secondSentence: "서비스 이용 약관", checkButton: serviceAgreeButton, imageName: "rightArrow")
    }()
    
    private lazy var serviceAgreeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.1529411765, green: 0.1450980392, blue: 0.1215686275, alpha: 1)
        button.snp.makeConstraints { $0.height.width.equalTo(16) }
        button.clipsToBounds = true
        button.layer.cornerRadius = 16 / 2
        button.addTarget(self, action: #selector(didTapServiceAgreeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var infoAgreeView: CheckView = {
        return CheckView(firstSentence: "(필수) ", secondSentence: "개인정보 처리방침", checkButton: infoAgreeButton, imageName: "rightArrow")
    }()
    
    private lazy var infoAgreeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.1529411765, green: 0.1450980392, blue: 0.1215686275, alpha: 1)
        button.snp.makeConstraints { $0.height.width.equalTo(16) }
        button.clipsToBounds = true
        button.layer.cornerRadius = 16 / 2
        button.addTarget(self, action: #selector(didTapInfoAgreeButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("동의", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapAgreeButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "서비스 이용 동의"
        configureLayout()
        view.backgroundColor = .white
        self.navigationItem.backButtonTitle = ""
    }
    
    // MARK: - Actions
    @objc func didTapAllAgreeButton() {
        print(#function)
        if allFlag {
            allAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
            ageAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
            serviceAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
            infoAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
            agreeButton.isEnabled = false
            agreeButton.backgroundColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        } else {
            allAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheck"), for: .normal)
            ageAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheck"), for: .normal)
            serviceAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheck"), for: .normal)
            infoAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheck"), for: .normal)
            agreeButton.isEnabled = true
            agreeButton.backgroundColor = .mainColor
        }
        allFlag.toggle()
        ageFlag.toggle()
        serviceFlag.toggle()
        infoFlag.toggle()
    }
    
    @objc func didTapAgeAgreeButton() {
        print(isValid)
        if ageFlag {
            ageAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)

        } else {
            ageAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheck"), for: .normal)
        }
        ageFlag.toggle()
        
        print(isValid)
        if isValid {
            agreeButton.isEnabled = true
            agreeButton.backgroundColor = .mainColor
        } else {
            agreeButton.isEnabled = false
            agreeButton.backgroundColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        }
    }
    
    @objc func didTapServiceAgreeButton() {
        if serviceFlag {
            serviceAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
        } else {
            serviceAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheck"), for: .normal)
        }
        serviceFlag.toggle()
        
        print(isValid)
        if isValid {
            agreeButton.isEnabled = true
            agreeButton.backgroundColor = .mainColor
        } else {
            agreeButton.isEnabled = false
            agreeButton.backgroundColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        }
    }
    
    @objc func didTapInfoAgreeButton() {
        if infoFlag {
            infoAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
        } else {
            infoAgreeButton.setImage(#imageLiteral(resourceName: "anonymousCheck"), for: .normal)
        }
        infoFlag.toggle()
        
        print(isValid)
        if isValid {
            agreeButton.isEnabled = true
            agreeButton.backgroundColor = .mainColor
        } else {
            agreeButton.isEnabled = false
            agreeButton.backgroundColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        }
    }
    
    @objc func didTapAgreeButton() {
        self.defaultAlert(title: "회원가입 성공!") {
            let vc = self.navigationController?.viewControllers.prefix(2).map { $0 }
            self.navigationController?.viewControllers = vc ?? []
        }
    }
    
    // MARK: - Helpers
    func configureLayout() {
        view.addSubview(allAgreeView)
        allAgreeView.snp.makeConstraints {
            $0.width.equalTo(328)
            $0.height.equalTo(24)
            $0.top.equalTo(view.snp.top).offset(120)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        view.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            $0.width.equalTo(328)
            $0.height.equalTo(1)
            $0.top.equalTo(view.snp.top).offset(155)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        let stackView = UIStackView(arrangedSubviews: [ageAgreeView, serviceAgreeView, infoAgreeView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(175)
            $0.bottom.equalTo(view.snp.top).offset(275)
            $0.width.equalTo(328)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        view.addSubview(agreeButton)
        agreeButton.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(325)
            $0.width.equalTo(322)
            $0.height.equalTo(49)
            $0.centerX.equalTo(view.snp.centerX)
        }
        agreeButton.layer.cornerRadius = 5
    }
}


