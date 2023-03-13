//
//  HomeViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//
//
import UIKit
import FSCalendar

final class HomeViewController: UIViewController {
    //MARK: - Properties
    private var personaDatas: [ProfileItem] = []
    private var profileImageDatas: [UIImage] = []
    private var calendarDatas: [CalendarInfoItem] = []
    private var calendarImageDatas: [UIImage?] = []
    
    private var selectedProfile: ProfileItem? {
        didSet {
            self.nickNameLbl.text = self.selectedProfile!.personaName + " " + self.selectedProfile!.profileName
            self.personaLabel.text = "\(self.selectedProfile!.personaName)님,"
            
            self.fetchStatistic()
            self.updateCalendar()
            
            UserDefaults.standard.set(self.selectedProfile!.profileId, forKey: "selectedProfileId")
            NotificationCenter.default.post(name: .changeProfileId, object: nil)
        }
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    private let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
        $0.showsHorizontalScrollIndicator = false
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    private let topFrameView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowColor = UIColor.gray.cgColor
    }
    
    private let nickNameLbl = UILabel().then {
        $0.font = .notoSans(size: 20, family: .Bold)
        $0.text = "직업 + 닉네임"
    }
    
    private let introduceLbl = UILabel().then {
        $0.font = .notoSans(size: 20, family: .Regular)
        $0.text = "오늘 당신의 하루를 공유해주세요 ✏️"
    }
    
    private let writeBookManImg = UIImageView().then {
        $0.image = UIImage(named: "WriteBookMan")
    }
    
    private let writeBtn = UIButton(type: .system).then {
        $0.backgroundColor = UIColor.mainColor
        $0.layer.cornerRadius = 5
        $0.setTitle("기록하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 16, family: .Bold)
    }
    
    private let calendarView = FSCalendar().then {
        $0.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
    }
    
    let calendarRight = UIButton().then{
        $0.setImage(UIImage(named: "calendarright")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    let calendarLeft = UIButton().then{
        $0.setImage(UIImage(named: "calendarleft")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    let view4 = UIView().then {
        $0.backgroundColor = UIColor(rgb: 0xF2F2F2)
    }
    
    private let bottomFrameView = UIView()
    
    private let personaLabel = UILabel().then {
        $0.font = .notoSans(size: 18, family: .Bold)
        $0.text = "작가"
    }
    
    private let bottomStackView = UIStackView().then {
        $0.distribution = .fillEqually
    }
    
    private let heartComponent = StatisticsComponent().then {
        $0.imageIconLabel.text = "💞"
    }
    
    private let writeComponent = StatisticsComponent().then {
        $0.imageIconLabel.text = "📝"
    }
    
    private let peopleComponent = StatisticsComponent().then {
        $0.imageIconLabel.text = "👥"
    }
  
    private let alarmButton = UIButton().then {
        $0.setImage(UIImage(named: "alarmButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let settingButton = UIButton().then {
        $0.setImage(UIImage(named: "settingButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Authentication
        self.setUpView()
        self.layout()
        self.addTarget()
        self.canlendarSetUp()
        self.configure()
        self.addNotification()
        
        self.calendarView.delegate = self
        self.calendarView.dataSource = self
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.checkUserLogin() {
            ProfileService.getProfileModels { [weak self] items in
                let profileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
                var profile: ProfileItem?
                self?.profileImageDatas = []
                self?.personaDatas = items
                DispatchQueue.global().async {
                    for item in items {
                        if item.profileId == profileId { profile = item }
                        do {
                            guard let url = URL(string: item.profileImgUrl) else { return }
                            let data = try Data(contentsOf: url)
                            self?.profileImageDatas.append(UIImage(data: data) ?? UIImage())
                        } catch let error {
                            print(error)
                        }
                    }
                    DispatchQueue.main.async {
                        if profileId == -1 { self?.selectedProfile = items[0] }
                        if let profile { self?.selectedProfile = profile }
                        if self?.selectedProfile == nil { self?.selectedProfile = items[0] }
                        self?.profileCollectionView.reloadData()
                    }
                }
            }
            
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    //MARK: - Method
    private func fetchStatistic() {
        StatisticsService.getStatistics(self.selectedProfile!.profileId) { item in
            self.heartComponent.highlightColor("이번 달에 \(item.monthly_likes_count)개의\n공감을 받았어요!",
                                               pointStr: "\(item.monthly_likes_count)개")
            self.writeComponent.highlightColor("이번 달에 \(item.monthly_myFeeds_count)개의\n글을 작성했어요!",
                                               pointStr: "\(item.monthly_myFeeds_count)개")
            self.peopleComponent.highlightColor("이번 달에 \(item.monthly_myFollowers_count)명이\n팔로우를 했어요!",
                                                pointStr: "\(item.monthly_myFollowers_count)명")
        }
    }
    
    private func updateCalendar() {
        self.calendarDatas = []
        self.calendarImageDatas = []
        let current = self.calendarView.currentPage
        FeedService.getCalendarInfo(profileId: self.selectedProfile!.profileId, year: current.getYear, month: current.getMonth) { [weak self] items in
            DispatchQueue.global().async {
                for item in items {
                    self?.calendarDatas.append(item)
                    do {
                        if let urlString = item.feedImgUrl {
                            guard let url = URL(string: urlString) else { return }
                            let data = try Data(contentsOf: url)
                            self?.calendarImageDatas.append(UIImage(data: data))
                        } else {
                            self?.calendarImageDatas.append(nil)
                        }
                        
                    } catch let error {
                        print(error)
                    }
                }
                DispatchQueue.main.async {
                    self?.calendarView.reloadData()
                }
            }
        }
    }
    
    private func configure() {
        self.view.backgroundColor = .white
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.logout), name: .presentLoginVC, object: nil)
    }
    
    //MARK: - CalendarUI
    private func canlendarSetUp(){
        _ = self.calendarView.then {
            $0.placeholderType = .none
            $0.locale = .current
            $0.appearance.headerDateFormat = "YYYY년 M월"
            $0.appearance.headerMinimumDissolvedAlpha = 0.0
            $0.appearance.headerTitleFont = UIFont.notoSans(size: 16, family: .Bold)
            $0.appearance.headerTitleColor = .black
            $0.appearance.weekdayFont = UIFont.notoSans(size: 12)
            $0.appearance.weekdayTextColor = .black
            $0.appearance.todayColor = .white
            $0.appearance.titleTodayColor = .black
            $0.appearance.selectionColor = .white
            $0.appearance.titleSelectionColor = .black
            $0.appearance.eventDefaultColor = UIColor.mainColor
            $0.appearance.eventSelectionColor = UIColor.mainColor
        }        
    }
    
    private func setUpView() {
        self.view.addSubview(self.scrollView)
        
        self.bottomStackView.addArrangedSubview(self.heartComponent)
        self.bottomStackView.addArrangedSubview(self.writeComponent)
        self.bottomStackView.addArrangedSubview(self.peopleComponent)
        
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.topFrameView)
        self.contentView.addSubview(self.profileCollectionView)
        self.contentView.addSubview(self.alarmButton)
        self.contentView.addSubview(self.settingButton)
        self.contentView.addSubview(self.calendarView)
        self.contentView.addSubview(self.view4)
        self.contentView.addSubview(self.bottomFrameView)
        
        self.topFrameView.addSubview(self.nickNameLbl)
        self.topFrameView.addSubview(self.introduceLbl)
        self.topFrameView.addSubview(self.writeBookManImg)
        self.topFrameView.addSubview(self.writeBtn)
        
        self.calendarView.addSubview(self.calendarRight)
        self.calendarView.addSubview(self.calendarLeft)
        
        self.bottomFrameView.addSubview(self.personaLabel)
        self.bottomFrameView.addSubview(self.bottomStackView)
    }
    
    private func layout() {
        self.scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.contentView.snp.makeConstraints {
            $0.centerX.width.top.bottom.equalToSuperview()
        }
        
        self.profileCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalTo(alarmButton.snp.leading).offset(-10)
            $0.height.equalTo(75)
        }
        
        self.topFrameView.snp.makeConstraints {
            $0.height.equalTo(317)
            $0.top.equalTo(profileCollectionView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.settingButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-27)
            $0.width.height.equalTo(22)
        }
        
        self.alarmButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(25)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-17.35)
            $0.width.height.equalTo(20)
        }
        
        self.nickNameLbl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        self.introduceLbl.snp.makeConstraints {
            $0.top.equalTo(nickNameLbl.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(24)
        }
        
        self.writeBookManImg.snp.makeConstraints {
            $0.top.equalTo(introduceLbl.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
        
        self.writeBtn.snp.makeConstraints {
            $0.top.equalTo(writeBookManImg.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        self.calendarView.snp.makeConstraints {
            $0.top.equalTo(self.topFrameView.snp.bottom).offset(15)
            $0.height.equalTo(330)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        self.calendarRight.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-129)
        }
        
        self.calendarLeft.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(127)
        }
        
        view4.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.top.equalTo(calendarView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.bottomFrameView.snp.makeConstraints {
            $0.height.equalTo(225)
            $0.top.equalTo(view4.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        self.personaLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.leading.equalToSuperview().inset(24)
        }
        
        self.bottomStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(86)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Selector
    @objc private func didClickWrite(_ button: UIButton) {
        let postVC = PostViewController(self.selectedProfile!)
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc func didClickAlarm(sender: UITapGestureRecognizer) {
        let vc = AlarmViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func didClickSetting(_ sender: UIButton) {
        let settingVC = SettingViewController()
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @objc func monthForthButtonPressed(_ sender: Any) {
        guard var year = Int(self.calendarView.currentPage.getYear),
              var month = Int(self.calendarView.currentPage.getMonth) else { return}
        month += 1
        if month > 12 {
            month = 1
            year += 1
        }
        let newPage = Date("\(year)-" + String(format: "%02d", month) + "-\(self.calendarView.currentPage.getDay)")
        self.calendarView.setCurrentPage(newPage, animated: true)
    }

    @objc func monthBackButtonPressed(_ sender: Any) {
        guard var year = Int(self.calendarView.currentPage.getYear),
              var month = Int(self.calendarView.currentPage.getMonth) else { return}
        month -= 1
        if month < 1 {
            month = 12
            year -= 1
        }
        let newPage = Date("\(year)-" + String(format: "%02d", month) + "-\(self.calendarView.currentPage.getDay)")
        self.calendarView.setCurrentPage(newPage, animated: true)
    }
    
    @objc private func logout() {
        AuthService.userLogOut() { response in
            if let response = response {
                print(response.message)
                switch response.statusCode {
                case 100:
                    TokenService().delete("https://dev.onnoff.shop/auth/login", account: "accessToken") // JWT 삭제
                    let loginVC = UINavigationController(rootViewController: LoginViewController())
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true)
                case 400:
                    print(response.message)
                case 401:
                    print(response.message)
                case 500:
                    print(response.message)
                default:
                    break
                }
            }
            return
        }
    }
    
    //MARK: - AddTarget
    private func addTarget(){
        self.writeBtn.addTarget(self, action: #selector(self.didClickWrite(_:)), for: .touchUpInside)
        self.settingButton.addTarget(self, action: #selector(self.didClickSetting), for: .touchUpInside)
        self.alarmButton.addTarget(self, action: #selector(self.didClickAlarm), for: .touchUpInside)
        self.calendarRight.addTarget(self, action: #selector(self.monthForthButtonPressed), for: .touchUpInside)
        self.calendarLeft.addTarget(self, action: #selector(self.monthBackButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    private func checkUserLogin() -> Bool {
        if TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken") == nil {
            let loginVC = UINavigationController(rootViewController: LoginViewController())
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
            return false
        } else {
            return true
        }
    }
}

//MARK: - CalendarDelegate
extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        if let idx = self.calendarDatas.firstIndex(where: { $0.day == date.getDay && $0.feedImgUrl != nil }) {
            return self.calendarImageDatas[idx]
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return .init(x: 0, y: 5)
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: date, at: position) as! CalendarCell
        
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let feedVC = FeedWithDayViewController(profile: self.selectedProfile!, year: date.getYear, month: date.getMonth, day: date.getDay)
        self.present(feedVC, animated: true)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.fetchStatistic()
        self.updateCalendar()
    }
    
    // 글 있는 날짜
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.calendarDatas.contains(where: { $0.day == date.getDay }) {
            return 1
        } else {
            return 0
        }
    }
}

//MARK: - CollectionView Delegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.personaDatas.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        cell.prepareForReuse()
        
        if indexPath.row == self.personaDatas.count{ // 페르소나 추가
            cell.profileNameLabel.text = ""
            cell.profileImageView.contentMode = .center
            cell.profileImageView.image = UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal)
        }else{
            if self.selectedProfile!.profileId == self.personaDatas[indexPath.row].profileId { cell.configureSelectedItem() }
            if !self.profileImageDatas.isEmpty { cell.profileImageView.image = self.profileImageDatas[indexPath.row] }
            cell.profileNameLabel.text = self.personaDatas[indexPath.row].personaName
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 53, height: 75)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == self.personaDatas.count{
            let makeProfileVC = ProfileMakeViewController()
            self.navigationController?.pushViewController(makeProfileVC, animated: true)
        }else{
            self.selectedProfile = self.personaDatas[indexPath.row]

            collectionView.reloadData()
        }
    }
}
