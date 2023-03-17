//
//  PolicyViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//


import UIKit

final class PolicyViewController: UIViewController{
    //MARK: - Properties
    private let tableViewDatas = ["서비스 이용 약관", "개인정보 처리방침"]
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .white
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        self.setUpView()
        self.layout()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.backgroundColor = .white
        self.navigationItem.backButtonTitle = ""
        self.title = "약관 및 정책"
    }
    
    //MARK: - AddSubview
    private func setUpView(){
        self.view.addSubview(self.tableView)
    }
    
    //MARK: - Layout
    private func layout(){
        self.tableView.snp.makeConstraints {
            $0.trailing.bottom.leading.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension PolicyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        cell.title.text = tableViewDatas[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let termsOfUseVC = TermsOfUseViewController()
            self.navigationController?.pushViewController(termsOfUseVC, animated: true)
        } else {
            let privacyTermsVC = PrivacyTermsViewController()
            self.navigationController?.pushViewController(privacyTermsVC, animated: true)
        }
    }
}

