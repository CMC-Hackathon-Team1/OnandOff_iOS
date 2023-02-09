//
//  AccountDeleteViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//

import Foundation
import UIKit
import SnapKit
import Then

class AccountDeleteViewController: UIViewController{
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
        $0.font = UIFont(name:"NotoSans-Bold", size: 14)
        $0.text = "계정을 삭제하시겠습니까?"
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    let deleteView = UIView().then{
        $0.backgroundColor = .mainColor
    }
    let delete = UILabel().then{
        $0.text = "삭 제"
        $0.textColor = .white
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
    }
    let cancelView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.mainColor.cgColor
        $0.layer.borderWidth = 1
    }
    let cancel = UILabel().then{
        $0.text = "취 소"
        $0.textColor = .mainColor
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
        popupView.addSubview(deleteView)
        deleteView.addSubview(delete)
        popupView.addSubview(cancelView)
        cancelView.addSubview(cancel)
    }
    
    //MARK: - Selector
    @objc func didClickBackground(sender: UITapGestureRecognizer){
        dismiss(animated: false)
    }
    @objc func didClickLogout(sender: UITapGestureRecognizer){
        dismiss(animated: false)
    }
    @objc func didClickCancel(sender: UITapGestureRecognizer){
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
            $0.top.equalToSuperview().offset(36)
        }
        self.cancelView.snp.makeConstraints{
            $0.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(38)
        }
        self.cancel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        self.deleteView.snp.makeConstraints{
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
            $0.height.equalTo(38)
        }
        self.delete.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }
    
    //MARK: - Target
    func addTarget(){
        let backgroundBtn = UITapGestureRecognizer(target: self, action: #selector(didClickBackground))
        fullView.isUserInteractionEnabled = true
        fullView.addGestureRecognizer(backgroundBtn)
        
        let deleteBtn = UITapGestureRecognizer(target: self, action: #selector(didClickLogout))
        deleteView.isUserInteractionEnabled = true
        deleteView.addGestureRecognizer(deleteBtn)
        
        let cancelBtn = UITapGestureRecognizer(target: self, action: #selector(didClickCancel))
        cancelView.isUserInteractionEnabled = true
        cancelView.addGestureRecognizer(cancelBtn)
        
    }
    

}


