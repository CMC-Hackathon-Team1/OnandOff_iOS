//
//  AlertViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//


import UIKit

final class AlertViewController: UIViewController{
    //MARK: - Properties
    private var likeFlag = false {
        didSet {
            let image = self.likeFlag ? UIImage(named: "switchOn")?.withRenderingMode(.alwaysOriginal) : UIImage(named: "switchOff")?.withRenderingMode(.alwaysOriginal)
            self.likeAlertSwitchButton.setImage(image, for: .normal)
        }
    }
    
    private var followingFlag = false {
        didSet {
            let image = self.followingFlag ? UIImage(named: "switchOn")?.withRenderingMode(.alwaysOriginal) : UIImage(named: "switchOff")?.withRenderingMode(.alwaysOriginal)
            self.followAlertSwitchButton.setImage(image, for: .normal)
        }
    }
    
    private var notiFlag = false {
        didSet {
            let image = self.notiFlag ? UIImage(named: "switchOn")?.withRenderingMode(.alwaysOriginal) : UIImage(named: "switchOff")?.withRenderingMode(.alwaysOriginal)
            self.notiAlertSwitchButton.setImage(image, for: .normal)
        }
    }
    
    private let likeAlertTitleLabel = UILabel().then {
        $0.text = "좋아요 소식받기"
        $0.textColor = .black
        $0.font = .notoSans(size: 14, family: .Bold)
    }
    
    private let likeAlertSubTitleLabel = UILabel().then {
        $0.text = "ex)개발자 온오프님이 회원님의 게시글을 좋아합니다."
        $0.textColor = .black
        $0.font = .notoSans(size: 12, family: .Regular)
    }
    
    private let likeAlertSwitchButton = UIButton()
    
    private let followAlertTitleLabel = UILabel().then {
        $0.text = "팔로잉 소식 받기"
        $0.textColor = .black
        $0.font = .notoSans(size: 14, family: .Bold)
    }
    
    private let followAlertSubTitleLabel = UILabel().then {
        $0.text = "ex)개발자 온오프님이 회원님을 팔로잉 합니다."
        $0.textColor = .black
        $0.font = .notoSans(size: 12, family: .Regular)
    }
    
    private let followAlertSwitchButton = UIButton()
    
    private let notiAlertTitleLabel = UILabel().then {
        $0.text = "관리자 공지사항 안내 받기"
        $0.textColor = .black
        $0.font = .notoSans(size: 14, family: .Bold)
    }
    
    private let notiAlertSubTitleLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .black
        $0.font = .notoSans(size: 12, family: .Regular)
    }
    
    private let notiAlertSwitchButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        AlarmService.getCurrentStatus() { item in
            self.likeFlag = item.likeAlarmStatus
            self.followingFlag = item.followAlarmStatus
            self.notiFlag = item.noticeAlarmStatus
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        self.addSubView()
        self.layout()
        self.addTarget()
        
        self.view.backgroundColor = .white
        self.title = "알림"
    }
    
    //MARK: - AddSubview
    private func addSubView() {
        self.view.addSubview(self.likeAlertTitleLabel)
        self.view.addSubview(self.likeAlertSubTitleLabel)
        self.view.addSubview(self.likeAlertSwitchButton)
        self.view.addSubview(self.followAlertTitleLabel)
        self.view.addSubview(self.followAlertSubTitleLabel)
        self.view.addSubview(self.followAlertSwitchButton)
        self.view.addSubview(self.notiAlertTitleLabel)
        self.view.addSubview(self.notiAlertSubTitleLabel)
        self.view.addSubview(self.notiAlertSwitchButton)
    }
    
    //MARK: - Selector
    @objc private func didClickNotificationSwitchButton() {
        AlarmService.changeNoticeAlert(!self.notiFlag) { flag in
            self.notiFlag = flag
        }
    }
    
    @objc private func didClickLikeSwitchButton() {
        AlarmService.changeLikeAlert(!self.likeFlag) { flag in
            self.likeFlag = flag
        }
    }
    
    @objc private func didClickFollowingSwitchButton() {
        AlarmService.changeFollowingAlert(!self.followingFlag) { flag in
            self.followingFlag = flag
        }
    }
    
    //MARK: - Layout
    private func layout() {
        self.likeAlertTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(17)
            $0.leading.equalToSuperview().offset(32)
        }
        
        self.likeAlertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.likeAlertTitleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(32)
        }
        
        self.likeAlertSwitchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-32)
            $0.centerY.equalTo(self.likeAlertTitleLabel.snp.bottom)
            $0.height.width.equalTo(40)
        }
        
        self.followAlertTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.likeAlertSubTitleLabel.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(32)
        }
        
        self.followAlertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.followAlertTitleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(32)
        }
        
        self.followAlertSwitchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-32)
            $0.centerY.equalTo(self.followAlertTitleLabel.snp.bottom)
            $0.height.width.equalTo(40)
        }
        
        self.notiAlertTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.followAlertSubTitleLabel.snp.bottom).offset(26)
            $0.leading.equalToSuperview().offset(32)
        }
        
        self.notiAlertSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.notiAlertTitleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(32)
        }
        
        self.notiAlertSwitchButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-32)
            $0.centerY.equalTo(self.notiAlertTitleLabel.snp.bottom)
            $0.height.width.equalTo(40)
        }
    }
    
    //MARK: - Target
    private func addTarget() {
        self.notiAlertSwitchButton.addTarget(self, action: #selector(self.didClickNotificationSwitchButton), for: .touchUpInside)
        self.likeAlertSwitchButton.addTarget(self, action: #selector(self.didClickLikeSwitchButton), for: .touchUpInside)
        self.followAlertSwitchButton.addTarget(self, action: #selector(self.didClickFollowingSwitchButton), for: .touchUpInside)
    }
}
