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
    private let profileView = ProfileView()
    
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
        
        self.myPageCollectionView.dataSource = self
        self.myPageCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MyPageService.fetchFeedWithDate(27, targetId: 27, year: 2023, month: "02", day: nil) { [weak self] items in
            self?.MyPageFeedData = items
            self?.myPageCollectionView.reloadData()
        }
        
        MyPageService.fetchProfile(1610) { [weak self] item in
            self?.profileView.configureProfile(item)
        }
    }
    
    // MARK: - Selector
    @objc private func didClickEditButton(_ button: UIButton) {
        print("didClickEditButton")
        let controller = EditProfileViewController()
        self.navigationController?.pushViewController(controller, animated: true)
        
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
        self.view.addSubview(self.myPageCollectionView)
    }
    
    // MARK: - Layout
    private func layout() {
        self.profileView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(66)
        }
        
        self.myPageCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(profileView.snp.bottom).offset(12)
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
}

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
