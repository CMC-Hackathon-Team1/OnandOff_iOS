//
//  AuthModel.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/10.
//

import Foundation
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
    let state: String?
    let jwt: String?
}

// MARK: - KakaoModel
struct KakaoDataModel: Codable {
    let access_token: String?
}

// MARK: - GoogleModel
struct GoogleDataModel: Codable {
    let id_token: String?
}
