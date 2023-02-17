//
//  AlarmViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/17.
//

import Foundation
import UIKit
import SnapKit
import Then

class AlarmViewController: UIViewController{
    //MARK: - Datasource
    
    
    //MARK: - Properties
    let backButton = UIImageView().then{
        $0.image = UIImage(named: "backbutton")?.withRenderingMode(.alwaysOriginal)
    }
    let settingLabel = UILabel().then{
        $0.text = "소식"
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
    }
    let settingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(AlarmViewCell.self, forCellWithReuseIdentifier: AlarmViewCell.identifier)
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
extension AlarmViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlarmViewCell.identifier, for: indexPath) as! AlarmViewCell
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}
        
extension AlarmViewController: UICollectionViewDelegateFlowLayout {
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

