//
//  MyPageViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit

final class MyPageViewController: UIViewController {
    // MARK: - Properties
    private var MyPageFeedData: [MyPageItem] = [] {
        didSet {
            self.guideLabel.isHidden = !self.MyPageFeedData.isEmpty
        }
    }
    private var hasNextPage: Bool = true
    private var isPaging: Bool = false
    private var currentPage: Int = 1
    private var currentProfileId: Int = 0 {
        didSet {
            self.MyPageFeedData = []
            self.hasNextPage = true
            self.currentPage = 1
        }
    }
    
    private let guideLabel = UILabel().then {
        $0.textColor = .text3
        $0.font = .notoSans(size: 16)
        $0.text = "게시글이 존재하지 않습니다."
        $0.isHidden = true
    }
    
    private let profileView = ProfileView()
    
    private let calendarHeaderView = CalendarHeader()
    
    private let myPageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(MyPageCell.self, forCellWithReuseIdentifier: MyPageCell.identifier)
        $0.backgroundColor = .white
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubView()
        self.layout()
        self.configureNavigation()
        self.setRefreshControl()
        
        self.myPageCollectionView.dataSource = self
        self.myPageCollectionView.delegate = self
        self.calendarHeaderView.delegate = self
        self.currentProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        
        MyPageService.fetchProfile(self.currentProfileId) { [weak self] item in
            self?.profileView.configureProfile(item)
        }
        
        // 선택된 ProfileId 변경 옵저버 추가 -> 변경시 nextpage = true feeddata 빈배열 currentPage = 1로 바꿔주기.
        NotificationCenter.default.addObserver(self, selector: #selector(changeProfileId), name: .changeProfileId, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeFeed), name: .changeFeed, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MyPageFeedData.isEmpty {
            MyPageService.fetchFeedWithDate(self.currentProfileId, targetId: self.currentProfileId, year: self.calendarHeaderView.getYear,
                                            month: self.calendarHeaderView.getMonth, day: nil, page: self.currentPage) { [weak self] items in
                self?.MyPageFeedData = items
                self?.myPageCollectionView.reloadData()
            }
        }
    }
    
    private func setRefreshControl() {
        self.myPageCollectionView.refreshControl = UIRefreshControl().then {
            $0.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        }
    }
    
    // MARK: - Method
    private func paging() {
        self.isPaging = true
        self.currentPage += 1
        MyPageService.fetchFeedWithDate(self.currentProfileId, targetId: self.currentProfileId, year: self.calendarHeaderView.getYear, month: self.calendarHeaderView.getMonth, day: nil, page: self.currentPage) { [weak self] items in
            if items.isEmpty { self?.hasNextPage = false }
            self?.MyPageFeedData.append(contentsOf: items)
            self?.isPaging = false
            self?.myPageCollectionView.reloadData()
        }
    }
    
    // MARK: - Selector
    @objc private func didClickEditButton(_ button: UIButton) {
        let controller = EditProfileViewController(self.currentProfileId)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func changeProfileId() {
        self.currentProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        MyPageService.fetchProfile(self.currentProfileId) { [weak self] item in
            self?.profileView.configureProfile(item)
        }
    }
    
    @objc private func pullToRefresh(_ refresh: UIRefreshControl) {
        self.MyPageFeedData = []
        self.currentPage = 1
        self.hasNextPage = true
        
        MyPageService.fetchFeedWithDate(self.currentProfileId, targetId: self.currentProfileId, year: self.calendarHeaderView.getYear, month: self.calendarHeaderView.getMonth, day: nil, page: self.currentPage) { [weak self] items in
            if items.isEmpty { self?.hasNextPage = false }
            self?.MyPageFeedData.append(contentsOf: items)
            self?.myPageCollectionView.reloadData()
            refresh.endRefreshing()
        }
    }
    
    @objc private func didChangeFeed(notification: Notification) {
        guard let model = notification.object as? MypageTempModel else { return }
        if let idx = self.MyPageFeedData.firstIndex(where: { $0.feedId == model.feedId }) {
            self.MyPageFeedData[idx].feedContent = model.feedContent
            self.myPageCollectionView.reloadItems(at: [IndexPath(item: idx, section: 0)])
        }
    }
    
    // MARK: - configureNavigation
    private func configureNavigation() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        self.navigationItem.title = "마이페이지"
        
        let editBarButtonItem = UIBarButtonItem(title: "편집",
                                                style: .plain,
                                                target: self,
                                                action: #selector(self.didClickEditButton(_:)))
        editBarButtonItem.setTitleTextAttributes([.foregroundColor : UIColor.mainColor], for: .normal)
        self.navigationItem.rightBarButtonItem = editBarButtonItem
    }
    
    // MARK: - AddsubView
    private func addSubView() {
        self.view.addSubview(self.profileView)
        self.view.addSubview(self.calendarHeaderView)
        self.view.addSubview(self.myPageCollectionView)
        self.view.addSubview(self.guideLabel)
    }
    
    // MARK: - Layout
    private func layout() {
        self.profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(66)
        }
        
        self.calendarHeaderView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.profileView.snp.bottom).offset(17)
            $0.height.equalTo(24)
        }
        
        self.myPageCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.calendarHeaderView.snp.bottom).offset(17)
            $0.bottom.equalToSuperview()
        }
        
        self.guideLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

extension MyPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.MyPageFeedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCell.identifier, for: indexPath) as! MyPageCell
        cell.prepareForReuse()
        cell.delegate = self
        cell.configureCell(self.MyPageFeedData[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 2)
    }
}

//MARK: - CollectionViewDelegate
extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = self.MyPageFeedData[indexPath.row]
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

//MARK: - ScrollViewDelegate
extension MyPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight - height) {
            if isPaging == false && hasNextPage { self.paging() }
        }
    }
}

//MARK: - CalendarHeaderDelegate
extension MyPageViewController: CalendarHeaderDelegate {
    func changeMonth() {
        self.MyPageFeedData = []
        self.currentPage = 1
        self.hasNextPage = true
        
        MyPageService.fetchFeedWithDate(self.currentProfileId, targetId: self.currentProfileId, year: self.calendarHeaderView.getYear,
                                        month: self.calendarHeaderView.getMonth, day: nil) { [weak self] items in
            self?.MyPageFeedData = items
            self?.myPageCollectionView.reloadData()
        }
    }
}

extension MyPageViewController: FeedDelegate {
    func didClickEllipsisButton(id: Int) {
        let actionSheet = ActionSheetViewController(title: "글 편집",
                                                    firstImage: UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
                                                    firstText: "수정",
                                                    secondImage: UIImage(named: "delete")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
                                                    secondText: "삭제")
        actionSheet.id = id
        actionSheet.delegate = self
        actionSheet.modalPresentationStyle = .fullScreen
        self.present(actionSheet, animated: false)
    }
}

extension MyPageViewController: ActionSheetDelegate {
    func didClickFirstItem(id: Int) {
        MyPageService.fetchProfile(self.currentProfileId) { [weak self] item in
            let postVC = UINavigationController(rootViewController: PostViewController(item, feedId: id))
            postVC.modalPresentationStyle = .fullScreen
            self?.present(postVC, animated: true)
        }
    }
    
    func didClickSecondItem(id: Int) {
        let alert = StandardAlertController(title: "이 글을 정말로 삭제하시겠습니까?", message: nil)
        alert.titleHighlight(highlightString: "삭제", color: .point)
        let cancel = StandardAlertAction(title: "취소", style: .cancel)
        let ok = StandardAlertAction(title: "삭제", style: .basic) { _ in
            FeedService.deleteFeed(profileId: self.currentProfileId, feedId: id) {
                if let idx = self.MyPageFeedData.firstIndex(where: { $0.feedId == id }) {
                    self.MyPageFeedData.remove(at: idx)
                    self.myPageCollectionView.reloadData()
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: false)
    }
}
