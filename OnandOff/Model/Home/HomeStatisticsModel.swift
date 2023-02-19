//
//  HomeStatisticsModel.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/18.

import Foundation

// MARK: - HomeStatisticsModel
struct HomeStatisticsModel : Codable {
    let statusCode: Int?
    let message: String?
    let result: HomeStatisticsModelResult?
}

// MARK: - Result
struct HomeStatisticsModelResult : Codable {
    let monthly_likes_count: Int?
    let monthly_myFeeds_count: Int?
    let monthly_myFollowers_count: Int?
}
