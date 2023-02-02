//
//  AuthModel.swift
//  OnandOff
//
//  Created by e2phus on 2023/01/31.
//

import Alamofire

// MARK: - LoginDataModel
struct AuthDataModel: Codable {
    let email: String
    let password: String
}

// MARK: - LoginResultModel
struct AuthResultModel: Codable {
    let statusCode: Int
    let message: String
    let result: UserData?
    let error: String?
}

// MARK: - UserData
struct UserData: Codable {
    let jwt: String?
    let userId: Int?
    let TODO: String?
}
