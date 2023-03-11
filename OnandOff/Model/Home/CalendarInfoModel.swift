//
//  CalendarInfoModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/10.
//

import UIKit

class CalendarInfoModel: Codable {
    let statusCode: Int
    let message: String
    let result: [CalendarInfoItem]
}

class CalendarInfoItem: Codable {
    let feedId: Int
    let feedImgUrl: String?
    let day: String
}
