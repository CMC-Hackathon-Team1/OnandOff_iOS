//
//  MyPageModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/06.
//

import UIKit

class MyPageModel: Codable {
    let statusCode: Int
    let message: String
    let result: MyPageResult
}

class MyPageResult: Codable {
    let feedArray: [MyPageItem]
}

class MyPageItem: Codable {
    let feedImgList: [String]
    var isLike: Bool
    let feedId: Int
    var feedContent: String
    let createdAt: String
    let likeNum: Int
    var hashTagList: [String]
}

struct MypageTempModel {
    let feedContent: String
    let feedId: Int
    let hashTag: [String]
}
