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
    }
    
    //MARK: - Method
    private func configureNavigation() {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        self.navigationItem.title = "둘러보기"
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
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        
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
        let text: NSString = "예전의 어린 나는 가슴 속에 나침반이 하나 있었다. 그래서 어디로 가야 할지 모를 때 가슴 속의 나침반이 나의 길로 나를 이끌었다. 언제부터인가 나는 돈에 집착하기 시작했고 가슴 속의 나침반은 더이상 작동하지 않았다. "
        let size = text.boundingRect(with: CGSize(width: self.view.frame.width - 88, height: CGFloat.greatestFiniteMagnitude),
                                     options: .usesLineFragmentOrigin,
                                     attributes: [.font : UIFont.notoSans(size: 14)],
                                     context: nil)
        
        return CGSize(width: size.width+40 , height: size.height + 108)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height: 2)
    }
}
