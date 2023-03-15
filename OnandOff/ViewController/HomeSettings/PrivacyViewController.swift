//
//  PrivacyViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//


import Foundation
import UIKit
import SnapKit
import Then

class PrivacyViewController: UIViewController{
    //MARK: - Datasource
    
    
    //MARK: - Properties
    let backButton = UIImageView().then{
        $0.image = UIImage(named: "backbutton")?.withRenderingMode(.alwaysOriginal)
    }
    let settingLabel = UILabel().then{
        $0.text = "개인정보 보호"
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
    }
    let statusLabel = UILabel().then{
        $0.text = "계정 공개 상태"
        $0.font = UIFont(name:"NotoSans-Bold", size: 14)
    }
    let publicAccountLabel = UILabel().then{
        $0.text = "공개 계정"
        $0.font = UIFont(name:"NotoSans-Regular", size: 14)
    }
    let privateAccountLabel = UILabel().then{
        $0.text = "비공개 계정"
        $0.font = UIFont(name:"NotoSans-Regular", size: 14)
    }
    let publicAccountCheck = UIImageView().then{
        $0.image = UIImage(named: "checkcircle")?.withRenderingMode(.alwaysOriginal)
    }
    let privateAccountCheck = UIImageView().then{
        $0.image = UIImage(named: "uncheckcircle")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    let publicAccountCheckArray = ["checkcircle","uncheckcircle"]
    var publicAccountCheckindex = 0
    let privateAccountCheckArray = ["checkcircle","uncheckcircle"]
    var privateAccountCheckindex = 0
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setUpView()
        layout()
        addTarget()
        self.view.backgroundColor = .white
    }
    
    //MARK: - AddSubview
    func setUpView(){
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.settingLabel)
        self.view.addSubview(self.statusLabel)
        self.view.addSubview(self.publicAccountLabel)
        self.view.addSubview(self.privateAccountLabel)
        self.view.addSubview(self.publicAccountCheck)
        self.view.addSubview(self.privateAccountCheck)
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
        self.statusLabel.snp.makeConstraints{
            $0.top.equalTo(self.settingLabel.snp.bottom).offset(37)
            $0.leading.equalToSuperview().offset(31)
        }
        self.publicAccountLabel.snp.makeConstraints{
            $0.top.equalTo(self.statusLabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(31)
        }
        self.publicAccountCheck.snp.makeConstraints{
            $0.top.equalTo(self.publicAccountLabel)
            $0.trailing.equalToSuperview().offset(-31)
        }
        self.privateAccountLabel.snp.makeConstraints{
            $0.top.equalTo(self.publicAccountLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(31)
        }
        self.privateAccountCheck.snp.makeConstraints{
            $0.top.equalTo(self.privateAccountLabel)
            $0.trailing.equalToSuperview().offset(-31)
        }
        
    }
    //MARK: - Selector
   
    @objc func didClickBackButton(sender: UITapGestureRecognizer){
        dismiss(animated: true)
    }
    
    
    @objc func didClickPublic(sender: UITapGestureRecognizer){
        self.publicAccountCheckindex = (self.publicAccountCheckindex >= self.publicAccountCheckArray.count-1) ? 0 : self.publicAccountCheckindex+1
        self.publicAccountCheck.image = UIImage(named:publicAccountCheckArray[publicAccountCheckindex])
        if self.publicAccountCheckindex == 0{
            self.privateAccountCheck.image = UIImage(named:privateAccountCheckArray[1])
        }else{
            self.privateAccountCheck.image = UIImage(named:privateAccountCheckArray[0])
        }
    }
    @objc func didClickPrivate(sender: UITapGestureRecognizer){
        self.privateAccountCheckindex = (self.privateAccountCheckindex >= self.privateAccountCheckArray.count-1) ? 0 : self.privateAccountCheckindex+1
        self.privateAccountCheck.image = UIImage(named:privateAccountCheckArray[privateAccountCheckindex])
        if self.privateAccountCheckindex == 0{
            self.publicAccountCheck.image = UIImage(named:publicAccountCheckArray[1])
        }else{
            self.publicAccountCheck.image = UIImage(named:publicAccountCheckArray[0])
        }
    }
    
    
    //MARK: - Target
    func addTarget(){

        let backBtn = UITapGestureRecognizer(target: self, action: #selector(didClickBackButton))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(backBtn)
        
        let publicAccountCheckBtn = UITapGestureRecognizer(target: self, action: #selector(didClickPublic))
        publicAccountCheck.isUserInteractionEnabled = true
        publicAccountCheck.addGestureRecognizer(publicAccountCheckBtn)
        
        let privateAccountCheckBtn = UITapGestureRecognizer(target: self, action: #selector(didClickPrivate))
        privateAccountCheck.isUserInteractionEnabled = true
        privateAccountCheck.addGestureRecognizer(privateAccountCheckBtn)
    }
    


}


