//
//  MyPageViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit

final class MyPageViewController: UIViewController {
    // MARK: - Properties
    private var MyPageFeedData: [MyPageItem] = []
    private var hasNextPage: Bool = true
    private var isPaging: Bool = false
    private var currentPage: Int = 1
    
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
        
        // 선택된 ProfileId 변경 옵저버 추가 -> 변경시 nextpage = true feeddata 빈배열 currentPage = 1로 바꿔주기.
        // NotificationCenter.default.addObserver(self, selector: #selector(<#T##@objc method#>), name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MyPageFeedData.isEmpty {
            MyPageService.fetchFeedWithDate(27, targetId: 27, year: self.calendarHeaderView.getYear,
                                            month: self.calendarHeaderView.getMonth, day: nil, page: self.currentPage) { [weak self] items in
                self?.MyPageFeedData = items
                self?.myPageCollectionView.reloadData()
            }
        }
        
        MyPageService.fetchProfile(1610) { [weak self] item in
            self?.profileView.configureProfile(item)
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
        MyPageService.fetchFeedWithDate(27, targetId: 27, year: self.calendarHeaderView.getYear, month: self.calendarHeaderView.getMonth, day: nil, page: self.currentPage) { [weak self] items in
            if items.isEmpty { self?.hasNextPage = false }
            self?.MyPageFeedData.append(contentsOf: items)
            self?.isPaging = false
            self?.myPageCollectionView.reloadData()
        }
    }
    
    // MARK: - Selector
    @objc private func didClickEditButton(_ button: UIButton) {
        print("didClickEditButton")
        let controller = EditProfileViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func pullToRefresh(_ refresh: UIRefreshControl) {
        self.MyPageFeedData = []
        self.currentPage = 1
        self.hasNextPage = true
        
        MyPageService.fetchFeedWithDate(27, targetId: 27, year: self.calendarHeaderView.getYear, month: self.calendarHeaderView.getMonth, day: nil, page: self.currentPage) { [weak self] items in
            if items.isEmpty { self?.hasNextPage = false }
            self?.MyPageFeedData.append(contentsOf: items)
            self?.myPageCollectionView.reloadData()
            refresh.endRefreshing()
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
    }
}

extension MyPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.MyPageFeedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCell.identifier, for: indexPath) as! MyPageCell
        cell.prepareForReuse()
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
        
        MyPageService.fetchFeedWithDate(27, targetId: 27, year: self.calendarHeaderView.getYear,
                                        month: self.calendarHeaderView.getMonth, day: nil) { [weak self] items in
            self?.MyPageFeedData = items
            self?.myPageCollectionView.reloadData()
        }
    }
}
