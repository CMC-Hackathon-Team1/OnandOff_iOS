//
//  RegisterationController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/10.
//

import UIKit

final class RegisterationController: UIViewController {
    
    // MARK: - Properties
    var isValid: Bool {
        return self.emailTextFieldView.getText?.isEmpty == false && self.passwordTextFieldView.getText?.isEmpty == false && self.passwordCheckTextFieldView.getText?.isEmpty == false
    }
    private let emailTextFieldView = UnderLineTextField(.other, title: "이메일            ", guide: "인증번호를 받기 위해 정확한 이메일 주소를 입력해주세요.", identifier: "email")
    
    private let passwordTextFieldView = UnderLineTextField(.password, title: "패스워드        ", guide: "영문, 숫자, 특수문자 포함 8글자 이상", identifier: "password")
    
    private let passwordCheckTextFieldView = UnderLineTextField(.password, title: "패스워드 확인", guide: "영문, 숫자, 특수문자 포함 8글자 이상", identifier: "passwordCheck")
    
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
    
        self.addSubView()
        self.configureLayout()
        
        self.emailTextFieldView.delegate = self
        self.passwordTextFieldView.delegate = self
        self.passwordCheckTextFieldView.delegate = self
        
        self.title = "회원가입"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backButtonTitle = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Actions
    @objc func handleRegister() {
        guard let email = emailTextFieldView.getText else { return }
        guard let password = passwordTextFieldView.getText else { return }
        guard let passwordCheck = passwordCheckTextFieldView.getText else { return }
        
        if !email.checkEmailForm() {
            self.emailTextFieldView.warningGuideLabel(content: "잘못된 이메일 형식입니다.")
            return
        }
        
        if !password.checkPasswordForm() {
            self.passwordTextFieldView.warningGuideLabel(content: "잘못된 입력 입니다. (영문, 숫자, 특수문자 포함 8글자 이상)")
            return
        }
        
        if password != passwordCheck {
            self.passwordCheckTextFieldView.warningGuideLabel(content: "위의 비밀번호와 다릅니다.")
            return
        }
        
        AuthService.userRegister(email: email, password: password, level: 0) { response in
            if let response = response {
                switch response.statusCode {
                case 100:
                    let emailCheckVC = EmailAuthViewController(email: email, password: password)
                    self.navigationController?.pushViewController(emailCheckVC, animated: true)
                case 400:
                    print(response.message)
                case 500:
                    print(response.message)
                case 1007:
                    self.showAlert(title: "이메일 전송이 실패하였습니다.")
                case 1100:
                    self.showAlert(title: "이미 가입된 회원입니다.")
                default:
                    break
                }
            }
            return
        }
    }
    
    private func showAlert(title: String) {
        let alert = StandardAlertController(title: title, message: nil)
        let ok = StandardAlertAction(title: "확인", style: .basic)
        alert.addAction(ok)
        
        self.present(alert, animated: false)
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
    func didChangeText(_ textfield: UITextField, identifier: String) {
        if self.isValid {
            self.signUpButton.isEnabled = true
            self.signUpButton.backgroundColor = #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)
        } else {
            self.signUpButton.isEnabled = false
            self.signUpButton.backgroundColor = .text3
        }
        self.emailTextFieldView.resetGuideLabel()
        self.passwordTextFieldView.resetGuideLabel()
        self.passwordCheckTextFieldView.resetGuideLabel()
    }
}
