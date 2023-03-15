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
    private var profileImage: UIImage?
    private let date: (year: String, month: String, day: String)
    private var feedDatas: [MyPageItem] = []
    
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
        $0.register(FeedCellWithHome.self, forCellWithReuseIdentifier: FeedCellWithHome.identifier)
    }
    
    private let ellipsisButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    init(profile: ProfileItem, year: String, month: String, day: String) {
        self.profile = profile
        self.date = (year, month, day)
        super.init(nibName: nil, bundle: nil)
        guard let url = URL(string: self.profile.profileImgUrl) else { return }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                self.profileImage = UIImage(data: data)
            } catch let error {
                print(error)
            }
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeFeed), name: .changeFeed, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MyPageService.fetchFeedWithDate(self.profile.profileId, targetId: self.profile.profileId, year: date.year, month: date.month, day: date.day) { [weak self] items in
            self?.feedDatas = items
            self?.feedCollectionView.reloadData()
        }
    }
    
    @objc private func dismissVC() {
        self.dismiss(animated: true)
    }
    
    @objc private func showAlert() {
        _ = ReportActionSheet(self.feedDatas[0].feedId).then {
            self.view.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            }
        }
    }
    
    @objc private func didClickReportButton(_ notification: Notification) {
        guard let feedId = notification.object as? Int else { return }
        let reportVC = ReportViewController(feedId)
        self.navigationController?.pushViewController(reportVC, animated: false)
    }
    
    deinit {
        NotificationCenter.default.post(name: .didCloseFeedWithDayVC, object: nil)
    }
    
    @objc private func changeFeed(notification: Notification) {
        guard let model = notification.object as? MypageTempModel else { return }
        self.feedDatas[0].feedContent = model.feedContent
        self.feedDatas[0].hashTagList = model.hashTag
        
        self.feedCollectionView.reloadData()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCellWithHome.identifier, for: indexPath) as! FeedCellWithHome
        cell.prepareForReuse()
        cell.configureCell(self.profile, item: self.feedDatas[indexPath.row])
        
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
