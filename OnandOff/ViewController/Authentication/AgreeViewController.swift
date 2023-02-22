//
//  AgreeViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/17.
//

import UIKit
import SwiftUI

class AgreeViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var allAgreeView: CheckView = {
        return CheckView(firstSentence: "", secondSentence: "약관 전체동의", imageName: "")
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
        return view
    }()
    
    private lazy var ageAgreeView: CheckView = {
        return CheckView(firstSentence: "(필수) ", secondSentence: "만 14세 이상입니다", imageName: "")
    }()
    
    private lazy var serviceAgreeView: CheckView = {
        return CheckView(firstSentence: "(필수) ", secondSentence: "서비스 이용 약관", imageName: "rightArrow")
    }()
    
    private lazy var infoAgreeView: CheckView = {
        return CheckView(firstSentence: "(필수) ", secondSentence: "개인정보 처리방침", imageName: "rightArrow")
    }()
    
    private lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("동의", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor
        button.addTarget(self, action: #selector(didTapAgreeButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "서비스 이용 동의"
        configureLayout()
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    @objc func didTapAgreeButton() {
        print(#function)
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

struct AgreeViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        UINavigationController(rootViewController: AgreeViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct AgreeViewController_Previews: PreviewProvider {
    static var previews: some View {
        AgreeViewControllerRepresentable()
    }
}

