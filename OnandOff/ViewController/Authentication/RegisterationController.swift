//
//  RegisterationController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/10.
//

import UIKit

class RegisterationController: UIViewController {
    
    // MARK: - Properties
    var isValid: Bool {
        return emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false && passwordCheckTextField.text?.isEmpty == false
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
        // textField.placeholder = "이메일"
        textField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        textField.textColor = .black
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
        // textField.placeholder = "비밀번호"
        textField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        textField.textColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var passwordDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
        return view
    }()
    
    private let passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        // textField.placeholder = "비밀번호 확인"
        textField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        textField.textColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var passwordCheckDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
        return view
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
        button.backgroundColor = UIColor(red: 0.868, green: 0.868, blue: 0.868, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        textFieldObservers()
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
    
    @objc func textDidChange(sender: UITextField) {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let passwordCheck = passwordCheckTextField.text else { return }
        
        if isValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(red: 0.868, green: 0.868, blue: 0.868, alpha: 1)
        }
        
        switch sender {
        case emailTextField:
            if email.checkEmailForm() {
                emailDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
                emailDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
                emailDescriptionLabel.text = "인증번호를 받기 위해 정확한 이메일 주소를 입력해주세요."
            } else if email.isEmpty {
                emailDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
                emailDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
                emailDescriptionLabel.text = "인증번호를 받기 위해 정확한 이메일 주소를 입력해주세요."
            } else {
                emailDividerView.backgroundColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
                emailDescriptionLabel.text = "잘못된 이메일 입니다."
                emailDescriptionLabel.textColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
            }
        case passwordTextField:
            if password.checkPasswordForm() {
                passwordDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
                passwordDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
                passwordDescriptionLabel.text = "영문, 숫자, 특수문자 포함 8글자 이상"
            } else if password.isEmpty {
                passwordDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
                passwordDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
                passwordDescriptionLabel.text = "영문, 숫자, 특수문자 포함 8글자 이상"
            } else {
                passwordDividerView.backgroundColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
                passwordDescriptionLabel.text = "잘못된 입력입니다. (영문, 숫자, 특수문자 포함 8글자 이상)"
                passwordDescriptionLabel.textColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
            }
        case passwordCheckTextField:
            if password == passwordCheck ||
                passwordCheck.isEmpty ||
                password.isEmpty && passwordCheck.isEmpty {
                passwordCheckDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
                passwordCheckDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
                passwordCheckDescriptionLabel.text = "영문, 숫자, 특수문자 포함 8글자 이상"
            } else {
                passwordCheckDividerView.backgroundColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
                passwordCheckDescriptionLabel.text = "위의 비밀번호와 다릅니다."
                passwordCheckDescriptionLabel.textColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
            }
        default:
            print("Error")
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
        
        
        view.addSubview(emailDescriptionLabel)
        emailDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(emailContainerView.snp.bottom).offset(6)
            $0.left.equalTo(view.snp.left).offset(31)
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
        
        view.addSubview(passwordDescriptionLabel)
        passwordDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(passwordContainerView.snp.bottom).offset(6)
            $0.left.equalTo(view.snp.left).offset(31)
        }
        
        view.addSubview(passwordCheckContainerView)
        passwordCheckContainerView.delegate = self
        passwordCheckContainerView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.top).offset(258)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
            $0.height.equalTo(40)
        }
        
        view.addSubview(passwordCheckDividerView)
        passwordCheckDividerView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(view.snp.top).offset(258)
            $0.left.equalTo(view.snp.left).offset(31)
            $0.right.equalTo(view.snp.right).offset(-31)
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
    
    func textFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordCheckTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

extension RegisterationController: ContainerViewDelegate {
    func resetTextField(_ view: UIView) {
        if view == emailContainerView {
            emailTextField.text = nil
            emailDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
            emailDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
            emailDescriptionLabel.text = "인증번호를 받기 위해 정확한 이메일 주소를 입력해주세요."
        } else if view == passwordContainerView {
            passwordTextField.text = nil
            passwordDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
            passwordDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
            passwordDescriptionLabel.text = "영문, 숫자, 특수문자 포함 8글자 이상"
        } else {
            passwordCheckTextField.text = nil
            passwordCheckDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
            passwordCheckDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
            passwordCheckDescriptionLabel.text = "영문, 숫자, 특수문자 포함 8글자 이상"
        }
    }
}
