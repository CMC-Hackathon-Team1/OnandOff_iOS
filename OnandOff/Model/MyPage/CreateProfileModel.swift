//
//  CreateProfileModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/15.
//

import Foundation

class CreateProfileModel: Codable {
    let statusCode: Int
    let message: String
    let result: CreateProfileItem?
    let error : String?
}

class CreateProfileItem: Codable {
    let profileId: Int
}
