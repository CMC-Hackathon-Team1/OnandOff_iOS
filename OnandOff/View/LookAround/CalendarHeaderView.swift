//
//  CalendarHeaderView.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/13.
//

import UIKit
import FSCalendar

class CalendarHeaderView: UICollectionReusableView {
    static let identifier = "CalendarHeaderView"
    
    private var calendarDatas: [CalendarInfoItem] = []
    var profileId = 0
    
    private let calendarView = FSCalendar().then {
        $0.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.calendarView)
        self.calendarView.frame = frame
        self.canlendarSetUp()
        
        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCalendar(_ profileId: Int) {
        self.profileId = profileId
        if self.calendarDatas.isEmpty {
            let current = self.calendarView.currentPage
            FeedService.getCalendarInfo(profileId: self.profileId, year: current.getYear, month: current.getMonth) { [weak self] items in
                self?.calendarDatas = items
                self?.calendarView.reloadData()
            }
        }
    }
    
    private func canlendarSetUp() {
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
}

//MARK: - CalendarDelegate
extension CalendarHeaderView: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 특정 날짜에 이미지 세팅
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, imageOffsetFor date: Date) -> CGPoint {
        return .init(x: 0, y: 5)
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: CalendarCell.identifier, for: date, at: position) as! CalendarCell
        cell.prepareForReuse()
        if let item = self.calendarDatas.first(where: { $0.day == date.getDay }),
           let urlString = item.feedImgUrl {
            cell.customImageView.loadImage(urlString)
        }
        
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let idx = self.calendarDatas.firstIndex(where: { $0.day == date.getDay }) {
            let feedId = self.calendarDatas[idx].feedId
            NotificationCenter.default.post(name: .clickDay, object: feedId)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.calendarDatas = []
        self.updateCalendar(self.profileId)
        NotificationCenter.default.post(name: .changeCurrentPage, object: calendar.currentPage)
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
