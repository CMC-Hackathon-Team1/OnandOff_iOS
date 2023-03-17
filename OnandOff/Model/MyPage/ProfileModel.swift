//
//  ProfileModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/06.
//

import Foundation

class ProfileModel: Codable {
    let statusCode: Int
    let message: String
    let result: ProfileItem
}

class ProfileModels: Codable {
    let statusCode: Int
    let message: String
    let result: [ProfileItem]?
    let error: String?
}

class ProfileItem: Codable {
    let profileId: Int
    let personaName: String
    let profileName: String
    let statusMessage: String
    let profileImgUrl: String
    let createdAt: String
}
