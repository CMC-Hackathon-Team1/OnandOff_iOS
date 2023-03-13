//
//  LookAroundViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit

final class LookAroundViewController: UIViewController {
    //MARK: - Properties
    private var currentCategoryId = 0
    private var currentProfileId = 0
    
    private var explorationDatas: [FeedItem] = []
    private var followingDatas: [FeedItem] = []
    
    private var explorationPage: Int = 1
    private var followingPage: Int = 1
    private var isPaging: Bool = false
    private var explorationHasNextPage: Bool = true
    private var followingHasNextPage: Bool = true
    
    private let topTabbar = CustomTopTabbar()
    
    private var searchBar = UISearchBar().then {
        $0.placeholder = "해시태그 검색"
        $0.setImage(UIImage(named: "magnifyingglass"), for: .search, state: .normal)
        $0.setImage(UIImage(named: "Icon"), for: .clear, state: .normal)
    }
    
    private let categoryButton = UIButton().then {
        $0.setTitle("카테고리 전체 ▾", for: .normal)
        $0.setTitleColor(.text1, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 14)
    }
    
    private let explorationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
    }
    
    private let followingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
        $0.isHidden = true
    }
    
    private let guideLabel = UILabel().then {
        $0.font = .notoSans(size: 12)
        $0.textColor = .black
        $0.text = "검색 결과가 없습니다."
        $0.isHidden = false
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubView()
        self.layout()
        self.addTarget()
        self.configureNavigation()
        self.setRefreshControl()
        
        self.explorationCollectionView.delegate = self
        self.explorationCollectionView.dataSource = self
        
        self.followingCollectionView.delegate = self
        self.followingCollectionView.dataSource = self
        self.topTabbar.delegate = self
        self.searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectCategory), name: .selectCategory, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didClickReportButton), name: .presentReportVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeProfileId), name: .changeProfileId, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toggleFollow), name: .clickFollow, object: nil)
        
        self.currentProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        self.fetchFeed(profileId: self.currentProfileId, text: nil)
    }
    
    //MARK: - Method
    private func configureNavigation() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.backBarButtonItem?.tintColor = . black
        
        self.navigationItem.titleView = self.searchBar
    }
    
    private func setRefreshControl() {
        self.explorationCollectionView.refreshControl = UIRefreshControl().then {
            $0.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        }
        self.followingCollectionView.refreshControl = UIRefreshControl().then {
            $0.addTarget(self, action: #selector(self.pullToRefresh(_:)), for: .valueChanged)
        }
    }
    
    private func fetchFeed(profileId: Int, text: String?, isReset: Bool = false, completion: (() -> ())? = nil) {
        let profileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        let isFollowing = self.topTabbar.selectedItem == .following
        let text = text ?? ""
        if isReset { self.resetData() }
        self.guideLabel.isHidden = true
        
        if !text.isEmpty {
            if isFollowing {
                FeedService.searchFeed(profileId, text: text, categoryId: self.currentProfileId, page: self.followingPage, fResult: isFollowing) { list in
                    if list.isEmpty { self.followingHasNextPage = false }
                    self.followingDatas.append(contentsOf: list)
                    self.followingCollectionView.reloadData()
                    if self.followingDatas.isEmpty { self.guideLabel.isHidden = false }
                    
                    completion?()
                }
            } else {
                FeedService.searchFeed(profileId, text: text, categoryId: self.currentCategoryId, page: self.followingPage, fResult: isFollowing) { list in
                    if list.isEmpty { self.explorationHasNextPage = false }
                    self.explorationDatas.append(contentsOf: list)
                    self.explorationCollectionView.reloadData()
                    if self.explorationDatas.isEmpty { self.guideLabel.isHidden = false }
            
                    completion?()
                }
            }
        } else {
            if isFollowing {
                FeedService.fetchFeed(profileId, categoryId: self.currentCategoryId, page: self.followingPage, fResult: isFollowing) { list in
                    if list.isEmpty { self.followingHasNextPage = false }
                    self.followingDatas.append(contentsOf: list)
                    self.followingCollectionView.reloadData()
                    if self.followingDatas.isEmpty { self.guideLabel.isHidden = false }
                    
                    completion?()
                }
            } else {
                FeedService.fetchFeed(profileId, categoryId: self.currentCategoryId, page: self.explorationPage, fResult: isFollowing) { list in
                    if list.isEmpty { self.explorationHasNextPage = false }
                    self.explorationDatas.append(contentsOf: list)
                    self.explorationCollectionView.reloadData()
                    if self.explorationDatas.isEmpty { self.guideLabel.isHidden = false }
                    
                    completion?()
                }
            }
        }
    }
    
    private func resetData() {
        self.followingDatas = []
        self.explorationDatas = []
        self.explorationPage = 1
        self.followingPage = 1
        self.explorationHasNextPage = true
        self.followingHasNextPage = true
    }
    
    private func paging() {
        self.isPaging = true
        if self.topTabbar.selectedItem == .following {
            self.followingPage += 1
        } else {
            self.explorationPage += 1
        }
        self.fetchFeed(profileId: self.currentProfileId, text: self.searchBar.text) {
            self.isPaging = false
        }
    }
    
    //MARK: - Selector
    @objc private func didClickCategory(_ button: UIButton) {
        let ASFrame = CGRect(x: button.frame.origin.x, y: button.frame.origin.y + button.frame.height + 12, width: 165, height: 160)
        let categoryActionSheet = CustomActionSheet(frame: self.view.frame, ASFrame: ASFrame, currentCategoryId: self.currentCategoryId)
        self.view.addSubview(categoryActionSheet)
    }
    
    @objc private func didSelectCategory(_ notification: Notification) {
        if let item = notification.object as? CategoryItem {
            self.categoryButton.setTitle(item.categoryName + " ▾", for: .normal)
            self.currentCategoryId = item.categoryId
        } else { // 전체 카테고리 선택시
            self.categoryButton.setTitle("카테고리 전체 ▾", for: .normal)
            self.currentCategoryId = 0
        }
        
        self.fetchFeed(profileId: self.currentProfileId, text: self.searchBar.text, isReset: true)
    }
    
    @objc private func pullToRefresh(_ refresh: UIRefreshControl) {
        if self.topTabbar.selectedItem == .following {
            self.followingDatas = []
            self.followingPage = 1
            self.followingHasNextPage = true
        } else {
            self.explorationDatas = []
            self.explorationPage = 1
            self.explorationHasNextPage = true
        }
        self.fetchFeed(profileId: self.currentProfileId, text: self.searchBar.text) {
            refresh.endRefreshing()
        }
    }
    
    @objc private func didClickReportButton(_ notification: Notification) {
        guard let feedId = notification.object as? Int else { return }
        let reportVC = ReportViewController(feedId)
        self.navigationController?.pushViewController(reportVC, animated: false)
    }
    
    @objc private func didChangeProfileId() {
        self.currentProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        self.fetchFeed(profileId: self.currentProfileId, text: self.searchBar.text, isReset: true)
    }
    
    @objc private func toggleFollow(notification: Notification) {
        guard let toProfileId = notification.object as? Int else { return }
        self.explorationDatas.enumerated().forEach { (i,v) in
            if v.profileId == toProfileId {
                v.isFollowing = !v.isFollowing
                self.explorationCollectionView.reloadItems(at: [IndexPath(item: i, section: 0)])
            }
        }
        
        self.followingDatas.enumerated().forEach { (i,v) in
            if v.profileId == toProfileId {
                v.isFollowing = !v.isFollowing
                self.followingCollectionView.reloadItems(at: [IndexPath(item: i, section: 0)])
            }
        }
    }
    
    //MARK: - addSubView
    private func addSubView() {
        self.view.addSubview(self.topTabbar)
        self.view.addSubview(self.categoryButton)
        self.view.addSubview(self.explorationCollectionView)
        self.view.addSubview(self.followingCollectionView)
        self.view.addSubview(self.guideLabel)
    }
    
    //MARK: - Layout
    private func layout() {
        self.topTabbar.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(32)
        }
        
        self.categoryButton.snp.makeConstraints {
            $0.leading.equalTo(24)
            $0.top.equalTo(self.topTabbar.snp.bottom).offset(15)
        }
        
        self.guideLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        
        self.explorationCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.categoryButton.snp.bottom).offset(12)
            $0.bottom.trailing.leading.equalToSuperview()
        }
        
        self.followingCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.categoryButton.snp.bottom).offset(12)
            $0.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.categoryButton.addTarget(self, action: #selector(self.didClickCategory(_:)), for: .touchUpInside)
    }
}

extension LookAroundViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == explorationCollectionView ? explorationDatas.count : followingDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        cell.prepareForReuse()
        cell.delegate = self

        if collectionView == explorationCollectionView {
            let data = self.explorationDatas[indexPath.row]
            cell.configureCell(data)
        } else {
            let data = self.followingDatas[indexPath.row]
            cell.configureCell(data)
        }
        
        return cell
    }
}

// MARK: - CollectionView Delegate
extension LookAroundViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = collectionView == explorationCollectionView ? self.explorationDatas[indexPath.row] : followingDatas[indexPath.row]
        let contentText: NSString = data.feedContent as NSString
        var imgViewHeight: CGFloat = 0
        var hashTagLabelHeight: CGFloat = 0
        let contentSize = contentText.boundingRect(with: CGSize(width: self.view.frame.width - 88, height: CGFloat.greatestFiniteMagnitude),
                                                   options: .usesLineFragmentOrigin,
                                                   attributes: [.font : UIFont.notoSans(size: 14)],
                                                   context: nil)
        let hashtagText: NSString = "#" + data.hashTagList.joined(separator: " #") as NSString
        let hashtagSize = hashtagText.boundingRect(with: CGSize(width: self.view.frame.width - 88, height: CGFloat.greatestFiniteMagnitude),
                                                 options: .usesLineFragmentOrigin,
                                                 attributes: [.font : UIFont.notoSans(size: 14, family: .Bold)],
                                                 context: nil)
        // 이미지뷰 크기 303 위 아래 여백 10 + 20
        if data.feedImgList != [] { imgViewHeight = (303 + 10 + 20) }
        if data.hashTagList != [] { hashTagLabelHeight = hashtagSize.height}
        
        return CGSize(width: UIScreen.main.bounds.width - 48 , height: contentSize.height + imgViewHeight + 110 + hashTagLabelHeight) //아래 여백 20 + 위 여백 90
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height: 2)
    }
}

//MARK: - LookAround Delegate
extension LookAroundViewController: LookAroundDelegate {
    func didClickProfile(_ toProfileId: Int) {
        let otherVC = OtherProfileViewController(toProfileId)
        self.navigationController?.pushViewController(otherVC, animated: true)
    }
    
    func didClickEllipsis(_ feedId: Int) {
        _ = ReportActionSheet(feedId).then {
            $0.delegate = self
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            }
        }
    }
    
    func didClickHeart(_ feedId: Int) {
        FeedService.toggleLike(profileId: self.currentProfileId, feedId: feedId) { [weak self] in
            if let idx = self?.followingDatas.firstIndex(where: {$0.feedId == feedId }) {
                guard let isLike = self?.followingDatas[idx].isLike else { return }
                self?.followingDatas[idx].isLike = !isLike
                self?.followingCollectionView.reloadItems(at: [IndexPath(row: idx, section: 0)])
            }
            
            if let idx = self?.explorationDatas.firstIndex(where: {$0.feedId == feedId }) {
                guard let isLike = self?.explorationDatas[idx].isLike else { return }
                self?.explorationDatas[idx].isLike = !isLike
                self?.explorationCollectionView.reloadItems(at: [IndexPath(row: idx, section: 0)])
            }
        }
    }
    
    func didClickFollow(_ toProfileId: Int) {
        FeedService.togglefollow(fromProfileId: self.currentProfileId, toProfileId: toProfileId) { [weak self] in
            self?.explorationDatas.enumerated().forEach { (i,v) in
                if v.profileId == toProfileId {
                    v.isFollowing = !v.isFollowing
                    self?.explorationCollectionView.reloadItems(at: [IndexPath(item: i, section: 0)])
                }
            }
            
            self?.followingDatas.enumerated().forEach { (i,v) in
                if v.profileId == toProfileId {
                    v.isFollowing = !v.isFollowing
                    self?.followingCollectionView.reloadItems(at: [IndexPath(item: i, section: 0)])
                }
            }
        }
    }
}

//MARK: - SearchBar Delegate
extension LookAroundViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        self.fetchFeed(profileId: self.currentProfileId, text: searchBar.text, isReset: true)
    }
}

//MARK: - TopTapBar Delegate
extension LookAroundViewController: TopTapBarDelegate {
    func didClickFollwingItem() {
        self.followingCollectionView.isHidden = false
        self.explorationCollectionView.isHidden = true
        self.guideLabel.isHidden = true
        
        if followingDatas.isEmpty {
            self.fetchFeed(profileId: self.currentProfileId, text: self.searchBar.text)
        }
    }
    
    func didClickExplorationItem() {
        self.followingCollectionView.isHidden = true
        self.explorationCollectionView.isHidden = false
        self.guideLabel.isHidden = true
        
        if explorationDatas.isEmpty {
            self.fetchFeed(profileId: self.currentProfileId, text: self.searchBar.text)
        }
    }
}

//MARK: - ScrollViewDelegate
extension LookAroundViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if scrollView == explorationCollectionView {
            if offsetY > (contentHeight - height) {
                if isPaging == false && explorationHasNextPage { self.paging() }
            }
        } else {
            if offsetY > (contentHeight - height) {
                if isPaging == false && followingHasNextPage { self.paging() }
            }
        }
    }
}
