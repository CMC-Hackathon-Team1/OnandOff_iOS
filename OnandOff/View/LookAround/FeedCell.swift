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
    weak var delegate: LookAroundDelegate?
    
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
    
    let imgPageView = ImgPageControlView().then {
        $0.isHidden = true
    }
    
    let followButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "follow")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    let heartButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    let ellipsisButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.addSubView()
        self.layout()
        self.addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selector
    @objc private func didClickFollowButton(_ button: UIButton) {
        delegate?.didClickFollow(button.tag)
    }
    
    @objc private func didClickHeartButton(_ button: UIButton) {
        delegate?.didClickHeart(button.tag)
    }
    
    @objc private func didClickEllipsisButton(_ button: UIButton) {
        delegate?.didClickEllipsis()
    }
    
    //MARK: - Configure
    private func configure() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = .init(width: 1, height: 1)
        self.layer.shadowOpacity = 0.7
        self.layer.position = self.center
    }
    
    func configureCell(_ item: FeedItem) {
        let heartImageName = item.isLike ? "heart.fill" : "heart"
        let followImageName = item.isFollowing ? "following" :"follow"
        
        self.followButton.setImage(UIImage(named: followImageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.heartButton.setImage(UIImage(named: heartImageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.profileImageView.loadImage(item.profileImg)
        self.contentLabel.text = item.feedContent
        self.nameLabel.text = item.personaName
        self.dateLabel.text = item.createdAt
        self.followButton.tag = item.profileId
        self.heartButton.tag = item.feedId
        self.subLayout(item: item)
        self.imgPageView.setImageSlider(images: item.feedImgList)
    }
    
    override func prepareForReuse() {
        self.imgPageView.isHidden = true
        self.profileImageView.image = nil
        self.imgPageView.resetImageView()
        self.imgPageView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
    }
    
    private func subLayout(item: FeedItem) {
        if item.feedImgList != [] {
            self.imgPageView.isHidden = false
            self.imgPageView.snp.updateConstraints {
                $0.height.equalTo(303)
            }
        }
    }
    //MARK: - addSubView
    private func addSubView() {
        self.addSubview(self.profileImageView)
        self.addSubview(self.contentLabel)
        self.addSubview(self.nameLabel)
        self.addSubview(self.dateLabel)
        self.addSubview(self.heartButton)
        self.addSubview(self.followButton)
        self.addSubview(self.ellipsisButton)
        self.addSubview(self.imgPageView)
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
        
//        self.contentLabel.snp.makeConstraints {
//            $0.top.equalTo(self.profileImageView.snp.bottom).offset(25)
//            $0.bottom.trailing.equalToSuperview().offset(-20)
//            $0.leading.equalToSuperview().offset(20)
//        }
        self.contentLabel.snp.remakeConstraints {
            $0.top.equalTo(self.imgPageView.snp.bottom).offset(0)
            $0.bottom.trailing.equalToSuperview().offset(-20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        self.heartButton.snp.makeConstraints {
            $0.trailing.equalTo(self.ellipsisButton.snp.leading).offset(-13)
            $0.width.height.equalTo(22)
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
        }
        
        self.followButton.snp.makeConstraints {
            $0.trailing.equalTo(self.heartButton.snp.leading).offset(-13)
            $0.width.height.equalTo(22)
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
        }
        
        self.ellipsisButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-15)
            $0.width.height.equalTo(22)
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
        }
        
        self.imgPageView.snp.remakeConstraints {
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(0)
        }
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.heartButton.addTarget(self, action: #selector(self.didClickHeartButton), for: .touchUpInside)
        self.followButton.addTarget(self, action: #selector(self.didClickFollowButton), for: .touchUpInside)
        self.ellipsisButton.addTarget(self, action: #selector(self.didClickEllipsisButton(_:)), for: .touchUpInside)
    }
}
