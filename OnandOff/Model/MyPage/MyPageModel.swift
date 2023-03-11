//
//  MyPageModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/06.
//

import Foundation

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
    let isLike: Bool
    let feedId: Int
    let feedContent: String
    let createdAt: String
    let likeNum: Int
}
