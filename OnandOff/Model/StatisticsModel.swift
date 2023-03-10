//
//  StatisticsModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/10.
//

import Foundation

class StatisticsModel: Codable {
    let statusCode: Int
    let message: String
    let result: StatisticsItem
}

class StatisticsItem: Codable {
    let monthly_likes_count: Int
    let monthly_myFeeds_count: Int
    let monthly_myFollowers_count: Int
}
