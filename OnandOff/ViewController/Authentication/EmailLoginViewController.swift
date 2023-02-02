//
//  EmailLoginViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/01/30.
//

import UIKit
import Alamofire

class EmailLoginViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var emailContainerView: ContainerView = {
        return ContainerView(title: "이메일", textField: emailTextField, leftOffset: 62)
    }()
    
    private lazy var passwordContainerView: ContainerView = {
        return ContainerView(title: "비밀번호", textField: passwordTextField, leftOffset: 62)
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .black
        textField.textAlignment = .left
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.345, green: 0.721, blue: 0.631, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var findPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        let attributedTitle = NSMutableAttributedString(string: "비밀번호 찾기", attributes: [.font: UIFont.notoSans(size: 12, family: .Bold),
                                                                                           .foregroundColor: #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1),
                                                                                           NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                                                                           .underlineColor: #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleFindPassword), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        
        
        let attributedTitle = NSMutableAttributedString(string: "아직 아이디가 없다면? ",
                                                        attributes: [.font: UIFont.notoSans(size: 12, family: .Bold),
                                                                     .foregroundColor: #colorLiteral(red: 0.7810429931, green: 0.7810428739, blue: 0.7810428739, alpha: 1),
                                                                     NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                                                     .underlineColor: #colorLiteral(red: 0.7810429931, green: 0.7810428739, blue: 0.7810428739, alpha: 1)])
        
        attributedTitle.append(NSAttributedString(string: "회원가입",
                                                  attributes: [.font: UIFont.notoSans(size: 12, family: .Bold),
                                                               .foregroundColor: #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1),
                                                               NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                                                               .underlineColor: #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "로그인 하기"
        self.navigationController?.navigationBar.topItem?.title = ""
        configureLayout()
    }
    
    // MARK: - Actions
    @objc func handleShowSignUp() {
        print(#function)
        let controller = RegisterationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogin() {
        guard let email = self.emailTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        
        AuthService.userLogin(AuthDataModel(email: email, password: password)) { response in
            if let response = response {
                switch response.statusCode {
                case 100:
                    guard let accessToken = response.result?.jwt else { return }
                    let tokenService = TokenService()
                    tokenService.create("https://dev.onnoff.shop/auth/login", account: "accessToken", value: accessToken)
                    print("EmailLogin Complete, AccessToken is \(TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken") ?? "")")
                    self.dismiss(animated: true)
                    
                case 400:
                    print(response.message)
                case 500:
                    print(response.message)
                case 1101:
                    print(response.message)
                case 3011:
                    print(response.message)
                default:
                    break
                }
            }
            return
        }
    }
    
    @objc func handleFindPassword() {
        print(#function)
    }
    
    // MARK: - Helpers
    private func configureLayout() {
        view.backgroundColor = .white
        
        view.addSubview(emailContainerView)
        emailContainerView.delegate = self
        emailContainerView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.top).offset(142)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
            $0.height.equalTo(40)
        }
        
        view.addSubview(passwordContainerView)
        passwordContainerView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.top).offset(198)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
            $0.height.equalTo(40)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.left.equalTo(view.snp.left).offset(34)
            $0.right.equalTo(view.snp.right).offset(-34)
            $0.top.equalTo(view.snp.top).offset(250)
            $0.height.equalTo(49)
        }
        
        view.addSubview(findPasswordButton)
        findPasswordButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.left).offset(70)
            $0.width.equalTo(67)
            $0.height.equalTo(18)
        }
        
        
        view.addSubview(registerationButton)
        registerationButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(10)
            $0.left.equalTo(view.snp.left).offset(168)
            $0.width.equalTo(152)
            $0.height.equalTo(18)
        }
    }
}

extension EmailLoginViewController: ContainerViewDelegate {
    func resetTextField() {
        emailTextField.text = nil
    }
}
