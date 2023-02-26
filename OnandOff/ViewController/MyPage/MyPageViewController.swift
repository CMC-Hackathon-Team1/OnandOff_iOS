//
//  MyPageViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit

final class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    private let reuseIdentifier = "MyPageCell"
    private let profileView = ProfileView()
    private let myPageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubView()
        self.layout()
        self.configureNavigation()
        self.configureCollectionView()
    }
    
    // MARK: - Selector
    @objc private func didClickEditButton(_ button: UIButton) {
        print("didClickEditButton")
        let controller = EditProfileViewController()
        print(controller)
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
    
    // MARK: - ConfigureCollectionView
    private func configureCollectionView() {
        myPageCollectionView.register(MyPageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        myPageCollectionView.backgroundColor = .white
        myPageCollectionView.dataSource = self
        myPageCollectionView.delegate = self
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
        
        self.myPageCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(21)
            make.trailing.equalToSuperview().offset(-21)
            make.top.equalTo(profileView.snp.bottom).offset(12)
            make.bottom.equalToSuperview()
        }
    }
}


extension MyPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyPageCell
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
        
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 405)
    }
}
