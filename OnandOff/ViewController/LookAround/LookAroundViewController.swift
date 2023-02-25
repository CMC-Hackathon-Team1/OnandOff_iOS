//
//  LookAroundViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit

final class LookAroundViewController: UIViewController {
    //MARK: - Properties
    private let topTabbar = CustomTopTabbar()
    private var feedDatas: [FeedItem] = []
    
    private let categoryButton = UIButton().then {
        $0.setTitle("카테고리 전체 ▾", for: .normal)
        $0.setTitleColor(.text1, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 14)
    }
    
    private let feedCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.identifier)
        $0.backgroundColor = .white
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubView()
        self.layout()
        self.addTarget()
        self.configureNavigation()
        
        self.feedCollectionView.delegate = self
        self.feedCollectionView.dataSource = self
        self.fetchFeed()
    }
    
    //MARK: - Method
    private func configureNavigation() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.backBarButtonItem?.tintColor = . black
        _ = UISearchBar().then {
            $0.placeholder = "해시태그 검색"
            $0.setImage(UIImage(named: "magnifyingglass"), for: .search, state: .normal)
            $0.setImage(UIImage(named: "Icon"), for: .clear, state: .normal)
            self.navigationItem.titleView = $0
        }
    }
    
    private func fetchFeed() {
        FeedService.fetchFeed(1610, categoryId: 0) { list in
            self.feedDatas = list
            self.feedCollectionView.reloadData()
        }
    }
    
    //MARK: - Selector
    @objc private func didClickCategory(_ button: UIButton) {
        let ASFrame = CGRect(x: button.frame.origin.x, y: button.frame.origin.y + button.frame.height + 12, width: 165, height: 160)
        let categoryActionSheet = CustomActionSheet(frame: self.view.frame, ASFrame: ASFrame)
        self.view.addSubview(categoryActionSheet)
    }
    
    //MARK: - addSubView
    private func addSubView() {
        self.view.addSubview(self.topTabbar)
        self.view.addSubview(self.categoryButton)
        self.view.addSubview(self.feedCollectionView)
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
        
        self.feedCollectionView.snp.makeConstraints {
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
        return self.feedDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        cell.prepareForReuse()
        cell.configureCell(self.feedDatas[indexPath.row])
        cell.delegate = self
        
        return cell
    }
   
}

extension LookAroundViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text: NSString = self.feedDatas[indexPath.row].feedContent as NSString
        var imgViewHeight: CGFloat = 0
        let size = text.boundingRect(with: CGSize(width: self.view.frame.width - 88, height: CGFloat.greatestFiniteMagnitude),
                                     options: .usesLineFragmentOrigin,
                                     attributes: [.font : UIFont.notoSans(size: 14)],
                                     context: nil)
        
        if self.feedDatas[indexPath.row].feedImgList != [] {
            imgViewHeight = (303 + 10 + 20) // 이미지뷰 크기 303 위 아래 여백 10 + 20
        }
        
        return CGSize(width: UIScreen.main.bounds.width - 48 , height: size.height + imgViewHeight + 110) //아래 여백 20 + 위 여백 90
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height: 2)
    }
}

extension LookAroundViewController: LookAroundDelegate {
    func didClickEllipsis() {
        _ = ReportActionSheet().then {
            $0.delegate = self
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            }
        }
        print("didClickEllipsisButton")
    }
    
    func didClickHeart(_ feedId: Int) {
        FeedService.toggleLike(profileId: 1610, feedId: feedId) { [weak self] in
            if let idx = self?.feedDatas.firstIndex(where: {$0.feedId == feedId }) {
                guard let isLike = self?.feedDatas[idx].isLike else { return }
                self?.feedDatas[idx].isLike = !isLike
                self?.feedCollectionView.reloadItems(at: [IndexPath(row: idx, section: 0)])
            }
        }
    }
    
    //iosdev.sw@gmail.com
    func didClickFollow(_ toProfileId: Int) {
        FeedService.togglefollow(fromProfileId: 1610, toProfileId: toProfileId) { [weak self] in
            self?.feedDatas.enumerated().forEach { (i,v) in
                if v.profileId == toProfileId {
                    v.isFollowing = !v.isFollowing
                    self?.feedCollectionView.reloadItems(at: [IndexPath(item: i, section: 0)])
                }
            }
        }
    }
    
    func didClickReportButton() {
        print("didClickReportButton")
        let reportVC = ReportViewController()
        self.navigationController?.pushViewController(reportVC, animated: true)
    }
}

extension LookAroundViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("end Editing call API")
    }
}
