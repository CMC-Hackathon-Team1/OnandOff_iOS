//
//  MyPageViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit

final class MyPageViewController: UIViewController {
    //MARK: - Properties
    private let profileView = ProfileView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubView()
        self.layout()
        self.configureNavigation()
    }
    
    //MARK: - Selector
    @objc private func didClickEditButton(_ button: UIButton) {
        print("didClickEditButton")
    }
    
    //MARK: - configureNavigation
    private func configureNavigation() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        self.navigationItem.title = "마이페이지"
        
        let editBarButtonItem = UIBarButtonItem(title: "편집",
                                                style: .plain,
                                                target: self,
                                                action: #selector(self.didClickEditButton(_:)))
        editBarButtonItem.setTitleTextAttributes([.foregroundColor : UIColor.mainColor], for: .normal)
        self.navigationItem.rightBarButtonItem = editBarButtonItem
    }
    
    //MARK: - AddsubView
    private func addSubView() {
        self.view.addSubview(self.profileView)
    }
    
    //MARK: - Layout
    private func layout() {
        self.profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(66)
        }
    }  
}
