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

class SettingViewController: UIViewController{
    //MARK: - Datasource
    
    
    //MARK: - Properties
    let backButton = UIImageView().then{
        $0.image = UIImage(named: "backbutton")?.withRenderingMode(.alwaysOriginal)
    }
    let settingLabel = UILabel().then{
        $0.text = "설정"
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
    }
    let settingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(SettingCell.self, forCellWithReuseIdentifier: SettingCell.identifier)
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
        self.settingCollectionView.delegate = self
        self.settingCollectionView.dataSource = self
        
        
        settingImageArray.append(contentsOf: ["UserCircle", "LockSimple", "alarmButton", "ChatCenteredDots", "ClipboardText", "WarningCircle", "SignOut"])
        settingLabelArray.append(contentsOf: ["계정", "개인정보 보호", "알림", "피드백/문의하기", "약관 및 정책", "버전", "로그아웃"])
        
    }
    
    //MARK: - AddSubview
    func setUpView(){
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.settingLabel)
        self.view.addSubview(self.settingCollectionView)
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
        self.settingCollectionView.snp.makeConstraints{
            $0.top.equalTo(self.settingLabel.snp.bottom).offset(35)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Target
    func addTarget(){
        let backBtn = UITapGestureRecognizer(target: self, action: #selector(didClickBackButton))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(backBtn)
        
    }
    

}

//CollectionVIew
extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingImageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        
        cell.settingImage.image = UIImage(named: "\(settingImageArray[indexPath.row])")?.withRenderingMode(.alwaysOriginal)
        cell.title.text = settingLabelArray[indexPath.row]
        if indexPath.row == 5{
            cell.arrow.isHidden = true
        }else if indexPath.row == 6{
            cell.title.textColor = .red
            cell.arrow.isHidden = true
        }
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            let VC = AccountSettingViewController()
            VC.modalPresentationStyle = .fullScreen
            present(VC, animated: false)
        }else if indexPath.row == 1{
            let VC = PrivacyViewController()
            VC.modalPresentationStyle = .fullScreen
            present(VC, animated: false)
        }
        else if indexPath.row == 2{
            let VC = AlertViewController()
            VC.modalPresentationStyle = .fullScreen
            present(VC, animated: false)
        }
        else if indexPath.row == 3{
            let VC = FeedbackViewController()
            VC.modalPresentationStyle = .fullScreen
            present(VC, animated: false)
        }
        else if indexPath.row == 4{
            let VC = PolicyViewController()
            VC.modalPresentationStyle = .fullScreen
            present(VC, animated: false)
        }
        else if indexPath.row == 6{
            let VC = LogoutViewController()
            VC.modalPresentationStyle = .overCurrentContext
            present(VC, animated: false)
        }

        
    }
}
        
extension SettingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width , height: 50)
        
    }
    
}
