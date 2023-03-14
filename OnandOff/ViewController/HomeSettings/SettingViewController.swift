//
//  SettingViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//

import UIKit

final class SettingViewController: UIViewController{
    //MARK: - Properties
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
        self.configureNavigation()
        
        self.view.backgroundColor = .white
        
        self.settingCollectionView.delegate = self
        self.settingCollectionView.dataSource = self
        
        settingImageArray.append(contentsOf: ["UserCircle", "LockSimple", "alarmButton", "ChatCenteredDots", "ClipboardText", "WarningCircle", "SignOut"])
        settingLabelArray.append(contentsOf: ["계정", "개인정보 보호", "알림", "피드백/문의하기", "약관 및 정책", "버전", "로그아웃"])
    }
    
    //MARK: - ConfigureNavigation
    private func configureNavigation() {
        self.navigationItem.title = "설정"
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - AddSubview
    private func setUpView(){
        self.view.addSubview(self.settingCollectionView)
    }
    
    //MARK: - Selector
    
    //MARK: - Layout
    private func layout(){
        self.settingCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(35)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Target
    func addTarget(){
        
    }
}

//MARK: - CollectionVIew
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
            let accountVC = AccountSettingViewController()
            self.navigationController?.pushViewController(accountVC, animated: true)
        }else if indexPath.row == 1{
            let privacyVC = PrivacyViewController()
            self.navigationController?.pushViewController(privacyVC, animated: true)
        }
        else if indexPath.row == 2{
            let alertVC = AlertViewController()
            self.navigationController?.pushViewController(alertVC, animated: true)
        }
        else if indexPath.row == 3{
            let feedbackVC = FeedbackViewController()
            self.navigationController?.pushViewController(feedbackVC, animated: true)
        }
        else if indexPath.row == 4{
            let plicyVC = PolicyViewController()
            self.navigationController?.pushViewController(plicyVC, animated: true)
        }
        else if indexPath.row == 6{
            let alert = StandardAlertController(title: "로그아웃 하시겠습니까?", message: nil)
            let cancel = StandardAlertAction(title: "취소", style: .cancel)
            let logout = StandardAlertAction(title: "로그아웃", style: .basic) { _ in
                self.navigationController?.popViewController(animated: false)
                NotificationCenter.default.post(name: .presentLoginVC, object: nil)
            }
            alert.addAction(cancel)
            alert.addAction(logout)
            
            self.present(alert, animated: false)
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
