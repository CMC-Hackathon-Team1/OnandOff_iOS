//
//  CategorySelectionViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/05.
//

import UIKit
import SnapKit
import Foundation

class CategorySelectonViewController: UIViewController {
    
//MARK: - Properties
    let mainView = UIView().then{
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    let closeButton = UIImageView().then{
        $0.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
    }
    let mainLabel = UILabel().then{
        $0.text = "카테고리"
    }
    let artPic = UIImageView().then{
        $0.image = UIImage(named: "culture")?.withRenderingMode(.alwaysOriginal)
    }
    let artButton = UIButton().then{
        $0.setTitle("문화/예술", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        
    }
    let line = UIView().then{
        $0.backgroundColor = UIColor.gray
    }
    let sportPic = UIImageView().then{
        $0.image = UIImage(named: "sport")?.withRenderingMode(.alwaysOriginal)
    }
    let sportButton = UIButton().then{
        $0.setTitle("스포츠", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    let line2 = UIView().then{
        $0.backgroundColor = UIColor.gray
    }
    let selfdevPic = UIImageView().then{
        $0.image = UIImage(named: "selfdev")?.withRenderingMode(.alwaysOriginal)
    }
    let selfdevButton = UIButton().then{
        $0.setTitle("자기계발", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    let line3 = UIView().then{
        $0.backgroundColor = UIColor.gray
    }
    let etcPic = UIImageView().then{
        $0.image = UIImage(named: "etc")?.withRenderingMode(.alwaysOriginal)
    }
    let etcButton = UIButton().then{
        $0.setTitle("기타", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
    }
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        setUpView()
        layout()
        addTarget()
    }
    
//MARK: - Selector
    @objc private func didClickArt(_ button: UIButton) {
        print("didClickArt")
    }
    @objc private func didClickSport(_ button: UIButton) {
        print("didClickSport")
    }
    @objc private func didClickSelfdev(_ button: UIButton) {
        print("didClickSelfdev")
    }
    @objc private func didClickEtc(_ button: UIButton) {
        print("didClickEtc")
    }
    @objc func didClickClose(sender: UITapGestureRecognizer) {
        print("didClickClose")
        self.dismiss(animated: true)
    }
//MARK: - addSubView
    func setUpView(){
        self.view.addSubview(self.mainView)
        mainView.addSubview(self.closeButton)
        mainView.addSubview(self.mainLabel)
        mainView.addSubview(self.artPic)
        mainView.addSubview(self.artButton)
        mainView.addSubview(self.sportPic)
        mainView.addSubview(self.sportButton)
        mainView.addSubview(self.line)
        mainView.addSubview(self.selfdevPic)
        mainView.addSubview(self.selfdevButton)
        mainView.addSubview(self.line2)
        mainView.addSubview(self.line3)
        mainView.addSubview(self.etcPic)
        mainView.addSubview(self.etcButton)
    }
    
//MARK: - Layout
    func layout(){
        self.mainView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.height.equalTo(358)
        }
        self.closeButton.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(24.08)
            $0.leading.equalTo(self.mainView.snp.leading).offset(27.68)
        }
        self.mainLabel.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(19.5)
            $0.centerX.equalTo(self.mainView)
        }
        self.artPic.snp.makeConstraints{
            $0.top.equalTo(self.closeButton.snp.bottom).offset(19.58)
            $0.leading.equalTo(self.mainView.snp.leading).offset(24.5)
        }
        self.artButton.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(55.5)
            $0.leading.equalTo(self.artPic.snp.trailing).offset(21)
        }
        self.line.snp.makeConstraints{
            $0.top.equalTo(self.artPic.snp.bottom).offset(14)
            $0.leading.equalTo(self.mainView.snp.leading).offset(12.5)
            $0.trailing.equalTo(self.mainView.snp.trailing).offset(12.5)
            $0.size.height.equalTo(1)
        }
        self.sportPic.snp.makeConstraints{
            $0.top.equalTo(self.line.snp.bottom).offset(14)
            $0.leading.equalTo(self.mainView.snp.leading).offset(24.5)
        }
        self.sportButton.snp.makeConstraints{
            $0.top.equalTo(self.line.snp.bottom).offset(11)
            $0.leading.equalTo(self.sportPic.snp.trailing).offset(21)
        }
        self.line2.snp.makeConstraints{
            $0.top.equalTo(self.sportButton.snp.bottom).offset(14)
            $0.leading.equalTo(self.mainView.snp.leading).offset(12.5)
            $0.trailing.equalTo(self.mainView.snp.trailing).offset(12.5)
            $0.size.height.equalTo(1)
        }
        self.selfdevPic.snp.makeConstraints{
            $0.top.equalTo(self.line2.snp.bottom).offset(14)
            $0.leading.equalTo(self.mainView.snp.leading).offset(24.5)
        }
        self.selfdevButton.snp.makeConstraints{
            $0.top.equalTo(self.line2.snp.bottom).offset(11)
            $0.leading.equalTo(self.selfdevPic.snp.trailing).offset(21)
        }
        self.line3.snp.makeConstraints{
            $0.top.equalTo(self.selfdevPic.snp.bottom).offset(14)
            $0.leading.equalTo(self.mainView.snp.leading).offset(12.5)
            $0.trailing.equalTo(self.mainView.snp.trailing).offset(12.5)
            $0.size.height.equalTo(1)
        }
        self.etcPic.snp.makeConstraints{
            $0.top.equalTo(self.line3.snp.bottom).offset(23.67)
            $0.leading.equalTo(self.mainView.snp.leading).offset(24.5)
        }
        self.etcButton.snp.makeConstraints{
            $0.top.equalTo(self.line3.snp.bottom).offset(11)
            $0.leading.equalTo(self.selfdevPic.snp.trailing).offset(21)
        }
        
        
    }
    
    
//MARK: - AddTarget
    private func addTarget() {
        self.artButton.addTarget(self, action: #selector(self.didClickArt(_:)), for: .touchUpInside)
        self.sportButton.addTarget(self, action: #selector(self.didClickSport(_:)), for: .touchUpInside)
        self.selfdevButton.addTarget(self, action: #selector(self.didClickSelfdev(_:)), for: .touchUpInside)
        self.etcButton.addTarget(self, action: #selector(self.didClickEtc(_:)), for: .touchUpInside)
        
        let CloseBtn = UITapGestureRecognizer(target: self, action: #selector(didClickClose))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(CloseBtn)
    }
}
