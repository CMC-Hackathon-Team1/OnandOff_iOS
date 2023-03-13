//
//  ProfileView.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2023/01/02.
//

import UIKit

final class ProfileView: UIView {
    //MARK: - Properties
    private var toProfileId: Int?
    
    var isFollow = false {
        didSet {
            if self.isFollow {
                self.followButton.setImage(UIImage(named: "following")?.withRenderingMode(.alwaysOriginal), for: .normal)
            } else {
                self.followButton.setImage(UIImage(named: "follow")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
        }
    }
    
    private let profileImageView = UIImageView().then {
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 26.5
        $0.backgroundColor = .lightGray
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "작가 키키"
        $0.textColor = .text1
        $0.font = .notoSans(size: 14, family: .Bold)
    }
    
    private let tagLabel = UILabel().then {
        $0.text = "#시#소설#에세이 좋아해요"
        $0.textColor = .text4
        $0.font = .notoSans(size: 12)
    }
    
    let followButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "follow")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.layout()
        self.configure()
        
        self.followButton.isHidden = true
    }
    
    init(toProfileId: Int) {
        self.toProfileId = toProfileId
        super.init(frame: .zero)
        self.addSubView()
        self.layout()
        self.configure()
        self.addTarget()
        
        self.followButton.isHidden = false
        let fromProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        FeedService.isFollowing(fromProfileId: fromProfileId, toProfileId: toProfileId) { isFollow in
            self.isFollow = isFollow
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .white
        self.layer.shadowOpacity = 1.0
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    func configureProfile(_ item: ProfileItem) {
        self.profileImageView.loadImage(item.profileImgUrl)
        self.nameLabel.text = item.profileName
        self.tagLabel.text = item.statusMessage
    }
    
    @objc private func didClickFollow() {
        let fromProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        FeedService.togglefollow(fromProfileId: fromProfileId, toProfileId: self.toProfileId!) {
            self.isFollow = !self.isFollow
            NotificationCenter.default.post(name: .clickFollow, object: self.toProfileId!)
        }
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.addSubview(self.profileImageView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.tagLabel)
        self.addSubview(self.followButton)
    }
    
    override func layoutSubviews() {
        let shadowRect = CGRect(x: 0, y: frame.height-1, width: frame.width, height: 4)
        self.layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: 0).cgPath
    }
    
    
    //MARK: - Layout
    private func layout() {
        self.profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview()
            $0.width.height.equalTo(53)
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(18)
            $0.centerY.equalTo(self.profileImageView.snp.centerY).offset(-8)
        }
        
        self.tagLabel.snp.makeConstraints {
            $0.leading.equalTo(self.nameLabel.snp.leading)
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(4)
        }
        
        self.followButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.width.equalTo(24)
        }
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.followButton.addTarget(self, action: #selector(self.didClickFollow), for: .touchUpInside)
    }
}
