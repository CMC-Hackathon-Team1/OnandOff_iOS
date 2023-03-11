//
//  AlertViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//


import Foundation
import UIKit
import SnapKit
import Then

class AlertViewController: UIViewController{
    //MARK: - Datasource
    
    
    //MARK: - Properties
    let backButton = UIImageView().then{
        $0.image = UIImage(named: "backbutton")?.withRenderingMode(.alwaysOriginal)
    }
    let settingLabel = UILabel().then{
        $0.text = "알림"
        $0.font = UIFont(name:"NotoSans-Regular", size: 16)
    }
    let alertCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(AlertCell.self, forCellWithReuseIdentifier: AlertCell.identifier)
    }
    
    let toggleArray = ["toggleoff","toggleon"]
    var toggleIndex = 0
    
    
    var alertMainLabelArray = [String]()
    var alertSubLabelArray = [String]()
    var alertToggleArray = [Bool]()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setUpView()
        layout()
        addTarget()
        
        self.alertCollectionView.delegate = self
        self.alertCollectionView.dataSource = self
        
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = .white

        alertMainLabelArray.append(contentsOf: ["좋아요 소식받기", "팔로잉 소식 받기  ", "팔로잉 유저 게시글 소식 받기", "게시글 작성 알림 안내 받기", "관리자 공지사항 안내 받기"])
        alertSubLabelArray.append(contentsOf: ["개발자 온오프님이 회원님의 게시글을 좋아합니다. ", "개발자 온오프님이 회원님을 팔로잉 합니다. ", "개발자 온오프님이 새로운 글을 올렸습니다. ", "회원님의 새로운 소식을 알려주세요! ", ""])
        alertToggleArray.append(contentsOf: [false, false, false, false, false])
    }
    
    //MARK: - AddSubview
    func setUpView(){
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.settingLabel)
        self.view.addSubview(self.alertCollectionView)

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
        self.alertCollectionView.snp.makeConstraints{
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.equalTo(self.settingLabel.snp.bottom).offset(50)
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
extension AlertViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alertMainLabelArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlertCell.identifier, for: indexPath) as! AlertCell
        
        cell.mainTitle.text = alertMainLabelArray[indexPath.row]
        cell.subTitle.text = alertSubLabelArray[indexPath.row]
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlertCell.identifier, for: indexPath) as! AlertCell
        
        self.toggleIndex = (self.toggleIndex >= self.toggleArray.count-1) ? 0 : self.toggleIndex+1
        cell.onoffToggle.image = UIImage(named:toggleArray[toggleIndex])
        if self.toggleIndex == 0{
            self.alertCollectionView.reloadData()
            print(toggleIndex)
        }else{
            self.alertCollectionView.reloadData()
            print(toggleIndex)
        }
        

        
    }
}
        
extension AlertViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width , height: 80)
        
    }
    
}
