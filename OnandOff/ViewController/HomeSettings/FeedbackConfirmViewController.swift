//
//  PasswordResetViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//

import Foundation
import UIKit
import SnapKit
import Then

class FeedbackConfirmViewController: UIViewController{
    //MARK: - Datasource
    
    
    //MARK: - Properties
    let fullView = UIView().then{
        $0.backgroundColor = .black
        $0.alpha = 0.5
    }
    let popupView = UIView().then{
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 15, maskedCorners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner])
    }
    let popupLabel = UILabel().then{
        $0.font = UIFont(name:"NotoSans-Bold", size: 12)
        $0.text = "피드백 / 문의를 주셔서 감사합니다!\n답변은 이메일에서 확인하실 수 있습니다."
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    let confirmView = UIView().then{
        $0.backgroundColor = .mainColor
    }
    let confirm = UILabel().then{
        $0.text = "확 인"
        $0.textColor = .white
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
    }

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setUpView()
        layout()
        addTarget()
        
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = .clear

        
    }
    
    //MARK: - AddSubview
    func setUpView(){
        view.addSubview(fullView)
        view.addSubview(popupView)
        popupView.addSubview(popupLabel)
        popupView.addSubview(confirmView)
        confirmView.addSubview(confirm)
    }
    
    //MARK: - Selector
    @objc func didClickBackground(sender: UITapGestureRecognizer){
        dismiss(animated: false)
    }
    
    //MARK: - Layout
    func layout(){
        self.fullView.snp.makeConstraints{
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
        self.popupView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(133)
            $0.width.equalTo(322)
        }
        self.popupLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(31)
        }
        self.confirmView.snp.makeConstraints{
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(38)
        }
        self.confirm.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }
    
    //MARK: - Target
    func addTarget(){
        let backgroundBtn = UITapGestureRecognizer(target: self, action: #selector(didClickBackground))
        fullView.isUserInteractionEnabled = true
        fullView.addGestureRecognizer(backgroundBtn)
        
        let confirmBtn = UITapGestureRecognizer(target: self, action: #selector(didClickBackground))
        confirmView.isUserInteractionEnabled = true
        confirmView.addGestureRecognizer(confirmBtn)
        
    }
    

}


