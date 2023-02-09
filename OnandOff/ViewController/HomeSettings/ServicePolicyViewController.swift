//
//  ServicePolicyViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//

import Foundation
import UIKit
import SnapKit
import Then

class ServicePolicyViewController: UIViewController{
    //MARK: - Datasource
    
    
    //MARK: - Properties
    let backButton = UIImageView().then{
        $0.image = UIImage(named: "backbutton")?.withRenderingMode(.alwaysOriginal)
    }
    let settingLabel = UILabel().then{
        $0.text = "서비스 이용약관"
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
    }
    let policyLabel = UILabel().then{
        $0.text = "ssssalksdjf aoie paeoi jalkfj laerit arj laerj airj jjljakjl akjgpeair laijgl kasgaepria lkjlak j aeirt ;lassfgffigj aig oadihg ah g;ar;afhgdjfg la;eirg ;SIgldkfJglzsjrgzgairjg oaijrgargajslglfgja l;igjdgo aiur mpoaop auwou di ssssalksdjf aoie paeoi jalkfj laerit arj laerj airj jjljakjl akjgpeair laijgl kasgaepria lkjlak j aeirt ;lassfgffigj aig oadihg"
        $0.numberOfLines = 0
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
        self.view.addSubview(self.policyLabel)
    }
    
    //MARK: - Selector
   
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
        self.policyLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
        }
    }
    
    //MARK: - Target
    func addTarget(){

        let backBtn = UITapGestureRecognizer(target: self, action: #selector(didClickBackButton))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(backBtn)
    }
    


}



