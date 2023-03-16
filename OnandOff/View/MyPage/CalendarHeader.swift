//
//  CalendarHeader.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/07.
//

import UIKit

final class CalendarHeader: UIView {
    //MARK: - Properties
    weak var delegate: CalendarHeaderDelegate?
    
    private var dateComponent = DateComponents()
    var getMonth: String {
        return String(format: "%02d", self.dateComponent.month ?? 0)
    }
    
    var getYear: String {
        return "\(self.dateComponent.year ?? 0)"
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .notoSans(size: 16, family: .Bold)
    }
    
    private let preMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "calendarleft"), for: .normal)
        $0.tag = 0
    }
    
    private let nextMonthButton = UIButton().then {
        $0.setImage(UIImage(named: "calendarright"), for: .normal)
        $0.tag = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.layout()
        self.setToday()
        self.setTitleLabel()
        self.addTarget()
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setToday() {
        let date = Date()
        dateComponent.year = Calendar.current.component(.year, from: date)
        dateComponent.month = Calendar.current.component(.month, from: date)
    }
    
    func setTitleLabel() {
        guard let year = self.dateComponent.year,
              let month = self.dateComponent.month else { return }
        self.titleLabel.text = "\(year)년 " + String(format: "%02d", month) + "월"
    }
    
    //MARK: - Selector
    @objc private func willChangeMonth(_ button: UIButton) {
        var newMonth = button.tag == 0 ? self.dateComponent.month! - 1 : self.dateComponent.month! + 1
        var newYear = self.dateComponent.year!
        
        if newMonth < 1 {
            newMonth = 12
            newYear -= 1
        } else if newMonth > 12 {
            newMonth = 1
            newYear += 1
        }

        self.dateComponent.year = newYear
        self.dateComponent.month = newMonth
        self.setTitleLabel()
        
        delegate?.changeMonth()
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.preMonthButton)
        self.addSubview(self.nextMonthButton)
    }
    
    //MARK: - Layout()
    private func layout() {
        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        self.nextMonthButton.snp.makeConstraints {
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(self.titleLabel.snp.centerY)
            $0.width.height.equalTo(16)
        }
        
        self.preMonthButton.snp.makeConstraints {
            $0.trailing.equalTo(self.titleLabel.snp.leading).offset(-10)
            $0.centerY.equalTo(self.titleLabel.snp.centerY)
            $0.width.height.equalTo(16)
        }
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.nextMonthButton.addTarget(self, action: #selector(willChangeMonth), for: .touchUpInside)
        self.preMonthButton.addTarget(self, action: #selector(willChangeMonth), for: .touchUpInside)
    }
}
