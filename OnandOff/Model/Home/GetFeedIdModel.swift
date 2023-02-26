//
//  GetFeedIdModel.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/22.
//
//import Foundation
//
//// MARK: - GetFeedIdModel
//struct GetFeedIdModel : Codable{
//    let feedArray: [FeedArray]?
//}
//
//// MARK: - FeedArray
//struct FeedArray : Codable{
//    let feedImgList: [String?]?
//    let feedId: Int?
//    let feedContent: String?
//    let createdAt: String?
//}

import Foundation

// MARK: - HomeCalendarModel
struct GetFeedIdModel : Codable {
    let statusCode: Int?
    let message: String?
    let result: GetFeedIdModelResult?
}

// MARK: - Result
struct GetFeedIdModelResult : Codable {
    let feedArray: [FeedArray]?
}

// MARK: - FeedArray
struct FeedArray :Codable{
    let feedImgList: [String?]?
    let feedId: Int?
    let feedContent: String?
    let createdAt: String?
}
