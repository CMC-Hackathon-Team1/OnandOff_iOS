//
//  DetailFeedModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/12.
//

import Foundation

class DetailFeedModel: Codable {
    let statusCode: Int
    let message: String
    let result: DetailFeedItem?
}

class DetailFeedItem: Codable {
    let feedImgList: [String]
    let hashTagList: [String]
    let feedId: Int
    let personaName: String
    let profileName: String
    let feedContent: String
    let profileImg: String
    let createdAt: String
    let isLike: Bool
    let likeNum: Int
    let isFollowing: Bool
    let categoryId: Int
    let isSecret: String
}
