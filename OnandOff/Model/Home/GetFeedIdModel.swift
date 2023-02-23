//
//  GetFeedIdModel.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/22.
//
import Foundation

// MARK: - GetFeedIdModel
struct GetFeedIdModel : Codable{
    let feedArray: [FeedArray]?
}

// MARK: - FeedArray
struct FeedArray : Codable{
    let feedImgList: [String?]?
    let feedId: Int?
    let feedContent: String?
    let createdAt: String?
}
