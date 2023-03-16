//
//  OtherFeedCellWithDay.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/16.
//

import UIKit

final class OtherFeedCellWithDay: UICollectionViewCell {
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
    
    let hashtagLabel = UILabel().then {
        $0.font = .notoSans(size: 14, family: .Bold)
        $0.textColor = .black
    }
    
    let imgPageView = ImgPageControlView().then {
        $0.isHidden = true
    }
    
    private let heartButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "heart.fill")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let followButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "follow")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
        delegate?.didClickFollowButtonn(id: button.tag)
    }
    
    @objc private func didClickHeartButton(_ button: UIButton) {
        delegate?.didClickHeartButton(id: button.tag)
    }
    
    //MARK: - Configure
    private func configure() {
        self.backgroundColor = .white
    }
    
    func configureCell(item: FeedInfo) {
        self.profileImageView.loadImage(item.profileImg)
        self.nameLabel.text = "\(item.profileName) \(item.personaName)"
        self.contentLabel.text = "\(item.feedContent)"
        self.dateLabel.text = item.createdAt
        self.subLayout(item: item)
        self.imgPageView.setImageSlider(images: item.feedImgList)
        self.hashtagLabel.text = "#" + item.hashTagList.joined(separator: "#")
        
        let heartImage = item.isLike ? UIImage(named: "heart.fill") : UIImage(named: "heart")
        let followImage = item.isFollowing ? UIImage(named: "following") : UIImage(named: "follow")
        
        self.heartButton.setImage(heartImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.followButton.setImage(followImage?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    override func prepareForReuse() {
        self.imgPageView.isHidden = true
        self.profileImageView.image = nil
        self.imgPageView.resetImageView()
        self.hashtagLabel.text = nil
        self.imgPageView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        self.contentLabel.snp.updateConstraints {
            $0.top.equalTo(self.imgPageView.snp.bottom)
        }
    }
    
    private func subLayout(item: FeedInfo) {
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
        self.addSubview(self.hashtagLabel)
        self.addSubview(self.followButton)
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
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(18)
        }
        
        self.followButton.snp.makeConstraints {
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
            $0.trailing.equalTo(self.heartButton.snp.leading).offset(-10)
            $0.width.height.equalTo(18)
        }
        
        self.imgPageView.snp.remakeConstraints {
            $0.top.equalTo(self.hashtagLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(0)
        }
        
        self.hashtagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(20)
        }
    }
    
    private func addTarget() {
        self.followButton.addTarget(self, action: #selector(self.didClickFollowButton), for: .touchUpInside)
        self.heartButton.addTarget(self, action: #selector(self.didClickHeartButton), for: .touchUpInside)
    }
}
