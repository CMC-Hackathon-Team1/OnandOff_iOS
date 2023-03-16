//
//  SettingViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//

import UIKit

final class SettingViewController: UIViewController{
    //MARK: - Properties
    var settingImageArray = ["UserCircle", "LockSimple", "alarmButton", "ChatCenteredDots", "ClipboardText", "WarningCircle", "SignOut"]
    var settingLabelArray = ["계정", "개인정보 보호", "알림", "피드백/문의하기", "약관 및 정책", "버전", "로그아웃"]
    
    private let settingTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setUpView()
        layout()
        addTarget()
        self.configureNavigation()
        
        self.view.backgroundColor = .white
        
        self.settingTableView.delegate = self
        self.settingTableView.dataSource = self
    }
    
    //MARK: - ConfigureNavigation
    private func configureNavigation() {
        self.navigationItem.title = "설정"
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.isHidden = false
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    //MARK: - AddSubview
    private func setUpView(){
        self.view.addSubview(self.settingTableView)
    }
    
    //MARK: - Selector
    
    //MARK: - Layout
    private func layout(){
        self.settingTableView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(35)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Target
    func addTarget(){
        
    }
}

//MARK: - CollectionVIew
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        cell.selectionStyle = .none
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let accountVC = AccountSettingViewController()
            self.navigationController?.pushViewController(accountVC, animated: true)
        } else if indexPath.row == 1 {
            let privacyVC = UserPrivacyViewController()
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
