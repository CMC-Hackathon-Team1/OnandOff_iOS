//
//  LoginViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import SnapKit
import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class LoginViewController: UIViewController {

    // MARK: - Properties
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
        return button
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오 로그인", for: .normal)
        button.titleLabel?.font = .notoSans(size: 18, family: .Bold)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapkakaoLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var appleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("애플 로그인", for: .normal)
        button.titleLabel?.font = .notoSans(size: 18, family: .Bold)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var googleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("구글 로그인", for: .normal)
        button.titleLabel?.font = .notoSans(size: 18, family: .Bold)
        button.tintColor = .black
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 유효한 토큰 검사
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
    @objc func handleLogin() {
        print(#function)
    }
    
    @objc func didTapkakaoLoginButton() {
        print(#function)
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")

                    // 회원가입 성공 시 oauthToken 저장가능하다
                    // _ = oauthToken

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

                    // 회원가입 성공 시 oauthToken 저장
                    // _ = oauthToken

                    // 사용자정보를 성공적으로 가져오면 화면전환 한다.
                    self.moveToHomeVC()
                }
            }
        }
    }
    
    @objc func didTapappleLoginButton() {
        print(#function)
    }
    
    @objc func didTapgoogleLoginButton() {
        print(#function)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(174)
            $0.left.equalTo(view.snp.left).offset(42)
            $0.width.equalTo(192)
            $0.height.equalTo(180)
        }
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(459)
            $0.left.equalTo(view.snp.left).offset(42)
            $0.width.equalTo(189)
            $0.height.equalTo(49)
        }
        
        view.addSubview(loginButton)
        // CornerRadius 확인 후 수정 예정
        loginButton.layer.cornerRadius = 20
        loginButton.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.snp.top).offset(555)
            $0.width.equalTo(335)
            $0.height.equalTo(54)
        }
        
        let stackView = UIStackView(arrangedSubviews: [kakaoLoginButton, appleLoginButton, googleLoginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(31)
            $0.left.equalTo(view.snp.left).offset(18)
            $0.right.equalTo(view.snp.right).offset(-18)
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
                // self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
