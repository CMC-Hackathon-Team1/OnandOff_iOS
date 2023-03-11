//
//  SettingViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//

import Foundation
import UIKit
import SnapKit
import Then

class AccountSettingViewController: UIViewController{
    //MARK: - Datasource
    
    
    //MARK: - Properties
    let backButton = UIImageView().then{
        $0.image = UIImage(named: "backbutton")?.withRenderingMode(.alwaysOriginal)
    }
    let settingLabel = UILabel().then{
        $0.text = "계정"
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
    }
    let emailView = UIView().then{
        $0.backgroundColor = .systemGray6
    }
    let emailLabelTitle = UILabel().then{
        $0.text = "연동된 이메일"
        $0.font = UIFont(name:"NotoSans-Regular", size: 14)
    }
    let userEmail = UILabel().then{
        $0.text = "hackathonerss@gmail.com"
        $0.font = UIFont(name:"NotoSans-Bold", size: 14)
    }
    let settingImage1 = UIImageView().then{
        $0.image = UIImage(named: "Password")?.withRenderingMode(.alwaysOriginal)
    }
    let lineTitle1 = UILabel().then{
        $0.text = "비밀번호 재설정"
        $0.font = .notoSans(size: 14)
    }
    let line1 = UIView().then{
        $0.backgroundColor = UIColor.systemGray4
    }
    let settingImage2 = UIImageView().then{
        $0.image = UIImage(named: "SmileySad")?.withRenderingMode(.alwaysOriginal)
    }
    let lineTitle2 = UILabel().then{
        $0.text = "회원 탈퇴"
        $0.font = .notoSans(size: 14)
        $0.textColor = .red
    }
    let line2 = UIView().then{
        $0.backgroundColor = UIColor.systemGray4
    }
    
    
    var settingImageArray = [String]()
    var settingLabelArray = [String]()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setUpView()
        layout()
        addTarget()
        
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = .white

        
    }
    
    //MARK: - AddSubview
    func setUpView(){
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.settingLabel)
        self.view.addSubview(self.emailView)
        self.emailView.addSubview(self.emailLabelTitle)
        self.emailView.addSubview(self.userEmail)
        self.view.addSubview(self.settingImage1)
        self.view.addSubview(self.lineTitle1)
        self.view.addSubview(self.line1)
        self.view.addSubview(self.settingImage2)
        self.view.addSubview(self.lineTitle2)
        self.view.addSubview(self.line2)
    }
    
    //MARK: - Selector
    @objc func didClickPasswordReset(sender: UITapGestureRecognizer){
        let VC = PasswordResetViewController()
        VC.modalPresentationStyle = .overCurrentContext
        present(VC, animated: false)
    }
    @objc func didClickAccountDelete(sender: UITapGestureRecognizer){
        let VC = AccountDeleteViewController()
        VC.modalPresentationStyle = .overCurrentContext
        present(VC, animated: false)
    }
    @objc func didClickBackButton(sender: UITapGestureRecognizer){
        dismiss(animated: true)
    }
    
    
    //MARK: - Layout
    func layout(){
        self.backButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(25.28)
            $0.top.equalToSuperview().offset(55)
            $0.width.equalTo(14)
            $0.height.equalTo(16.22)
        }
        self.settingLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        self.emailView.snp.makeConstraints{
            $0.top.equalTo(self.settingLabel.snp.bottom).offset(15)
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
        self.settingImage1.snp.makeConstraints{
            $0.top.equalTo(self.emailView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(35.75)
            $0.width.height.equalTo(25)
        }
        self.lineTitle1.snp.makeConstraints{
            $0.top.equalTo(self.emailView.snp.bottom).offset(25)
            $0.leading.equalTo(settingImage1.snp.trailing).offset(20.75)
            $0.trailing.equalToSuperview()
        }
        self.line1.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
            $0.height.equalTo(1)
            $0.top.equalTo(self.lineTitle1.snp.bottom).offset(20)
        }
        self.settingImage2.snp.makeConstraints{
            $0.top.equalTo(self.line1.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(35.75)
            $0.width.height.equalTo(25)
        }
        self.lineTitle2.snp.makeConstraints{
            $0.top.equalTo(self.line1.snp.bottom).offset(20)
            $0.leading.equalTo(settingImage2.snp.trailing).offset(20.75)
            $0.trailing.equalToSuperview()
        }
        self.line2.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
            $0.height.equalTo(1)
            $0.top.equalTo(self.lineTitle2.snp.bottom).offset(20)
        }
        
    }
    
    //MARK: - Target
    func addTarget(){
        
        let passwordResetBtn = UITapGestureRecognizer(target: self, action: #selector(didClickPasswordReset))
        lineTitle1.isUserInteractionEnabled = true
        lineTitle1.addGestureRecognizer(passwordResetBtn)
        
        let accountDeleteBtn = UITapGestureRecognizer(target: self, action: #selector(didClickAccountDelete))
        lineTitle2.isUserInteractionEnabled = true
        lineTitle2.addGestureRecognizer(accountDeleteBtn)
        
        let backBtn = UITapGestureRecognizer(target: self, action: #selector(didClickBackButton))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(backBtn)
    }
    

}

