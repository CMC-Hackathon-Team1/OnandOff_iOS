//
//  FeedWithHome.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/12.
//

import UIKit

final class FeedCellWithHome: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "FeedCell"
    
    weak var delegate: FeedDelegate?
    
    let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 24
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
    }
    
    let hastagLabel = UILabel().then {
        $0.font = .notoSans(size: 14, family: .Bold)
        $0.textColor = .black
    }
    
    let imgPageView = ImgPageControlView().then {
        $0.isHidden = true
    }
    
    private let heartButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "heart.fill"), for: .normal)
    }
    
    private let likeCountLabel = UILabel().then {
        $0.font = .notoSans(size: 11, family: .Regular)
        $0.textColor = #colorLiteral(red: 0.5924945474, green: 0.5924944878, blue: 0.5924944282, alpha: 1)
        $0.text = "0"
        $0.sizeToFit()
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.addSubView()
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selector
    @objc private func didClickEllipsisButton(_ button: UIButton) {
        self.delegate?.didClickEllipsisButton(id: button.tag)
    }
    
    //MARK: - Configure
    private func configure() {
        self.backgroundColor = .white
//        self.layer.cornerRadius = 8
//        self.layer.shadowColor = UIColor.lightGray.cgColor
//        self.layer.shadowOffset = .init(width: 1, height: 1)
//        self.layer.shadowOpacity = 0.7
//        self.layer.position = self.center
    }
    
    func configureCell(_ profileItem: ProfileItem, item: MyPageItem) {
        self.profileImageView.loadImage(profileItem.profileImgUrl)
        self.nameLabel.text = "\(profileItem.profileName) \(profileItem.personaName)"
        self.contentLabel.text = item.feedContent
        self.likeCountLabel.text = "\(item.likeNum)"
        self.dateLabel.text = self.convertDateFormat(item.createdAt)
        self.subLayout(item: item)
        self.imgPageView.setImageSlider(images: item.feedImgList)
        self.hastagLabel.text = "#" + item.hashTagList.joined(separator: "#")
    }
    
    override func prepareForReuse() {
        self.imgPageView.isHidden = true
        self.profileImageView.image = nil
        self.imgPageView.resetImageView()
        self.hastagLabel.text = nil
        self.imgPageView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        self.contentLabel.snp.updateConstraints {
            $0.top.equalTo(self.imgPageView.snp.bottom)
        }
    }
    
    private func subLayout(item: MyPageItem) {
        if item.feedImgList != [] {
            self.imgPageView.isHidden = false
            self.imgPageView.snp.updateConstraints {
                $0.height.equalTo(303)
            }
            self.contentLabel.snp.updateConstraints {
                $0.top.equalTo(self.imgPageView.snp.bottom).offset(16)
            }
        }
    }
    
    private func convertDateFormat(_ oldDate: String) -> String {
        var newDate = ""
        if let idx = oldDate.firstIndex(of: "T") {
            newDate = String(oldDate.prefix(upTo: idx)).replacingOccurrences(of: "-", with: "/")
        }
        
        return newDate
    }
    
    //MARK: - addSubView
    private func addSubView() {
        self.addSubview(self.profileImageView)
        self.addSubview(self.contentLabel)
        self.addSubview(self.nameLabel)
        self.addSubview(self.dateLabel)
        self.addSubview(self.imgPageView)
        self.addSubview(self.hastagLabel)
        self.addSubview(self.likeCountLabel)
        self.addSubview(self.heartButton)
    }
    
    //MARK: - layout
    private func layout() {
        self.profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
            $0.width.height.equalTo(48)
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
            $0.top.equalTo(self.imgPageView.snp.bottom)
            $0.trailing.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        self.heartButton.snp.makeConstraints {
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-25)
            $0.width.height.equalTo(18)
        }
        
        self.likeCountLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.heartButton.snp.centerX)
            $0.top.equalTo(self.heartButton.snp.bottom).offset(2)
        }
        
        self.imgPageView.snp.remakeConstraints {
            $0.top.equalTo(self.hastagLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(0)
        }
        
        self.hastagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(20)
        }
    }
}
