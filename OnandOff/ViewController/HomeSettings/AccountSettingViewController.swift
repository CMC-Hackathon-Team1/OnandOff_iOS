//
//  SettingViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//

import Foundation
import UIKit

final class AccountSettingViewController: UIViewController{
    //MARK: - Properties
    private let emailFrameView = UIView().then{
        $0.backgroundColor = .systemGray6
    }
    
    private let emailLabelTitle = UILabel().then{
        $0.text = "연동된 이메일"
        $0.font = UIFont(name:"NotoSans-Regular", size: 14)
    }
    
    private let userEmail = UILabel().then{
        $0.text = "hackathonerss@gmail.com"
        $0.font = UIFont(name:"NotoSans-Bold", size: 14)
    }
    
    private let resetPasswordImage = UIImageView().then{
        $0.image = UIImage(named: "Password")?.withRenderingMode(.alwaysOriginal)
    }
    
    private let resetPasswordLabel = UILabel().then{
        $0.text = "비밀번호 재설정"
        $0.font = .notoSans(size: 14)
    }
    
    private let line1 = UIView().then{
        $0.backgroundColor = UIColor.systemGray4
    }
    
    private let withdrawalImage = UIImageView().then{
        $0.image = UIImage(named: "SmileySad")?.withRenderingMode(.alwaysOriginal)
    }
    
    private let withdrawalLabel = UILabel().then{
        $0.text = "회원 탈퇴"
        $0.font = .notoSans(size: 14)
        $0.textColor = .red
    }
    
    private let line2 = UIView().then{
        $0.backgroundColor = UIColor.systemGray4
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        self.setUpView()
        self.layout()
        self.addTarget()
        
        AuthService.getUserEmail() { item in
            if let item {
                self.userEmail.text = item.email
            } else {
                self.userEmail.text = "이메일 정보 불러올 수 없음"
            }
        }
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "계정"
    }
    
    //MARK: - AddSubview
    private func setUpView(){
        self.view.addSubview(self.emailFrameView)
        self.view.addSubview(self.resetPasswordImage)
        self.view.addSubview(self.resetPasswordLabel)
        self.view.addSubview(self.line1)
        self.view.addSubview(self.withdrawalImage)
        self.view.addSubview(self.withdrawalLabel)
        self.view.addSubview(self.line2)
        
        self.emailFrameView.addSubview(self.emailLabelTitle)
        self.emailFrameView.addSubview(self.userEmail)
    }
    
    //MARK: - Selector
    @objc func didClickPasswordReset(sender: UITapGestureRecognizer){
        self.defaultAlert(title: "비밀번호 재설정은\nhackathonerss@gmail.com으로 문의해주세요.")
    }
    
    @objc func didClickAccountDelete(sender: UITapGestureRecognizer){
        let alert = StandardAlertController(title: "계정을 정말로 삭제하시겠습니까?", message: nil)
        alert.titleHighlight(highlightString: "삭제", color: .point)
        let cancel = StandardAlertAction(title: "취소", style: .cancel)
        let delete = StandardAlertAction(title: "삭제", style: .basic) { _ in
            AuthService.withdrawalMember() { isSuccess in
                if isSuccess {
                    TokenService().delete("https://dev.onnoff.shop/auth/login", account: "accessToken")
                    self.navigationController?.popToRootViewController(animated: false)
                } else {
                    self.defaultAlert(title: "계정삭제에 실패하였습니다.\nhackathonerss@gmail.com으로 문의해주세요.")
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(delete)
        
        self.present(alert, animated: false)
    }
    
    @objc func didClickBackButton(sender: UITapGestureRecognizer){
        dismiss(animated: true)
    }
    
    
    //MARK: - Layout
    private func layout(){
        self.emailFrameView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(110)
        }
        self.emailLabelTitle.snp.makeConstraints{
            $0.top.equalToSuperview().offset(27)
            $0.leading.equalToSuperview().offset(31)
        }
        self.userEmail.snp.makeConstraints{
            $0.top.equalTo(self.emailLabelTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(31)
        }
        self.resetPasswordImage.snp.makeConstraints{
            $0.top.equalTo(self.emailFrameView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(35.75)
            $0.width.height.equalTo(25)
        }
        self.resetPasswordLabel.snp.makeConstraints{
            $0.top.equalTo(self.emailFrameView.snp.bottom).offset(25)
            $0.leading.equalTo(resetPasswordImage.snp.trailing).offset(20.75)
            $0.trailing.equalToSuperview()
        }
        self.line1.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
            $0.height.equalTo(1)
            $0.top.equalTo(self.resetPasswordLabel.snp.bottom).offset(20)
        }
        self.withdrawalImage.snp.makeConstraints{
            $0.top.equalTo(self.line1.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(35.75)
            $0.width.height.equalTo(25)
        }
        self.withdrawalLabel.snp.makeConstraints{
            $0.top.equalTo(self.line1.snp.bottom).offset(20)
            $0.leading.equalTo(withdrawalImage.snp.trailing).offset(20.75)
            $0.trailing.equalToSuperview()
        }
        self.line2.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
            $0.height.equalTo(1)
            $0.top.equalTo(self.withdrawalLabel.snp.bottom).offset(20)
        }
    }
    
    //MARK: - Target
    func addTarget(){
        let passwordResetBtn = UITapGestureRecognizer(target: self, action: #selector(didClickPasswordReset))
        resetPasswordLabel.isUserInteractionEnabled = true
        resetPasswordLabel.addGestureRecognizer(passwordResetBtn)
        
        let accountDeleteBtn = UITapGestureRecognizer(target: self, action: #selector(didClickAccountDelete))
        withdrawalLabel.isUserInteractionEnabled = true
        withdrawalLabel.addGestureRecognizer(accountDeleteBtn)
    }
}

