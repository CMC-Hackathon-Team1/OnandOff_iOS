//
//  Date+.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/10.
//

import Foundation

extension Date {
    var getString: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "YYYY-MM-dd"
            $0.locale = .current
            $0.timeZone = .current
        }
        return formatter.string(from: self)
    }
    
    var getYear: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "YYYY"
            $0.locale = .current
            $0.timeZone = .current
        }
        return formatter.string(from: self)
    }
    
    var getMonth: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "MM"
            $0.locale = .current
            $0.timeZone = .current
        }
        return formatter.string(from: self)
    }
    
    var getDay: String {
        let formatter = DateFormatter().then {
            $0.dateFormat = "dd"
            $0.locale = .current
            $0.timeZone = .current
        }
        return formatter.string(from: self)
    }
    
    init (_ dateString: String) {
        self.init()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.locale = .current
        formatter.timeZone = .current
        if let date = formatter.date(from: dateString) {
            self = date
        }
    }
}
