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
        return self.emailTextFieldView.getText?.isEmpty == false && self.passwordTextFieldView.getText?.isEmpty == false && self.passwordCheckTextFieldView.getText?.isEmpty == false
    }
    private let emailTextFieldView = UnderLineTextField(.other, title: "이메일 ", guide: "인증번호를 받기 위해 정확한 이메일 주소를 입력해주세요.")
    
    private let passwordTextFieldView = UnderLineTextField(.password, title: "패스워드     ", guide: "영문, 숫자, 특수문자 포함 8글자 이상")
    
    private let passwordCheckTextFieldView = UnderLineTextField(.password, title: "패스워드 확인", guide: "영문, 숫자, 특수문자 포함 8글자 이상")
    
    private lazy var signUpButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .text3
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        $0.isEnabled = false
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.addSubView()
        self.configureLayout()
    }
    
    // MARK: - Actions
    @objc func handleShowSignUp() {
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleRegister() {
        guard let email = emailTextFieldView.getText else { return }
        guard let password = passwordTextFieldView.getText else { return }
        
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
        guard let email = emailTextFieldView.getText else { return }
        guard let password = passwordTextFieldView.getText else { return }
        guard let passwordCheck = passwordCheckTextFieldView.getText else { return }
        
//        switch sender {
//        case emailTextField:
//            if email.checkEmailForm() {
//                emailDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
//                emailDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
//                emailDescriptionLabel.text = "인증번호를 받기 위해 정확한 이메일 주소를 입력해주세요."
//            } else if email.isEmpty {
//                emailDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
//                emailDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
//                emailDescriptionLabel.text = "인증번호를 받기 위해 정확한 이메일 주소를 입력해주세요."
//            } else {
//                emailDividerView.backgroundColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
//                emailDescriptionLabel.text = "잘못된 이메일 입니다."
//                emailDescriptionLabel.textColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
//            }
//        case passwordTextField:
//            if password.checkPasswordForm() {
//                passwordDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
//                passwordDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
//                passwordDescriptionLabel.text = "영문, 숫자, 특수문자 포함 8글자 이상"
//            } else if password.isEmpty {
//                passwordDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
//                passwordDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
//                passwordDescriptionLabel.text = "영문, 숫자, 특수문자 포함 8글자 이상"
//            } else {
//                passwordDividerView.backgroundColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
//                passwordDescriptionLabel.text = "잘못된 입력입니다. (영문, 숫자, 특수문자 포함 8글자 이상)"
//                passwordDescriptionLabel.textColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
//            }
//        case passwordCheckTextField:
//            if password == passwordCheck ||
//                passwordCheck.isEmpty ||
//                password.isEmpty && passwordCheck.isEmpty {
//                passwordCheckDividerView.backgroundColor = #colorLiteral(red: 0.5215686275, green: 0.5215686275, blue: 0.5215686275, alpha: 1)
//                passwordCheckDescriptionLabel.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
//                passwordCheckDescriptionLabel.text = "영문, 숫자, 특수문자 포함 8글자 이상"
//            } else {
//                passwordCheckDividerView.backgroundColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
//                passwordCheckDescriptionLabel.text = "위의 비밀번호와 다릅니다."
//                passwordCheckDescriptionLabel.textColor = #colorLiteral(red: 1, green: 0.4039215686, blue: 0.4039215686, alpha: 1)
//            }
//        default:
//            print("Error")
//        }
    }
    
    //MARK: - AddSubView()
    private func addSubView() {
        self.view.addSubview(self.emailTextFieldView)
        self.view.addSubview(self.passwordTextFieldView)
        self.view.addSubview(self.passwordCheckTextFieldView)
        self.view.addSubview(self.signUpButton)
    }
    
    // MARK: - Helpers
    private func configureLayout() {
        view.backgroundColor = .white
        
        self.emailTextFieldView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(40)
        }
        
        self.passwordTextFieldView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(40)
            $0.top.equalTo(self.emailTextFieldView.snp.bottom).offset(18)
        }
        
        self.passwordCheckTextFieldView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(40)
            $0.top.equalTo(self.passwordTextFieldView.snp.bottom).offset(18)
        }
        
        self.signUpButton.snp.makeConstraints {
            $0.left.equalTo(view.snp.left).offset(34)
            $0.right.equalTo(view.snp.right).offset(-34)
            $0.top.equalTo(view.snp.top).offset(320)
            $0.height.equalTo(49)
        }
    }
}

extension RegisterationController: UnderLineTextFieldDelegate {
    func didChangeText(_ textfield: UITextField) {
        if self.isValid {
            self.signUpButton.isEnabled = true
            self.signUpButton.backgroundColor = #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)
        } else {
            self.signUpButton.isEnabled = false
            self.signUpButton.backgroundColor = .text3
        }
    }
}
