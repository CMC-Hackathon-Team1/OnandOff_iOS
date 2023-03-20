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
    
    let customImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 11
        $0.layer.masksToBounds = true
    }
    
    override init!(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(self.customImageView)
        self.customImageView.snp.remakeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(-7)
            $0.width.height.equalTo(22)
            $0.centerX.equalToSuperview()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.customImageView.image = nil
    }
}
