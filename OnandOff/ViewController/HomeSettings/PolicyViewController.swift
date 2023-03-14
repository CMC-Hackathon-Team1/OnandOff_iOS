//
//  PolicyViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//


import Foundation
import UIKit
import SnapKit
import Then

class PolicyViewController: UIViewController{
    //MARK: - Datasource
    
    
    //MARK: - Properties
    let backButton = UIImageView().then{
        $0.image = UIImage(named: "backbutton")?.withRenderingMode(.alwaysOriginal)
    }
    let settingLabel = UILabel().then{
        $0.text = "약관 및 정책"
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
    }
    
    let arrow1 = UIImageView().then{
        $0.image = UIImage(named: "rightArrow")?.withRenderingMode(.alwaysOriginal)
    }
    let lineTitle1 = UILabel().then{
        $0.text = "서비스 이용 약관"
        $0.font = .notoSans(size: 14)
    }
    let line1 = UIView().then{
        $0.backgroundColor = UIColor.systemGray4
    }
    let arrow2 = UIImageView().then{
        $0.image = UIImage(named: "rightArrow")?.withRenderingMode(.alwaysOriginal)
    }
    let lineTitle2 = UILabel().then{
        $0.text = "개인정보 처리방침"
        $0.font = .notoSans(size: 14)
    }
    let line2 = UIView().then{
        $0.backgroundColor = UIColor.systemGray4
    }
    let arrow3 = UIImageView().then{
        $0.image = UIImage(named: "rightArrow")?.withRenderingMode(.alwaysOriginal)
    }
    let lineTitle3 = UILabel().then{
        $0.text = "서비스 알림 수신 동의"
        $0.font = .notoSans(size: 14)
    }
    let line3 = UIView().then{
        $0.backgroundColor = UIColor.systemGray4
    }
    
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
        self.view.addSubview(self.arrow1)
        self.view.addSubview(self.lineTitle1)
        self.view.addSubview(self.line1)
        self.view.addSubview(self.arrow2)
        self.view.addSubview(self.lineTitle2)
        self.view.addSubview(self.line2)
        self.view.addSubview(self.arrow3)
        self.view.addSubview(self.lineTitle3)
        self.view.addSubview(self.line3)

    }
    
    //MARK: - Selector
   
    @objc func didClickBackButton(sender: UITapGestureRecognizer){
        dismiss(animated: true)
    }
    @objc func didClickServicePolicy(sender: UITapGestureRecognizer){
        let termsOfUseVC = TermsOfUseViewController()
        termsOfUseVC.modalPresentationStyle = .fullScreen
        self.present(termsOfUseVC, animated: true)
    }
    @objc func didClickPrivacyPolicy(sender: UITapGestureRecognizer){
        let privacyTermsVC = PrivacyTermsViewController()
        privacyTermsVC.modalPresentationStyle = .fullScreen
        present(privacyTermsVC, animated: true)
    }
    @objc func didClickServiceAlert(sender: UITapGestureRecognizer){
        let VC = ServiceAlertViewController()
        VC.modalPresentationStyle = .overCurrentContext
        present(VC, animated: true)
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
        self.lineTitle1.snp.makeConstraints{
            $0.top.equalTo(self.settingLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalTo(self.arrow1.snp.leading)
        }
        self.arrow1.snp.makeConstraints{
            $0.top.equalTo(self.settingLabel.snp.bottom).offset(30)
            $0.height.equalTo(9)
            $0.width.equalTo(6)
            $0.trailing.equalToSuperview().offset(-40)
        }
        self.line1.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
            $0.height.equalTo(1)
            $0.top.equalTo(self.lineTitle1.snp.bottom).offset(16)
        }
        self.lineTitle2.snp.makeConstraints{
            $0.top.equalTo(self.line1.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalTo(self.arrow2.snp.leading)
        }
        self.arrow2.snp.makeConstraints{
            $0.top.equalTo(self.line1.snp.bottom).offset(20)
            $0.height.equalTo(9)
            $0.width.equalTo(6)
            $0.trailing.equalToSuperview().offset(-40)
        }
        self.line2.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
            $0.height.equalTo(1)
            $0.top.equalTo(self.lineTitle2.snp.bottom).offset(16)
        }
        self.lineTitle3.snp.makeConstraints{
            $0.top.equalTo(self.line2.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(32)
            $0.trailing.equalTo(self.arrow3.snp.leading)
        }
        self.arrow3.snp.makeConstraints{
            $0.top.equalTo(self.line2.snp.bottom).offset(20)
            $0.height.equalTo(9)
            $0.width.equalTo(6)
            $0.trailing.equalToSuperview().offset(-40)
        }
        self.line3.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
            $0.height.equalTo(1)
            $0.top.equalTo(self.lineTitle3.snp.bottom).offset(16)
        }
        
        
        
    }
    
    //MARK: - Target
    func addTarget(){

        let backBtn = UITapGestureRecognizer(target: self, action: #selector(didClickBackButton))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(backBtn)
        
        let servicePolicyButton = UITapGestureRecognizer(target: self, action: #selector(didClickServicePolicy))
        lineTitle1.isUserInteractionEnabled = true
        lineTitle1.addGestureRecognizer(servicePolicyButton)
        
        let privacyPolicyButton = UITapGestureRecognizer(target: self, action: #selector(didClickPrivacyPolicy))
        lineTitle2.isUserInteractionEnabled = true
        lineTitle2.addGestureRecognizer(privacyPolicyButton)
        
        let serviceAlertButton = UITapGestureRecognizer(target: self, action: #selector(didClickServiceAlert))
        lineTitle3.isUserInteractionEnabled = true
        lineTitle3.addGestureRecognizer(serviceAlertButton)
    }
    


}

