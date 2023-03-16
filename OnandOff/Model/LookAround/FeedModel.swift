//
//  FeedModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/16.
//

import Foundation

//class FeedModel: Codable {
//    
//    let result: FeedInfo?
//    let error: String?
//}

class FeedInfo: Codable {
    let feedImgList: [String]
    let hashTagList: [String]
    let feedId: Int
    let personaName: String
    let profileName: String
    let feedContent: String
    let profileImg: String
    let createdAt: String
    var isLike: Bool
    let likeNum: Int
    var isFollowing: Bool
    let categoryId: Int
    let isSecret: String
}
