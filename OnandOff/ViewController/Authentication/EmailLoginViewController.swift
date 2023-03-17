//
//  EmailLoginViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/10.
//

import UIKit
import Alamofire

final class EmailLoginViewController: UIViewController {
    // MARK: - Properties
    var isValid: Bool {
        return self.emailTextfileView.getText?.isEmpty == false && self.passwordTextFieldView.getText?.isEmpty == false
    }
    
    private let emailTextfileView = UnderLineTextField(.other, title: "이메일   ", identifier: "email")
    
    private let passwordTextFieldView = UnderLineTextField(.password, title: "패스워드", identifier: "password")

    private lazy var loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .text3
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(self.didClickLoginButton), for: .touchUpInside)
        $0.isEnabled = false
    }
    
    private lazy var findPasswordButton = UIButton().then {
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(handleFindPassword), for: .touchUpInside)
        let attributedTitle = NSMutableAttributedString(string: "비밀번호 찾기", attributes: [.font: UIFont.notoSans(size: 12, family: .Bold),
                                                                                           .foregroundColor: #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1),
                                                                                           NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                                                                           .underlineColor: #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)])
        $0.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    private lazy var registerationButton = UIButton(type: .system).then {
        $0.backgroundColor = .white
        $0.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        let title = "아직 아이디가 없다면? 회원가입"
        let attributedTitle = NSMutableAttributedString(string: title,
                                                        attributes: [.font: UIFont.notoSans(size: 12, family: .Bold),
                                                                     .foregroundColor: #colorLiteral(red: 0.7810429931, green: 0.7810428739, blue: 0.7810428739, alpha: 1),
                                                                     NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                                                     .underlineColor: #colorLiteral(red: 0.7810429931, green: 0.7810428739, blue: 0.7810428739, alpha: 1)])
        attributedTitle.addAttribute(.foregroundColor, value: UIColor.mainColor, range: (title as NSString).range(of: "회원가입"))
        $0.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "로그인 하기"

        self.addSubView()
        self.configureLayout()
        
        self.emailTextfileView.delegate = self
        self.passwordTextFieldView.delegate = self
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationItem.backButtonTitle = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Actions
    @objc func handleShowSignUp() {
        print(#function)
        let registVC = RegisterationController()
        self.navigationController?.pushViewController(registVC, animated: true)
    }
    
    @objc func didClickLoginButton() {
        guard let email = self.emailTextfileView.getText else { return }
        guard let password = self.passwordTextFieldView.getText else { return }
        
        AuthService.userLogin(email: email, password: password) { response in
            if let response = response {
                switch response.statusCode {
                case 100:
                    guard let accessToken = response.result?.jwt else { return }
                    
                    TokenService().create("https://dev.onnoff.shop/auth/login", account: "accessToken", value: accessToken)
                    self.navigationController?.dismiss(animated: true)
                case 400:
                    print(response.message)
                case 500:
                    print(response.message)
                case 1101:
                    self.showAlert(title: "잘못된 회원정보 입니다.")
                case 3011:
                    self.showAlert(title: "다른 플랫폼으로 가입된 회원입니다.")
                default:
                    break
                }
            }
        }
    }
    
    @objc func handleFindPassword() {
        self.defaultAlert(title: "비밀번호 재설정은\nhackathonerss@gmail.com으로 문의해주세요.")
    }
    
    private func showAlert(title: String) {
        let alert = StandardAlertController(title: title, message: nil)
        let ok = StandardAlertAction(title: "확인", style: .basic)
        alert.addAction(ok)
        
        self.present(alert, animated: false)
    }

    //MARK: - AddSubView()
    private func addSubView() {
        self.view.addSubview(self.emailTextfileView)
        self.view.addSubview(self.passwordTextFieldView)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.findPasswordButton)
        self.view.addSubview(self.registerationButton)
    }
    
    // MARK: - Helpers
    private func configureLayout() {
        view.backgroundColor = .white

        self.emailTextfileView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(40)
        }
        
        self.passwordTextFieldView.snp.makeConstraints {
            $0.top.equalTo(self.emailTextfileView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(40)
        }
        
        self.loginButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
            $0.top.equalTo(self.passwordTextFieldView.snp.bottom).offset(50)
            $0.height.equalTo(49)
        }
        
        self.findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(self.loginButton.snp.bottom).offset(10)
            $0.leading.equalTo(self.loginButton.snp.leading).offset(36)
            $0.width.equalTo(67)
            $0.height.equalTo(18)
        }
        
        self.registerationButton.snp.makeConstraints {
            $0.top.equalTo(self.loginButton.snp.bottom).offset(10)
            $0.leading.equalTo(self.findPasswordButton.snp.trailing).offset(20)
            $0.width.equalTo(152)
            $0.height.equalTo(18)
        }
    }
}

extension EmailLoginViewController: UnderLineTextFieldDelegate {
    func didChangeText(_ textfield: UITextField, identifier: String) {
        if self.isValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .text3
        }
    }
}
