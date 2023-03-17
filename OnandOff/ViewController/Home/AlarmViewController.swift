//
//  AlarmViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/17.
//


import UIKit

final class AlarmViewController: UIViewController{
    private let alrmTableView = UITableView().then {
        $0.backgroundColor = .white
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        self.addSubView()
        self.layout()
        self.addTarget()
        
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .white
        self.title = "소식"
        
        _ = UILabel().then {
            $0.text = "알림 내역은 추후 업데이트 됩니다."
            $0.textColor = .black
            self.view.addSubview($0)
            $0.snp.makeConstraints() { make in
                make.centerY.centerX.equalToSuperview()
            }
        }
    }
    
    //MARK: - AddSubview
    private func addSubView() {
        
    }
    
    //MARK: - Selector

    //MARK: - Layout
    private func layout() {

    }
    
    //MARK: - Target
    private func addTarget() {

    }
}
