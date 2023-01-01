//
//  LookAroundViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit


final class LookAroundViewController: UIViewController {
    //MARK: - Properties
    private let topTabbar = CustomTopTabbar()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.addSubView()
        self.layout()
        self.configureNavigation()
    }
    
    //MARK: - Method
    private func configureNavigation() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        self.navigationItem.title = "둘러보기"
    }
    
    //MARK: - addSubView
    private func addSubView() {
        self.view.addSubview(self.topTabbar)
    }
    
    //MARK: - Layout
    private func layout() {
        self.topTabbar.snp.makeConstraints {
            $0.leading.equalTo(self.view).offset(24)
            $0.trailing.equalTo(self.view).offset(-24)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(32)
        }
    }
}
