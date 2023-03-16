//
//  AlarmStatusModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/16.
//

import Foundation

class AlarmStatusModel: Codable {
    let statusCode: Int
    let message: String
    let result: AlarmStatusItem?
    let error: String?
}

class AlarmStatusItem: Codable {
    let followAlarmStatus: Bool
    let likeAlarmStatus: Bool
    let noticeAlarmStatus: Bool
}
