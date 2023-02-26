//
//  EmailAuthViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/17.
//

import UIKit
import SwiftUI

class EmailAuthViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.alignment = .center
        let attributedText = NSMutableAttributedString(string: "___________________ 로 전송되었습니다.\n이메일 링크에 접속한 후, 아래 인증하기 버튼을 눌러주세요.", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        label.font = .notoSans(size: 14, family: .Bold)
        label.attributedText = attributedText
        return label
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mainColor
        button.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "이메일 인증"
        configureLayout()
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    @objc func didTapAuthButton() {
        print(#function)
    }
    
    // MARK: - Helpers
    func configureLayout() {
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints {
            $0.width.equalTo(340)
            $0.height.equalTo(48)
            $0.top.equalTo(view.snp.top).offset(120)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        view.addSubview(authButton)
        authButton.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(50)
            $0.width.equalTo(322)
            $0.height.equalTo(49)
            $0.centerX.equalTo(view.snp.centerX)
        }
        authButton.layer.cornerRadius = 5
    }
}


