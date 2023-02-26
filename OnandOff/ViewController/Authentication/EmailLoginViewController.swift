//
//  EmailLoginViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/10.
//

import UIKit
import Alamofire

class EmailLoginViewController: UIViewController {
    
    // MARK: - Properties
    var isValid: Bool {
        return emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
    }
    
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
        textField.autocapitalizationType = .none
        textField.widthAnchor.constraint(equalToConstant: 240).isActive = true
        return textField
    }()
    
    private lazy var emailDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .black
        textField.textAlignment = .left
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.widthAnchor.constraint(equalToConstant: 240).isActive = true
        return textField
    }()
    
    private lazy var passwordDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.868, green: 0.868, blue: 0.868, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
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
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        configureLayout()
        textFieldObservers()
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
        guard let email = emailTextField.text else { return }
        if email.isEmpty {
            let alert = StandardAlertController(title: nil, message: "이메일을 입력한 뒤 다시 버튼을 눌려주세요")
            let report = StandardAlertAction(title: "확인", style: .basic)
            alert.addAction(report)
            self.present(alert, animated: false)
        } else {
            let alert = StandardAlertController(title: nil, message: "비밀번호 재설정 이메일이 \n \(email)으로 전송되었습니다")
            let report = StandardAlertAction(title: "확인", style: .basic)
            alert.addAction(report)
            self.present(alert, animated: false)
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if isValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor(red: 0.868, green: 0.868, blue: 0.868, alpha: 1)
        }
    }
    
    // MARK: - Helpers
    private func configureLayout() {
        view.backgroundColor = .white
        
        view.addSubview(emailContainerView)
        emailContainerView.delegate = self
        emailContainerView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.top).offset(145)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
            $0.height.equalTo(40)
        }
        
        view.addSubview(emailDividerView)
        emailDividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(view.snp.top).offset(145)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
        }
        
        view.addSubview(passwordContainerView)
        passwordContainerView.delegate = self
        passwordContainerView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.top).offset(201)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
            $0.height.equalTo(40)
        }
        
        view.addSubview(passwordDividerView)
        passwordDividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(view.snp.top).offset(201)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
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
    
    func textFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

extension EmailLoginViewController: ContainerViewDelegate {
    func resetTextField(_ view: UIView) {
        if view == emailContainerView {
            emailTextField.text = nil
        } else if view == passwordContainerView {
            passwordTextField.text = nil
        }
    }
}
