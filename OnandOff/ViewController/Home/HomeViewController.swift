//
//  HomeViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//
//
import UIKit
import SnapKit
import KakaoSDKUser
import Alamofire
import Then
import FSCalendar

protocol SendFeedIdProtocol: AnyObject{
    func sendFeedId(data: Array<Int>)
}

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
 
    
 //MARK: Properties
    let formatter = DateFormatter()
    
    var showingYear = 9999
    var showingMonth = "00"
    var clickedDay = "00"
    var daysForDotsArray = [String]()
    
    var profileIdNow = 0
    var profileIdArray = [Int]()
    var personaArray = [String]()
    var profileNameArray = [String]()
    var statusMesageArray = [String]()
    var profileImageArray = [String]()
    
    var getFeedIdArray = [Int]()
    //녹음 있는 날짜 Array
    let jwtToken = TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken")

    let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 380, height: 300))
    //이미지있는 날짜
    fileprivate let datesWithCat = [""]
    // 동그라미 있는 날짜
    var haveDataCircle = [String]()
    
    let calendarRight = UIButton().then{
        $0.setImage(UIImage(named: "calendarright")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        $0.alpha = 0
    }
    let calendarLeft = UIButton().then{
        $0.setImage(UIImage(named: "calendarleft")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        $0.alpha = 0
    }

    let dateFormatter = DateFormatter()
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    let contentView = UIView()

    let profileCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
        $0.backgroundColor = .white

        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        $0.showsHorizontalScrollIndicator = false
    }
    let view2 = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowColor = UIColor.gray.cgColor
    }
    
//    let personaLbl = UILabel().then {
//        $0.font = .notoSans(size: 20, family: .Bold)
//        $0.text = "작가"
//    }
    
    let nickNameLbl = UILabel().then {
        $0.font = .notoSans(size: 20, family: .Bold)
        $0.text = "직업 + 닉네임"
    }
    
    let introduceLbl = UILabel().then {
        $0.font = .notoSans(size: 20, family: .Regular)
        $0.text = "오늘 당신의 하루를 공유해주세요"
    }
    
    let pencilLbl = UILabel().then {
        $0.font = .notoSans(size: 20, family: .Regular)
        $0.text = "✏️"
    }
    
    let writeBookManImg = UIImageView().then {
        $0.image = UIImage(named: "WriteBookMan")
    }
    
    let writeBtn = UIButton().then {
        $0.backgroundColor = UIColor.mainColor
        $0.layer.cornerRadius = 5
        $0.setTitle("기록하기", for: .normal)
        $0.titleLabel?.font = .notoSans(size: 16, family: .Bold)
    }
    
    let view3 = UIView().then {_ in
    }
    
    let view4 = UIView().then {
        $0.backgroundColor = UIColor(rgb: 0xF2F2F2)
    }
    
    let view5 = UIView().then {_ in
    }
    
    let personaBottomLbl = UILabel().then {
        $0.font = .notoSans(size: 18, family: .Bold)
        $0.text = "작가"
    }
    
    let heartLbl = UILabel().then {
        $0.font = .systemFont(ofSize: 40)
        $0.text = "💞"
    }
    
    let writeLbl = UILabel().then {
        $0.font = .systemFont(ofSize: 40)
        $0.text = "📝"
    }
    
    let peopleLbl = UILabel().then {
        $0.font = .systemFont(ofSize: 40)
        $0.text = "👥"
    }
    
    let heartWritePeopleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 80
    }
    
    let monthlyReceiveHeartLbl1 = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.text = "이번달에"
    }
    
    var monthlyReceiveHeartCountLbl = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Bold)
        $0.text = "0 개"
        $0.textColor = UIColor.mainColor
    }
    
    let monthlyReceiveHeartLbl2 = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.text = "의"
    }
    
    let monthlyReceiveHeartLbl3 = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.text = "공감을 받았어요!"
    }
    
    let monthlyWriteLbl1 = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.text = "이번달에"
    }
    
    var monthlyWriteCountLbl = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Bold)
        $0.text = "0 개"
        $0.textColor = UIColor.mainColor
    }
    
    let monthlyWriteLbl2 = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.text = "의"
    }
    
    let monthlyWriteLbl3 = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.text = "글을 작성했어요!"
    }
    
    let monthlyReceiveFollowLbl1 = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.text = "이번달에"
    }
    
    var monthlyReceiveFollowCountLbl = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Bold)
        $0.text = "0 개"
        $0.textColor = UIColor.mainColor
    }
    
    let monthlyReceiveFollowLbl2 = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.text = "의"
    }
    
    let monthlyReceiveFollowLbl3 = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.text = "팔로우를 했어요!"
    }
    
    let heartLblStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 1
    }
    
    let writeLblStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 1
    }
    
    let followLblStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 1
    }
    
    let heartWriteFollowLblStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 80
    }
    let alarmButton = UIImageView().then{
        $0.image = UIImage(named: "alarmButton")?.withRenderingMode(.alwaysOriginal)
    }
    let settingButton = UIImageView().then{
        $0.image = UIImage(named: "settingButton")?.withRenderingMode(.alwaysOriginal)
    }
//MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Authentication
        CheckUserLogIn()
        LogOut()
        kakaoLogOut()
        
        setUpView()
        layout()
        addTarget()
        canlendarSetUp()
        
        self.calendar.delegate = self
        self.calendar.dataSource = self
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
        
        if jwtToken != nil{
            GetPersonaDataRequest().getRequestData(self)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if jwtToken != nil{
            self.profileIdArray = [Int]()
            self.personaArray = [String]()
            self.profileNameArray = [String]()
            self.statusMesageArray = [String]()
            self.profileImageArray = [String]()
            GetPersonaDataRequest().getRequestData(self)
            HomeStatisticsDataRequest().getStatisticsRequestData(self, profileId: profileIdNow)
            
            HomeCalendarDataRequest().getHomeCalendarRequestData(self, profileId: profileIdNow, year: showingYear, month: showingMonth)

            
        }
    }
    
    //MARK: CalendarUI
    func canlendarSetUp(){
        calendar.placeholderType = .none
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleFont = UIFont.notoSans(size: 16, family: .Bold)
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayFont = UIFont.notoSans(size: 12)
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.todayColor = .white
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.selectionColor = .white
        calendar.appearance.titleSelectionColor = .black
        
        //이벤트 동그라미
        calendar.appearance.eventDefaultColor = UIColor.mainColor
        calendar.appearance.eventSelectionColor = UIColor.mainColor
    }
    
    func setUpView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
//        contentView.addSubview(view1)
        contentView.addSubview(view2)
//        view1.addSubview(profileMakeBtn)
        
        contentView.addSubview(profileCollectionView)
        contentView.addSubview(alarmButton)
        contentView.addSubview(settingButton)
        
//        view2.addSubview(personaLbl)
        view2.addSubview(nickNameLbl)
        view2.addSubview(introduceLbl)
        view2.addSubview(pencilLbl)
        view2.addSubview(writeBookManImg)
        view2.addSubview(writeBtn)
        contentView.addSubview(view3)
        view3.backgroundColor = .clear
        view3.addSubview(calendar)
        calendar.addSubview(self.calendarRight)
        calendar.addSubview(self.calendarLeft)
        contentView.addSubview(view4)
        contentView.addSubview(view5)
        view5.addSubview(personaBottomLbl)
        view5.addSubview(writeLbl)
        view5.addSubview(heartLbl)
        view5.addSubview(peopleLbl)
        view5.addSubview(monthlyReceiveHeartLbl1)
        view5.addSubview(monthlyReceiveHeartCountLbl)
        view5.addSubview(monthlyReceiveHeartLbl2)
        view5.addSubview(monthlyReceiveHeartLbl3)
        view5.addSubview(monthlyWriteLbl1)
        view5.addSubview(monthlyWriteCountLbl)
        view5.addSubview(monthlyWriteLbl2)
        view5.addSubview(monthlyWriteLbl3)
        view5.addSubview(monthlyReceiveFollowLbl1)
        view5.addSubview(monthlyReceiveFollowCountLbl)
        view5.addSubview(monthlyReceiveFollowLbl2)
        view5.addSubview(monthlyReceiveFollowLbl3)
        view5.addSubview(heartLblStackView)
        view5.addSubview(writeLblStackView)
        view5.addSubview(followLblStackView)
    }
    
    func layout() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(35)
            $0.trailing.equalToSuperview().offset(-27)
            $0.width.height.equalTo(22)
        }
        alarmButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(35)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-17.35)
            $0.width.height.equalTo(20)
        }
        profileCollectionView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(alarmButton.snp.leading).offset(-10)
            $0.height.equalTo(90)
        }
        
        
        view2.snp.makeConstraints {
            $0.height.equalTo(317)
            $0.top.equalTo(profileCollectionView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
//        personaLbl.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.leading.equalToSuperview().inset(24)
//        }
        
        nickNameLbl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        introduceLbl.snp.makeConstraints {
            $0.top.equalTo(nickNameLbl.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(24)
        }
        
        pencilLbl.snp.makeConstraints {
            $0.top.equalTo(nickNameLbl.snp.bottom).offset(1)
            $0.leading.equalTo(introduceLbl.snp.trailing).offset(2.3)
        }
        
        writeBookManImg.snp.makeConstraints {
            $0.top.equalTo(introduceLbl.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
        
        writeBtn.snp.makeConstraints {
            $0.top.equalTo(writeBookManImg.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
        
        view3.snp.makeConstraints {
            $0.height.equalTo(330)
            $0.top.equalTo(view2.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        calendar.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        calendarRight.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-129)
        }
        calendarLeft.snp.makeConstraints{
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(127)
        }
        view4.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.top.equalTo(view3.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        view5.snp.makeConstraints {
            $0.height.equalTo(225)
            $0.top.equalTo(view4.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        personaBottomLbl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.leading.equalToSuperview().inset(24)
        }
        heartLbl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(86)
            $0.leading.equalToSuperview().inset(45)
        }
        
        writeLbl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(86)
            $0.centerX.equalToSuperview().offset(1.5)
        }
        
        peopleLbl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(86)
            $0.trailing.equalToSuperview().inset(42)
        }
        
        [monthlyReceiveHeartLbl1, monthlyReceiveHeartCountLbl].map {
            heartLblStackView.addArrangedSubview($0)
        }
        
        heartLblStackView.snp.makeConstraints {
            $0.top.equalTo(heartLbl.snp.bottom).offset(13)
            $0.leading.equalToSuperview().inset(26)
        }
        
        monthlyReceiveHeartLbl2.snp.makeConstraints {
            $0.top.equalTo(heartLbl.snp.bottom).offset(13)
            $0.leading.equalTo(heartLblStackView.snp.trailing)
        }
        
        monthlyReceiveHeartLbl3.snp.makeConstraints {
            $0.top.equalTo(monthlyReceiveHeartLbl2.snp.bottom).offset(1)
            $0.leading.equalToSuperview().inset(26)
        }
        
        [monthlyWriteLbl1, monthlyWriteCountLbl].map {
            writeLblStackView.addArrangedSubview($0)
        }
        
        writeLblStackView.snp.makeConstraints {
            $0.top.equalTo(writeLbl.snp.bottom).offset(13)
            $0.centerX.equalToSuperview().offset(-7)
        }
        
        monthlyWriteLbl2.snp.makeConstraints {
            $0.top.equalTo(writeLbl.snp.bottom).offset(13)
            $0.leading.equalTo(writeLblStackView.snp.trailing)
        }
        
        monthlyWriteLbl3.snp.makeConstraints {
            $0.top.equalTo(monthlyWriteLbl1.snp.bottom).offset(1)
            $0.leading.equalTo(monthlyWriteLbl1.snp.leading)
        }
        
        [monthlyReceiveFollowLbl1, monthlyReceiveFollowCountLbl].map {
            followLblStackView.addArrangedSubview($0)
        }
        
        followLblStackView.snp.makeConstraints {
            $0.top.equalTo(peopleLbl.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(40)
        }
        
        monthlyReceiveFollowLbl2.snp.makeConstraints {
            $0.top.equalTo(peopleLbl.snp.bottom).offset(13)
            $0.leading.equalTo(followLblStackView.snp.trailing)
        }
        
        monthlyReceiveFollowLbl3.snp.makeConstraints {
            $0.top.equalTo(monthlyReceiveFollowLbl1.snp.bottom).offset(1)
            $0.leading.equalTo(monthlyReceiveFollowLbl1.snp.leading)
        }
    }
    
//MARK: Calendar
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print(dateFormatter.string(from: date) + " 선택됨")
        
        let dateFormatterForDay = DateFormatter()
        dateFormatterForDay.dateFormat = "d"
        clickedDay = dateFormatterForDay.string(from: date)
        print(clickedDay)
        
        GetFeedIdDataRequest().getHomeCalendarRequestData(self, profileId: profileIdNow, year: showingYear, month: showingMonth, day: clickedDay, page: 1)
        
        let vc = SpecificPostViewController()
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true)
        
        //escaping completion 사용해야됨.
//            if self.getFeedIdArray.isEmpty{
//                print("empty. will not show viewController")
//            }else{
//                self.getFeedIdArray = []
//                let vc = SpecificPostViewController()
//                vc.modalPresentationStyle = .automatic
//                self.present(vc, animated: true)
//            }
        
        

    }

    
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        let monthToday = DateFormatter()
        monthToday.dateFormat = "MM"
        var monthStr = monthToday.string(from: date)
        showingMonth = monthStr
        
        let yearToday = DateFormatter()
        yearToday.dateFormat = "YYYY"
        var yearStr = yearToday.string(from: date)
        showingYear = Int(yearStr)!
        
        let imageDateFormatter = DateFormatter()
        imageDateFormatter.dateFormat = "yyyyMMdd"
        var dateStr = imageDateFormatter.string(from: date)
        print("date : \(dateStr)")
        return datesWithCat.contains(dateStr) ? UIImage(named: "calendarexamplepic") : nil
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        print(dateFormatter.string(from: date) + " 해제됨")
    }
    
    // 글 있는 날짜
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        var dates = [Date]()
        if haveDataCircle.count > 0{
            for i in 0...haveDataCircle.count-1{
                let a = formatter.date(from: haveDataCircle[i])
                dates.append(a!)
            }
        }
        if dates.contains(date){
            return 1
        }
        return 0
    }
    
//MARK: Selector
    @objc func enterProfileMake(sender: UIButton!) {
        let vc = ProfileMakeViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    @objc private func didClickWrite(_ button: UIButton) {
        
        
        let vc = PostViewController()
        vc.sendProfileID = profileIdNow
        print("현재 profileID는 : \(profileIdNow)")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func didClickAlarm(sender: UITapGestureRecognizer) {
        let vc = AlarmViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        }
    
    @objc func didClickSetting(sender: UITapGestureRecognizer) {
//        GetPersonaDataRequest().getRequestData(self)
        
        let vc = SettingViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        }
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    @objc func monthForthButtonPressed(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
    }
    @objc func monthBackButtonPressed(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
    }
    private func moveCurrentPage(moveUp: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    
//MARK: AddTarget
    func addTarget(){
        self.writeBtn.addTarget(self, action: #selector(self.didClickWrite(_:)), for: .touchUpInside)
        
        let settingBtn = UITapGestureRecognizer(target: self, action: #selector(didClickSetting))
        settingButton.isUserInteractionEnabled = true
        settingButton.addGestureRecognizer(settingBtn)
        
        let alarmgBtn = UITapGestureRecognizer(target: self, action: #selector(didClickAlarm))
        alarmButton.isUserInteractionEnabled = true
        alarmButton.addGestureRecognizer(alarmgBtn)
        
        self.calendarRight.addTarget(self, action: #selector(self.monthForthButtonPressed), for: .touchUpInside)
        
        self.calendarLeft.addTarget(self, action: #selector(self.monthBackButtonPressed), for: .touchUpInside)
    }
 
    // MARK: - Helpers
    func CheckUserLogIn() {
        print("AccessToken in HomeVC is \(jwtToken ?? "UserIsNotLogIn")")
        if jwtToken == nil {
            DispatchQueue.main.async {
                let controller = LoginViewController()
                let navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion: nil)
            }
        }

    }

    func LogOut() {
        let headers: HTTPHeaders = ["Authorization": "Bearer " + (jwtToken ?? "UserIsNotLogIn")]
        print(headers)
        
        AuthService.userLogOut(nil, headers: headers) { response in
            if let response = response {
                switch response.statusCode {
                case 100:
                    let tokenService = TokenService()
                    tokenService.delete("https://dev.onnoff.shop/auth/login", account: "accessToken")
                    print("LogOut Complete, AccessToken is \(TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken") ?? "Delete Token")")
                    let controller = LoginViewController()
                    let navigation = UINavigationController(rootViewController: controller)
                    navigation.modalPresentationStyle = .fullScreen
                    self.present(navigation, animated: true, completion: nil)
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
    
    func kakaoLogOut() {
        UserApi.shared.logout { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("logout() success..")
                let controller = LoginViewController()
                let navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion: nil)
            }
        }
    }
    
//MARK: Extensions
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        // item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.85)))

        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 6, trailing: 11.5)

        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(500), heightDimension: .fractionalHeight(1)), subitem: item, count: 2)

        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 7)

        // return
        return UICollectionViewCompositionalLayout(section: section)
    }

//MARK: COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personaArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell

        if indexPath.row == personaArray.count{
            cell.profileName.text = ""
            cell.plusButton.isHidden = false
            cell.borderView.backgroundColor = .systemGray3
            cell.profileImage.image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        }else{
            cell.plusButton.isHidden = true
            cell.borderView.backgroundColor = .mainColor
            //이미지
            if let imageURL = URL(string: profileImageArray[indexPath.row]) {
                let task = URLSession.shared.dataTask(with: imageURL, completionHandler: { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.profileImage.image = image
                        }
                    }
                })
                task.resume()
            }
            
            cell.profileName.text = personaArray[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: self.view.frame.width , height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
        
        if indexPath.row == personaArray.count{
            let VC = ProfileMakeViewController()
            VC.modalPresentationStyle = .fullScreen
            present(VC, animated: true)
        }else{
            DispatchQueue.main.async {
                self.nickNameLbl.text = "\(self.profileNameArray[indexPath.row])님,"
                self.personaBottomLbl.text = "\(self.profileNameArray[indexPath.row])님,"
            }
            self.profileIdNow = self.profileIdArray[indexPath.row]
            HomeStatisticsDataRequest().getStatisticsRequestData(self, profileId: profileIdNow)
            HomeCalendarDataRequest().getHomeCalendarRequestData(self, profileId: profileIdNow, year: 2023, month: "02")
            print(self.profileIdNow)
            calendar.reloadData()
        }
    }
//MARK: Alamofire
    func didSuccess(_ response: GetPersonaModel){
        print("didSuccess hello")
        
        for i in 0...(response.result?.count)!-1{
            profileIdArray.append(contentsOf: [(response.result?[i].profileId)!])
            personaArray.append(contentsOf: ["\((response.result?[i].personaName)!)"])
            profileNameArray.append(contentsOf: ["\((response.result?[i].profileName)!)"])
            statusMesageArray.append(contentsOf: ["\((response.result?[i].statusMessage)!)"])
            profileImageArray.append(contentsOf: ["\((response.result?[i].profileImgUrl)!)"])
        }
        profileCollectionView.reloadData()
        
        print(profileIdArray)
        print(personaArray)
        print(profileNameArray)
        print(statusMesageArray)
        print(profileImageArray)
        
        self.nickNameLbl.text = "\(self.profileNameArray[0])님,"
        self.personaBottomLbl.text = "\(self.profileNameArray[0])님,"
        self.profileIdNow = self.profileIdArray[0]
        
        print("didSuccess hello")
    }
    
    func didSuccessStatistics(_ response: HomeStatisticsModel){
        print("didSuccessStatistics")
        if response.result?.monthly_likes_count != nil && response.result?.monthly_myFeeds_count != nil && response.result?.monthly_myFollowers_count != nil{
                DispatchQueue.main.async {
                    self.monthlyReceiveHeartCountLbl.text = "\((response.result?.monthly_likes_count)!) 개"
                    self.monthlyWriteCountLbl.text = "\((response.result?.monthly_myFeeds_count)!) 개"
                    self.monthlyReceiveFollowCountLbl.text = "\((response.result?.monthly_myFollowers_count)!) 명"
            }
        }
    }
    
    func didSuccessCalendar(_ response: HomeCalendarModel){
        print("didSuccessCalendar")
        haveDataCircle = []
        if response.result!.isEmpty == false{
            for i in 0...response.result!.count-1{
                var a = response.result![i].day
                daysForDotsArray.append(a!)
            }
            for i in 0...daysForDotsArray.count-1{
                haveDataCircle.append(contentsOf: ["\(showingYear)-\(showingMonth)-\(daysForDotsArray[i])"])
            }
        }
        calendar.reloadData()
    }
    
    func didSuccessGetFeedId(_ response: GetFeedIdModel){
        
        getFeedIdArray = []
        print("didSuccessGetFeedId")
//        if response.feedArray!.isEmpty{
//
//        }else{
//            for i in 0...response.feedArray!.count-1{
//                getFeedIdArray.append(response.feedArray![i].feedId!)
//            }
//        }
//        print(getFeedIdArray)
        print("didSuccessGetFeedId")
       
    }

}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

