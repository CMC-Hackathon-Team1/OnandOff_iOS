//
//  FeedListModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/25.
//

import Foundation

class FeedListModel: Decodable {
    let statusCode: Int
    let message: String
    let result: [FeedItem]
}

class FeedItem: Decodable {
    let feedImgList: [String]
    var isLike: Bool
    var isFollowing: Bool
    let feedId: Int
    let personaId: Int
    let personaName: String
    let profileId: Int
    let profileName: String
    let feedContent: String
    let createdAt: String
}
