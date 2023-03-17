//
//  EmailAuthViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/17.
//

import UIKit

final class EmailAuthViewController: UIViewController {
    // MARK: - Properties
    private let email: String
    private let password: String
    
    private let mainLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = .notoSans(size: 14, family: .Bold)
    }
    
    private lazy var authButton = UIButton(type: .system).then {
        $0.setTitle("인증", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 16, family: .Bold)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(didClickAuthButton), for: .touchUpInside)
    }
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
        self.mainLabel.text = "\(email) 로 전송되었습니다.\n이메일 링크에 접속한 후, 아래 인증하기 버튼을 눌러주세요."
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.configureLayout()
        self.title = "이메일 인증"
        self.view.backgroundColor = .white
    }
    
    // MARK: - Actions
    @objc func didClickAuthButton() {
        AuthService.userRegister(email: email, password: password, level: 1) { res in
            if let response = res {
                switch response.statusCode {
                case 100:
                    let agreeVC = AgreeViewController()
                    self.navigationController?.pushViewController(agreeVC, animated: true)
                case 1002:
                    let alert = StandardAlertController(title: "이메일을 확인 후 클릭해주세요.\n해당 인증메일은 10분 후 만료됩니다.", message: nil)
                    let ok = StandardAlertAction(title: "확인", style: .basic)
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false)
                default:
                    print(res?.statusCode)
                    print(res?.message)
                    let alert = StandardAlertController(title: "이메일 인증 실패", message: nil)
                    let ok = StandardAlertAction(title: "확인", style: .basic) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false)
                }
            }
        }
    }
    
    //MARK: - AddSubView()
    private func addSubView() {
        self.view.addSubview(self.mainLabel)
        self.view.addSubview(self.authButton)
    }
    
    // MARK: - Helpers
    private func configureLayout() {
        self.mainLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        self.authButton.snp.makeConstraints {
            $0.top.equalTo(self.mainLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
            $0.height.equalTo(49)
        }
    }
}
