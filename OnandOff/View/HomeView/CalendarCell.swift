//
//  CalendarCell.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/11.
//

import UIKit
import FSCalendar

final class CalendarCell: FSCalendarCell {
    static let identifier = "CalendarCell"
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.image = UIImage(named: "plus")
        self.imageView.isHidden = false
        self.imageView.contentMode = .scaleToFill
    
        self.imageView.layer.cornerRadius = 11
        self.imageView.layer.masksToBounds = true
        self.imageView.snp.remakeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(-7)
            $0.width.height.equalTo(22)
            $0.centerX.equalToSuperview()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
}
