//
//  GetSpecificPostModel.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/27.
//

import Foundation

// MARK: - GetSpecificPostModel
struct GetSpecificPostModel : Codable{
    let feedImgList: [String?]?
    let hashTagList: [String?]?
    let feedId: Int?
    let personaName: String?
    let profileName: String?
    let feedContent: String?
    let profileImg: String?
    let createdAt: String?
    let isLike: Bool?
    let isFollowing: Bool?
}
