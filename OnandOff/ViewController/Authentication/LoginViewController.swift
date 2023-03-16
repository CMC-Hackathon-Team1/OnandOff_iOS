//
//  LoginViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//


import UIKit
import SnapKit
import Alamofire
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import AuthenticationServices
import GoogleSignIn

final class LoginViewController: UIViewController {
    // MARK: - Properties
    private let backgroundImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "Login")
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "세상에 없던 멀티 자아 기록 플랫폼"
        $0.numberOfLines = 3
        $0.textColor = .white
        $0.font = .notoSans(size: 40, family: .Bold)
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "OnOff")
    }
    
    private lazy var loginButton = UIButton(type: .system).then {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .mainColor
        configuration.image = UIImage(named: "OnandOffIcon")?.withRenderingMode(.alwaysOriginal)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 80
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 90)
        configuration.title = "On&Off로그인"
        $0.configuration = configuration
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    }
    
    private lazy var kakaoLoginButton = UIButton(type: .system).then {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .black
        configuration.image = UIImage(named: "KakaoIcon")?.withRenderingMode(.alwaysOriginal)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 80
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 90)
        configuration.title = "카카오 로그인"
        $0.configuration = configuration
        $0.backgroundColor = #colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.addTarget(self, action: #selector(didTapKakaoLoginButton), for: .touchUpInside)
    }
    
    private lazy var appleLoginButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .white
        configuration.image = UIImage(named: "AppleIcon")?.withRenderingMode(.alwaysOriginal)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 80
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 90)
        configuration.title = "Apple 로그인"
        $0.configuration = configuration
        $0.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
    }
    
    private lazy var googleLoginButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .black
        configuration.image = UIImage(named: "GoogleIcon")?.withRenderingMode(.alwaysOriginal)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 50
        configuration.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 40)
        configuration.title = "Google 계정으로 로그인"
        $0.configuration = configuration
        $0.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.addTarget(self, action: #selector(didTapGoogleLoginButton), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Actions
    @objc func handleShowLogin() {
        let controller = EmailLoginViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func didTapKakaoLoginButton() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk() {(oauthToken, error) in
                
                guard let oauthToken else { print(error!); return }
                
                AuthService.kakaoLogin(oauthToken.accessToken) { res in
                    switch res?.statusCode {
                    case 100:
                        guard let result = res?.result,
                              let jwt = result.jwt else { return }
                        TokenService().create("https://dev.onnoff.shop/auth/login", account: "accessToken", value: jwt)
                        self.dismiss(animated: true)
                    case 400: print("body오류")
                    case 500: self.showAlert(title: "이메일 정보를 포함해주세요.")
                    case 1012: self.showAlert(title: "카카오 인증 정보가 유효하지 않습니다.\n다시 시도해주세요.")
                    case 1102: self.showAlert(title: "다른 플랫폼으로 가입된 회원입니다.")
                    default:
                        print("기타 오류")
                    }
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount() {(oauthToken, error) in
                guard let oauthToken else { print(error!); return }
                AuthService.kakaoLogin(oauthToken.accessToken) { res in
                    switch res?.statusCode {
                    case 100:
                        guard let result = res?.result,
                              let jwt = result.jwt else { return }
                        TokenService().create("https://dev.onnoff.shop/auth/login", account: "accessToken", value: jwt)
                        self.dismiss(animated: true)
                    case 400: print("body오류")
                    case 500: self.showAlert(title: "이메일 정보를 포함해주세요.")
                    case 1012: self.showAlert(title: "카카오 인증 정보가 유효하지 않습니다.\n다시 시도해주세요.")
                    case 1102: self.showAlert(title: "다른 플랫폼으로 가입된 회원입니다.")
                    default:
                        print("기타 오류")
                    }
                }
            }
        }
    }
    
    @objc func didTapAppleLoginButton() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }

    @objc func didTapGoogleLoginButton() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult,
            let idToken = signInResult.user.idToken?.tokenString else { return }
            AuthService.googleLogin(idToken) { res in
                switch res?.statusCode {
                case 100:
                    guard let result = res?.result,
                          let jwt = result.jwt else { return }
                    TokenService().create("https://dev.onnoff.shop/auth/login", account: "accessToken", value: jwt)
                    self.dismiss(animated: true)
                case 400: print("body오류")
                case 500: self.showAlert(title: "이메일 정보를 포함해주세요.")
                case 1012: self.showAlert(title: "카카오 인증 정보가 유효하지 않습니다.\n다시 시도해주세요.")
                case 1102: self.showAlert(title: "다른 플랫폼으로 가입된 회원입니다.")
                default:
                    print("기타 오류")
                }
            }
        }
    }
    
    private func showAlert(title: String) {
        let alert = StandardAlertController(title: title, message: nil)
        let ok = StandardAlertAction(title: "확인", style: .basic)
        alert.addAction(ok)
        
        self.present(alert, animated: false)
    }

    // MARK: - Helpers
    func configureUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(90)
            $0.left.equalTo(view.snp.left).offset(40)
            $0.width.equalTo(192)
            $0.height.equalTo(180)
        }
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(313)
            $0.left.equalTo(view.snp.left).offset(40)
            $0.width.equalTo(189)
            $0.height.equalTo(49)
        }
        
        let stackView = UIStackView(arrangedSubviews: [loginButton, kakaoLoginButton, appleLoginButton, googleLoginButton]).then {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 15
            self.view.addSubview($0)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(582)
            $0.left.equalTo(view.snp.left).offset(20)
            $0.right.equalTo(view.snp.right).offset(-20)
            $0.bottom.equalTo(view.snp.top).offset(800)
        }
    }
}

// MARK: - AppleLogin
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let idToken = credential.identityToken,
                  let tokenStr = String(data: idToken, encoding: .utf8) else { return }
            AuthService.appleLogin(tokenStr) { res in
                switch res?.statusCode {
                case 100:
                    guard let result = res?.result,
                          let jwt = result.jwt else { return }
                    TokenService().create("https://dev.onnoff.shop/auth/login", account: "accessToken", value: jwt)
                    self.dismiss(animated: true)
                case 400: print("body오류")
                case 500: self.showAlert(title: "이메일 정보를 포함해주세요.")
                case 1012: self.showAlert(title: "카카오 인증 정보가 유효하지 않습니다.\n다시 시도해주세요.")
                case 1102: self.showAlert(title: "다른 플랫폼으로 가입된 회원입니다.")
                default:
                    print("기타 오류")
                }
            }
        }
    }

    // 실패 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}
