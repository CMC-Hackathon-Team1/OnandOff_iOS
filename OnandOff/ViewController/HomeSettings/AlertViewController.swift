//
//  AlertViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//


import UIKit

final class AlertViewController: UIViewController{
    //MARK: - Properties
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
        
        self.view.backgroundColor = .white
        self.title = "알림"
        
        alertMainLabelArray.append(contentsOf: ["좋아요 소식받기", "팔로잉 소식 받기  ", "팔로잉 유저 게시글 소식 받기", "게시글 작성 알림 안내 받기", "관리자 공지사항 안내 받기"])
        alertSubLabelArray.append(contentsOf: ["개발자 온오프님이 회원님의 게시글을 좋아합니다. ", "개발자 온오프님이 회원님을 팔로잉 합니다. ", "개발자 온오프님이 새로운 글을 올렸습니다. ", "회원님의 새로운 소식을 알려주세요! ", ""])
        alertToggleArray.append(contentsOf: [false, false, false, false, false])
    }
    
    //MARK: - AddSubview
    func setUpView(){
        self.view.addSubview(self.alertCollectionView)

    }
    
    //MARK: - Selector
    @objc func didClickBackButton(sender: UITapGestureRecognizer){
        dismiss(animated: true)
    }
    
    //MARK: - Layout
    func layout(){
        self.alertCollectionView.snp.makeConstraints{
            $0.leading.bottom.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
        }
    }
    
    //MARK: - Target
    func addTarget(){
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
