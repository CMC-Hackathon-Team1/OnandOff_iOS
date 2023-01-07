//
//  EditOrDeleteViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/06.
//

import UIKit
import SnapKit
import Foundation

class EditOrDeleteViewController: UIViewController {
    
//MARK: - Properties
    let mainView = UIView().then{
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    let closeButton = UIImageView().then{
        $0.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
    }
    let mainLabel = UILabel().then{
        $0.text = "글 편집"
    }
    let editPic = UIImageView().then{
        $0.image = UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal)
    }
    let editButton = UIButton().then{
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(UIColor.black, for: .normal)
        
    }
    let line = UIView().then{
        $0.backgroundColor = UIColor.gray
    }
    let deletePic = UIImageView().then{
        $0.image = UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal)
    }
    let deleteButton = UIButton().then{
        $0.setTitle("삭제", for: .normal)
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
    @objc private func didClickEdit(_ button: UIButton) {
        let detailVC = EditPostViewController()
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
        print("didClickEdit")
    }
    @objc private func didClickDelete(_ button: UIButton) {
        print("didClickDelete")
    }
    
//MARK: - addSubView
    func setUpView(){
        self.view.addSubview(self.mainView)
        mainView.addSubview(self.closeButton)
        mainView.addSubview(self.mainLabel)
        mainView.addSubview(self.editPic)
        mainView.addSubview(self.editButton)
        mainView.addSubview(self.deletePic)
        mainView.addSubview(self.deleteButton)
        mainView.addSubview(self.line)
    }
    
//MARK: - Layout
    func layout(){
        self.mainView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.height.equalTo(238)
        }
        self.closeButton.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(24.08)
            $0.leading.equalTo(self.mainView.snp.leading).offset(27.68)
        }
        self.mainLabel.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(19.5)
            $0.centerX.equalTo(self.mainView)
        }
        self.editPic.snp.makeConstraints{
            $0.top.equalTo(self.closeButton.snp.bottom).offset(19.58)
            $0.leading.equalTo(self.mainView.snp.leading).offset(24.5)
        }
        self.editButton.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(53.5)
            $0.leading.equalTo(self.editPic.snp.trailing).offset(21)
        }
        self.line.snp.makeConstraints{
            $0.top.equalTo(self.editPic.snp.bottom).offset(14)
            $0.leading.equalTo(self.mainView.snp.leading).offset(12.5)
            $0.trailing.equalTo(self.mainView.snp.trailing).offset(12.5)
            $0.size.height.equalTo(1)
        }
        self.deletePic.snp.makeConstraints{
            $0.top.equalTo(self.line.snp.bottom).offset(11.5)
            $0.leading.equalTo(self.mainView.snp.leading).offset(24.5)
        }
        self.deleteButton.snp.makeConstraints{
            $0.top.equalTo(self.line.snp.bottom).offset(9)
            $0.leading.equalTo(self.deletePic.snp.trailing).offset(21)
        }
    }
    
    
//MARK: - AddTarget
    private func addTarget() {
        self.editButton.addTarget(self, action: #selector(self.didClickEdit(_:)), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(self.didClickDelete(_:)), for: .touchUpInside)
    }
}


extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
