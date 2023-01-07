//
//  SpecificPostViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/07.
//

import Foundation
import UIKit
import Then
import SnapKit


class SpecificPostViewController: UIViewController {
//MARK: - Properties
    let mainView = UIView().then{
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    let closeButton = UIImageView().then{
        $0.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
    }
    let ellipsisButton = UIImageView().then{
        $0.image = UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal)
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 26.5
        $0.backgroundColor = .lightGray
    }
    private let nameLabel = UILabel().then {
        $0.text = "작가 키키"
        $0.textColor = .text1
        $0.font = .notoSans(size: 14, family: .Bold)
    }
    private let dateLabel = UILabel().then {
        $0.text = "2022/09/24"
        $0.textColor = .text4
        $0.font = .notoSans(size: 12)
    }
    private let tagLabel = UILabel().then {
        $0.text = "#시#소설#에세이 좋아해요"
        $0.textColor = .text4
        $0.font = .notoSans(size: 12)
    }
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "heart.fill"), for: .normal)
//        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSans(size: 11, family: .Regular)
        label.textColor = #colorLiteral(red: 0.5924945474, green: 0.5924944878, blue: 0.5924944282, alpha: 1)
        label.text = "12"
        label.sizeToFit()
        return label
    }()
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "carrot")?.withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "MyContent"
        label.font = .notoSans(size: 14)
        label.textColor = .text1
        return label
    }()
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        setUpView()
        layout()
        addTarget()
    }
//MARK: - Selector
    
    
//MARK: - addSubView
    func setUpView(){
        self.view.addSubview(self.mainView)
        mainView.addSubview(self.closeButton)
        mainView.addSubview(self.ellipsisButton)
        mainView.addSubview(self.profileImageView)
        mainView.addSubview(self.nameLabel)
        mainView.addSubview(self.dateLabel)
        mainView.addSubview(self.heartButton)
        mainView.addSubview(self.likeCountLabel)
        mainView.addSubview(self.tagLabel)
        mainView.addSubview(self.postImageView)
        mainView.addSubview(self.contentLabel)
    }
    
    
//MARK: - Layout
    func layout(){
        self.mainView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(0)
            $0.top.equalToSuperview().offset(73)
            $0.trailing.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
        }
        self.closeButton.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(20.8)
            $0.leading.equalTo(self.mainView.snp.leading).offset(28.42)
        }
        self.profileImageView.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(60)
            $0.leading.equalToSuperview().offset(24)
        }
        self.nameLabel.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(65)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(11)
        }
        self.dateLabel.snp.makeConstraints{
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(0)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(11)
        }
        self.heartButton.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(65.68)
            $0.right.equalTo(self.mainView.snp.trailing).offset(25.03)
        }
        self.likeCountLabel.snp.makeConstraints{
            $0.top.equalTo(self.heartButton.snp.bottom).offset(1.79)
            $0.trailing.equalTo(self.mainView.snp.trailing).offset(28)
        }
        self.tagLabel.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(122)
            $0.leading.equalTo(self.mainView.snp.leading).offset(24)
        }
        self.postImageView.snp.makeConstraints{
            $0.top.equalTo(self.tagLabel.snp.bottom).offset(8)
            $0.leading.equalTo(self.mainView.snp.leading).offset(23)
            $0.size.height.equalTo(342)
            $0.size.width.equalTo(342)
        }
        self.contentLabel.snp.makeConstraints{
            $0.top.equalTo(self.postImageView.snp.bottom).offset(28)
            $0.leading.equalTo(self.mainView.snp.leading).offset(30)
            $0.trailing.equalTo(self.mainView.snp.trailing).offset(32)
        }
        
        
    }
    
//MARK: - AddTarget
    private func addTarget() {
        
    }
    
}





