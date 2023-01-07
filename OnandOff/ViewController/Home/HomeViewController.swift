//
//  HomeViewController.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit
import SnapKit
import Then
import FSCalendar

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    var persona = ""
    var nickName = ""
    
    let calendar = FSCalendar(frame: CGRect(x: 15, y: 20, width: 380, height: 300))
    
    var monthlyReceiveHeartCount = "0"
    var monthlyWriteCount = "0"
    var monthlyFollowCount = "0"
    
    let dateWithImg = ["20230105"]
    let dateFormatter = DateFormatter()
    
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    let contentView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let view1 = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowColor = UIColor.gray.cgColor
    }
    
    let personaLbl = UILabel().then {
        $0.font = .notoSans(size: 20, family: .Bold)
        $0.text = "작가"
    }
    
    let nickNameLbl = UILabel().then {
        $0.font = .notoSans(size: 20, family: .Bold)
        $0.text = "키키님,"
    }
    
    let introduceLbl = UILabel().then {
        $0.font = .notoSans(size: 20, family: .Regular)
        $0.text = "오늘 당신의 하루를 공유해주세요✏️"
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
    
    let view2 = UIView().then {_ in
    }
    
    let view3 = UIView().then {
        $0.backgroundColor = UIColor(rgb: 0xF2F2F2)
    }
    
    let view4 = UIView().then {_ in
    }
    
    let personaBottomLbl = UILabel().then {
        $0.font = .notoSans(size: 18, family: .Bold)
        $0.text = "작가"
    }
    
    let nickNameBottomLbl = UILabel().then {
        $0.font = .notoSans(size: 18, family: .Bold)
        $0.text = "키키님,"
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
    
    lazy var monthlyReceiveHeartCountLbl = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Bold)
        $0.text = "\(monthlyReceiveHeartCount)개"
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
    
    lazy var monthlyWriteCountLbl = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Bold)
        $0.text = "\(monthlyWriteCount)개"
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
    
    lazy var monthlyReceiveFollowCountLbl = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Bold)
        $0.text = "\(monthlyFollowCount)개"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        layout()
        
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleFont = UIFont.notoSans(size: 16, family: .Bold)
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayFont = UIFont.notoSans(size: 12)
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.todayColor = UIColor.systemGray
        calendar.appearance.selectionColor = UIColor.mainColor
    }
    
    func setUpView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(view1)
        view1.addSubview(personaLbl)
        view1.addSubview(nickNameLbl)
        view1.addSubview(introduceLbl)
        view1.addSubview(writeBookManImg)
        view1.addSubview(writeBtn)
        view2.backgroundColor = .clear
        view2.addSubview(calendar)
        contentView.addSubview(view2)
        contentView.addSubview(view3)
        contentView.addSubview(view4)
        view4.addSubview(personaBottomLbl)
        view4.addSubview(nickNameBottomLbl)
        view4.addSubview(writeLbl)
        view4.addSubview(heartLbl)
        view4.addSubview(peopleLbl)
        view4.addSubview(monthlyReceiveHeartLbl1)
        view4.addSubview(monthlyReceiveHeartCountLbl)
        view4.addSubview(monthlyReceiveHeartLbl2)
        view4.addSubview(monthlyReceiveHeartLbl3)
        view4.addSubview(monthlyWriteLbl1)
        view4.addSubview(monthlyWriteCountLbl)
        view4.addSubview(monthlyWriteLbl2)
        view4.addSubview(monthlyWriteLbl3)
        view4.addSubview(monthlyReceiveFollowLbl1)
        view4.addSubview(monthlyReceiveFollowCountLbl)
        view4.addSubview(monthlyReceiveFollowLbl2)
        view4.addSubview(monthlyReceiveFollowLbl3)
        view4.addSubview(heartLblStackView)
        view4.addSubview(writeLblStackView)
        view4.addSubview(followLblStackView)
    }
    
    private func layout() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(115)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        view1.snp.makeConstraints {
            $0.height.equalTo(317)
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        personaLbl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        nickNameLbl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(personaLbl.snp.trailing).offset(4)
        }
        
        introduceLbl.snp.makeConstraints {
            $0.top.equalTo(personaLbl.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(24)
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
        
        view2.snp.makeConstraints {
            $0.height.equalTo(330)
            $0.top.equalTo(view1.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        view3.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.top.equalTo(view2.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        view4.snp.makeConstraints {
            $0.height.equalTo(225)
            $0.top.equalTo(view3.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        personaBottomLbl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.leading.equalToSuperview().inset(24)
        }
        
        nickNameBottomLbl.snp.makeConstraints {
            $0.top.equalToSuperview().inset(35)
            $0.leading.equalTo(personaBottomLbl.snp.trailing).offset(4)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonaCollectionViewCell.identifier, for: indexPath) as! PersonaCollectionViewCell
//        cell.setup(with: collections[indexPath.row])
//        print(collections[indexPath.row])
        return cell
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
