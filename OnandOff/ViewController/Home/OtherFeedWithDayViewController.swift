//
//  OtherFeedWithDayViewController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/16.
//

import UIKit

final class OtherFeedWithDayViewController: UIViewController {
    //MARK: - Properties
    private let profile: ProfileItem
    private var feedDatas: [FeedInfo] = []
    
    private let frameView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 1
        $0.layer.shadowOffset = .zero
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let backButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(OtherFeedCellWithDay.self, forCellWithReuseIdentifier: OtherFeedCellWithDay.identifier)
        $0.backgroundColor = .white
    }
    
    private let ellipsisButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    init(profile: ProfileItem, feedId: Int) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
        let profileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        FeedService.fetchOtherFeed(profileId, feedId: feedId) { item in
            self.feedDatas = [item]
            self.feedCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layout()
        
        self.feedCollectionView.delegate = self
        self.feedCollectionView.dataSource = self
        
        self.backButton.addTarget(self, action: #selector(self.dismissVC), for: .touchUpInside)
        self.ellipsisButton.addTarget(self, action: #selector(self.showAlert), for: .touchUpInside)
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true)
    }
    
    @objc private func showAlert() {
        let actionSheet = StandardActionSheetViewcontroller(title: "신고하기")
        let report = StandardActionSheetAction(title: "게시글 신고하기", image: UIImage(named: "Warning")?.withRenderingMode(.alwaysOriginal)) { _ in
            let reportVC = UINavigationController(rootViewController: ReportViewController(self.feedDatas[0].feedId))
            reportVC.modalPresentationStyle = .fullScreen
            self.present(reportVC, animated: true)
        }
        actionSheet.modalPresentationStyle = .overFullScreen
        actionSheet.addAction(report)
        self.present(actionSheet, animated: true)
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.view.addSubview(self.frameView)
        
        self.frameView.addSubview(self.ellipsisButton)
        self.frameView.addSubview(self.backButton)
        self.frameView.addSubview(self.feedCollectionView)
    }
    
    //MARK: - LayOut
    private func layout() {
        self.frameView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(70)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        self.backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(28)
            $0.top.equalToSuperview().offset(20)
            $0.width.height.equalTo(15)
        }
        
        self.ellipsisButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-27)
            $0.top.equalToSuperview().offset(20)
            $0.width.height.equalTo(15)
        }
        
        self.feedCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.backButton.snp.bottom).offset(14)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension OtherFeedWithDayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.feedDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherFeedCellWithDay.identifier, for: indexPath) as! OtherFeedCellWithDay
        cell.prepareForReuse()
        cell.delegate = self
        cell.configureCell(item: self.feedDatas[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = self.feedDatas[indexPath.row]
        let contentText: NSString = data.feedContent as NSString
        var imgViewHeight: CGFloat = 0
        let contentSize = contentText.boundingRect(with: CGSize(width: self.view.frame.width - 88, height: CGFloat.greatestFiniteMagnitude),
                                                   options: .usesLineFragmentOrigin,
                                                   attributes: [.font : UIFont.notoSans(size: 14)],
                                                   context: nil)
        if data.feedImgList != [] {
            imgViewHeight = (303 + 20) // 이미지뷰 크기 303 위 아래 여백 10 + 20
        }
        
        let width = collectionView.bounds.width
        
        return CGSize(width: width-48, height: contentSize.height + imgViewHeight + 20 + 42 + 20 + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 2, height: 2)
    }
}

extension OtherFeedWithDayViewController: FeedDelegate {
    func didClickFollowButtonn(id: Int) {
        let myProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        FeedService.togglefollow(fromProfileId: myProfileId, toProfileId: self.profile.profileId) { isFollow in
            NotificationCenter.default.post(name: .clickFollow, object: self.profile.profileId)
            self.feedDatas[0].isFollowing = isFollow
            self.feedCollectionView.reloadData()
        }
    }
    
    func didClickHeartButton(id: Int) {
        let myProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        FeedService.toggleLike(profileId: myProfileId, feedId: self.feedDatas[0].feedId) { isLike in
            NotificationCenter.default.post(name: .clickHeart, object: self.feedDatas[0].feedId, userInfo: ["isLike" : isLike])
            self.feedDatas[0].isLike = isLike
            self.feedCollectionView.reloadData()
        }
    }
}
