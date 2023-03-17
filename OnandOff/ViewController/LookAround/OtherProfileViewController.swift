//
//  OtherProfileViewController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/13.
//

import UIKit
import FSCalendar

final class OtherProfileViewController: UIViewController {
    //MARK: - Properties
    private let profileId: Int
    private var currentPage = 1
    private var feedDatas: [MyPageItem] = []
    
    private lazy var profileView = ProfileView(toProfileId: self.profileId)
    
    private let feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
        $0.register(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalendarHeaderView.identifier)
        $0.register(OtherFeedCell.self, forCellWithReuseIdentifier: OtherFeedCell.identifier)
    }
    
    init(_ profileId: Int) {
        self.profileId = profileId
        super.init(nibName: nil, bundle: nil)
        MyPageService.fetchProfile(profileId) { [weak self] item in
            self?.profileView.configureProfile(item)
            self?.fetchFeed()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layout()
        
        self.view.backgroundColor = .white

        self.navigationItem.title = "프로필"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationItem.backButtonTitle = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.presentFeed), name: .clickDay, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didChangeCurrentPage), name: .changeCurrentPage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.toggleFollow), name: .clickFollow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.toggleHeart), name: .clickHeart, object: nil)
    }
    
    private func fetchFeed() {
        let currentProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        let year = String(Calendar.current.component(.year, from: Date()))
        let month = String(format: "%02d", Calendar.current.component(.month, from: Date()))

        MyPageService.fetchFeedWithDate(currentProfileId, targetId: self.profileId, year: year,
                                        month: month, day: nil, page: self.currentPage) { [weak self] items in
            self?.feedDatas = items
            self?.feedCollectionView.delegate = self
            self?.feedCollectionView.dataSource = self
            self?.feedCollectionView.reloadData()
        }
    }
    
    @objc private func toggleFollow(notification: Notification) {
        let fromProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        FeedService.isFollowing(fromProfileId: fromProfileId, toProfileId: self.profileId) { isFollow in
            self.profileView.isFollow = isFollow
        }
    }
    
    @objc private func toggleHeart(notification: Notification) {
        guard let isLike = notification.userInfo?["isLike"] as? Bool else { return }
        if let feedId = notification.object as? Int {
            if let idx = self.feedDatas.firstIndex(where: {$0.feedId == feedId }) {
                self.feedDatas[idx].isLike = isLike
                self.feedCollectionView.reloadItems(at: [IndexPath(row: idx, section: 0)])
            }
        }
    }
    
    @objc private func presentFeed(notification: NSNotification) {
        guard let feedId = notification.object as? Int else { return }
        MyPageService.fetchProfile(self.profileId) { item in
            let feedVC = OtherFeedWithDayViewController(profile: item, feedId: feedId)
            
            self.present(feedVC, animated: true)
        }
    }
    
    @objc private func didChangeCurrentPage(notification: Notification) {
        guard let date = notification.object as? Date else { return }
        let currentProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        MyPageService.fetchFeedWithDate(currentProfileId, targetId: self.profileId, year: date.getYear, month: date.getMonth, day: nil) { [weak self] items in
            self?.feedDatas = items
            self?.feedCollectionView.reloadData()
        }
    }
    
    private func addSubView() {
        self.view.addSubview(self.profileView)
        self.view.addSubview(self.feedCollectionView)
    }
    
    private func layout() {
        self.profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(66)
        }
        
        self.feedCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(self.profileView.snp.bottom).offset(23)
        }
    }
}

//MARK: - CollectionDelegate
extension OtherProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedDatas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherFeedCell.identifier, for: indexPath) as! OtherFeedCell
        cell.prepareForReuse()
        cell.delegate = self

        cell.configureCell(self.feedDatas[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CalendarHeaderView.identifier, for: indexPath) as! CalendarHeaderView
            headerView.updateCalendar(self.profileId)
            return headerView
        default:
            return UIView() as! UICollectionReusableView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 300, height: 320)
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
        return CGSize(width: width-48, height: contentSize.height + imgViewHeight + 12+16+16+20)
    }
}

extension OtherProfileViewController: FeedDelegate {
    func didClickHeartButton(id: Int) {
        let myProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        FeedService.toggleLike(profileId: myProfileId, feedId: id) { [weak self] isLike in
            if let idx = self?.feedDatas.firstIndex(where: { $0.feedId == id }) {
                NotificationCenter.default.post(name: .clickHeart, object: id, userInfo: ["isLike" : isLike])
                self?.feedDatas[idx].isLike = isLike
                self?.feedCollectionView.reloadItems(at: [IndexPath(row: idx, section: 0)])
            }
        }
    }
    
    func didClickEllipsisButton(id: Int) {
        _ = ReportActionSheet(id).then {
            self.view.addSubview($0)
            $0.delegate = self
            $0.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            }
        }
    }
}

extension OtherProfileViewController: ReportViewDelegate {
    func presentReportViewController(_ feedId: Int) {
        let reportVC = ReportViewController(feedId)
        self.navigationController?.pushViewController(reportVC, animated: true)
    }
}