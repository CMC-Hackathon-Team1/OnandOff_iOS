//
//  FeedCell.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2023/01/01.
//

import UIKit

final class FeedCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "FeedCell"
    
    let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 21
        $0.backgroundColor = .lightGray
        $0.clipsToBounds = true
    }
    
    let nameLabel = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Bold)
        $0.textColor = .text1
        $0.text = "디자이너 키키"
    }
    
    let dateLabel = UILabel().then {
        $0.font = .notoSans(size: 11, family: .Regular)
        $0.textColor = .text4
        $0.text = "어제"
    }
    
    let contentLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .notoSans(size: 14)
        $0.textColor = .text1
        $0.text = "예전의 어린 나는 가슴 속에 나침반이 하나 있었다. 그래서 어디로 가야 할지 모를 때 가슴 속의 나침반이 나의 길로 나를 이끌었다. 언제부터인가 나는 돈에 집착하기 시작했고 가슴 속의 나침반은 더이상 작동하지 않았다. "
    }
    
    let followButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "follow"), for: .normal)
    }
    
    let heartButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "heart"), for: .normal)
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = .init(width: 1, height: 1)
        self.layer.shadowOpacity = 0.7
        self.layer.position = self.center
        
        self.addSubView()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - addSubView
    private func addSubView() {
        self.addSubview(self.profileImageView)
        self.addSubview(self.contentLabel)
        self.addSubview(self.nameLabel)
        self.addSubview(self.dateLabel)
        self.addSubview(self.heartButton)
        self.addSubview(self.followButton)
    }
    
    //MARK: - layout
    private func layout() {
        self.profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
            $0.width.height.equalTo(42)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(12)
            $0.centerY.equalTo(self.profileImageView.snp.centerY).offset(-6)
        }
        
        self.dateLabel.snp.makeConstraints {
            $0.leading.equalTo(self.nameLabel.snp.leading)
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(2)
        }
        
        self.contentLabel.snp.makeConstraints {
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(25)
            $0.bottom.trailing.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        self.heartButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-15)
            $0.width.height.equalTo(22)
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
        }
        
        self.followButton.snp.makeConstraints {
            $0.trailing.equalTo(self.heartButton.snp.leading).offset(-13)
            $0.width.height.equalTo(22)
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
        }
    }
}
