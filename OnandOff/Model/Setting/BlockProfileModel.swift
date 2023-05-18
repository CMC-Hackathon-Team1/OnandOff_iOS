//
//  BlockProfileModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/05/18.
//

import Foundation

class BlockProfileModel: Codable {
    let statusCode: Int
    let message: String
    let result: [BlockProfileItem]?
}

class BlockProfileItem: Codable {
    let profileId: Int
    let personaName: String
    let profileName: String
    let profileImgUrl: String
}
