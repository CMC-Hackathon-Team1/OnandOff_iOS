//
//  RegisterationController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/10.
//

import UIKit

class RegisterationController: UIViewController {
    
    // MARK: - Properties
    var formIsValid: Bool {
        return passwordTextField.text == passwordCheckDescriptionLabel.text
    }
    
    private lazy var emailContainerView: ContainerView = {
        return ContainerView(title: "이메일", textField: emailTextField, leftOffset: 79)
    }()
    
    private lazy var passwordContainerView: ContainerView = {
        return ContainerView(title: "비밀번호", textField: passwordTextField, leftOffset: 79)
    }()
    
    private lazy var passwordCheckContainerView: ContainerView = {
        return ContainerView(title: "비밀번호 확인", textField: passwordCheckTextField, leftOffset: 79)
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "이메일"
        textField.textColor = .black
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "비밀번호"
        textField.textColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "비밀번호 확인"
        textField.textColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let emailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호를 받기 위해 정확한 이메일 주소를 입력해주세요."
        label.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return label
    }()
    
    private let passwordDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "영문, 숫자, 특수문자 포함 8글자 이상"
        label.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return label
    }()
    
    private let passwordCheckDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "영문, 숫자, 특수문자 포함 8글자 이상"
        label.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.345, green: 0.721, blue: 0.631, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        // button.isEnabled = formIsValid ? true : false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        configureLayout()
    }
    
    // MARK: - Actions
    @objc func handleShowSignUp() {
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleRegister() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.userRegister(AuthDataModel(email: email, password: password)) { response in
            if let response = response {
                switch response.statusCode {
                case 100:
                    self.navigationController?.popToRootViewController(animated: true)
                case 400:
                    print(response.message)
                case 500:
                    print(response.message)
                case 1101:
                    print(response.message)
                default:
                    break
                }
            }
            return
        }
    }
    
    // MARK: - Helpers
    private func configureLayout() {
        view.backgroundColor = .white
        
        view.addSubview(emailContainerView)
        emailContainerView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.top).offset(142)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
            $0.height.equalTo(40)
        }
        
        view.addSubview(emailDescriptionLabel)
        emailDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(emailContainerView.snp.bottom).offset(6)
            $0.left.equalTo(view.snp.left).offset(31)
        }
        
        view.addSubview(passwordContainerView)
        passwordContainerView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.top).offset(198)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
            $0.height.equalTo(40)
        }
        
        view.addSubview(passwordDescriptionLabel)
        passwordDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(passwordContainerView.snp.bottom).offset(6)
            $0.left.equalTo(view.snp.left).offset(31)
        }
        
        view.addSubview(passwordCheckContainerView)
        passwordCheckContainerView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.top).offset(257)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
            $0.height.equalTo(40)
        }
        
        view.addSubview(passwordCheckDescriptionLabel)
        passwordCheckDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(passwordCheckContainerView.snp.bottom).offset(6)
            $0.left.equalTo(view.snp.left).offset(31)
        }
        
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints {
            $0.left.equalTo(view.snp.left).offset(34)
            $0.right.equalTo(view.snp.right).offset(-34)
            $0.top.equalTo(view.snp.top).offset(320)
            $0.height.equalTo(49)
        }
    }
}
