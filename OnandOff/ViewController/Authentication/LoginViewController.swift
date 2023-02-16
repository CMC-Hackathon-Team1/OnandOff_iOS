//
//  LoginViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import SnapKit
import UIKit
import Alamofire
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import AuthenticationServices
import GoogleSignIn

class LoginViewController: UIViewController {

    // MARK: - Properties
    // let accessToken: String? = nil
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Login")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "세상에 없던 멀티 자아 기록 플랫폼"
        label.numberOfLines = 3
        label.textColor = .white
        label.font = .notoSans(size: 40, family: .Bold)
        return label
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "OnOff")
        return imageView
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .notoSans(size: 18, family: .Bold)
        button.tintColor = .black
        button.setTitleColor(#colorLiteral(red: 0.3450980392, green: 0.7215686275, blue: 0.631372549, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오 로그인", for: .normal)
        // button.setImage(#imageLiteral(resourceName: "Kakao"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.semanticContentAttribute = .forceLeftToRight
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 150)
        button.titleLabel?.font = .notoSans(size: 18, family: .Bold)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9983025193, green: 0.9065476656, blue: 0, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(didTapKakaoLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple 로그인", for: .normal)
        button.titleLabel?.font = .notoSans(size: 18, family: .Bold)
        button.tintColor = .black
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Google 계정으로 로그인", for: .normal)
        button.titleLabel?.font = .notoSans(size: 18, family: .Bold)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(didTapGoogleLoginButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 카카오 로그인 유효 토큰 검사
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        // 로그인 필요
                    }
                    else {
                        // 기타 에러
                    }
                }
                else {
                    // 토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    
                    // 사용자 정보를 가져오고 화면전환을 하는 커스텀 메서드
                    self.moveToHomeVC()
                }
            }
        }
        else {
            // 로그인 필요
        }
    }
    
    // MARK: - Actions
    @objc func handleShowLogin() {
        print(#function)
        let controller = EmailLoginViewController()
        print(controller)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func didTapKakaoLoginButton() {
        print(#function)
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    if let accessToken = oauthToken?.accessToken {
                        print(accessToken)
                        AuthService.kakaoLogin(KakaoDataModel(access_token: accessToken)) { response in
                            if let response = response {
                                switch response.statusCode {
                                case 100:
                                    guard let accessToken = response.result?.jwt else { return }
                                    let tokenService = TokenService()
                                    tokenService.create("https://dev.onnoff.shop/auth/login", account: "accessToken", value: accessToken)
                                    print("KakaoLogin Complete, AccessToken is \(TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken") ?? "")")
                                    self.dismiss(animated: true)
                                    
                                case 400:
                                    print(response.message)
                                case 500:
                                    print(response.message)
                                case 1012:
                                    print(response.message)
                                case 1013:
                                    print(response.message)
                                case 1014:
                                    print(response.message)
                                case 1102:
                                    print(response.message)
                                default:
                                    break
                                }
                            }
                            return
                        }
                    }
                  
                    
                    // 사용자정보를 성공적으로 가져오면 화면전환 한다.
                    self.moveToHomeVC()
                }
            }
        }
        //  카카오톡 미설치
        else {
            print("카카오톡 미설치")
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    if let accessToken = oauthToken?.accessToken {
                        print("AccessToken: \(accessToken)")
                        AuthService.kakaoLogin(KakaoDataModel(access_token: accessToken)) { response in
                            if let response = response {
                                switch response.statusCode {
                                case 100:
                                    guard let accessToken = response.result?.jwt else { return }
                                    let tokenService = TokenService()
                                    tokenService.create("https://dev.onnoff.shop/auth/login", account: "accessToken", value: accessToken)
                                    print("KakaoLogin Complete, AccessToken is \(TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken") ?? "")")
                                    self.dismiss(animated: true)
                                    
                                case 400:
                                    print(response.message)
                                case 500:
                                    print(response.message)
                                case 1012:
                                    print(response.message)
                                case 1013:
                                    print(response.message)
                                case 1014:
                                    print(response.message)
                                case 1102:
                                    print(response.message)
                                default:
                                    break
                                }
                            }
                            return
                        }
                    }
                    // 사용자정보를 성공적으로 가져오면 화면전환 한다.
                    self.moveToHomeVC()
                }
            }
        }
    }
    
    @objc func didTapAppleLoginButton() {
        print(#function)
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self as? ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }

    
    @objc func didTapGoogleLoginButton() {
        print(#function)

        let googleClientId = "237346784269-d5qkltgq5i6ccfn9fia49d52slp63180.apps.googleusercontent.com"
        let signInConfig = GIDConfiguration.init(clientID: googleClientId)
        
        let accessToken = GIDSignIn.sharedInstance.currentUser?.accessToken
        let userId = GIDSignIn.sharedInstance.currentUser?.userID
        if accessToken == nil {
            
            GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let userId = signInResult?.user.userID
                    let accessToken = signInResult?.user.accessToken
                    print("userID: ", userId)
                    print("accessToken: ", accessToken)
                }
            }
        }
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
        
        let stackView = UIStackView(arrangedSubviews: [loginButton, kakaoLoginButton, appleLoginButton, googleLoginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(582)
            $0.left.equalTo(view.snp.left).offset(20)
            $0.right.equalTo(view.snp.right).offset(-20)
        }
    }
}

// MARK: - KaKaoOAuth
extension LoginViewController {
    // 로그인 성공 -> 화면 전환
    private func moveToHomeVC() {

        // 사용자 정보 가져오기
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")

                // 닉네임, 이메일 정보
                // let nickname = user?.kakaoAccount?.profile?.nickname
                // let email = user?.kakaoAccount?.email

                // 화면전환
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// MARK: - AppleLogin
extension LoginViewController: ASAuthorizationControllerDelegate {
    // 성공 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {

            let idToken = credential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
            print(tokeStr)

            guard let code = credential.authorizationCode else { return }
            let codeStr = String(data: code, encoding: .utf8)
            print(codeStr)

            let user = credential.user
            print(user)

        }
    }

    // 실패 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error")
    }
}
