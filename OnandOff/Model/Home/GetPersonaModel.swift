//
//  GetPersonaModel.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/15.
//

import Foundation

// MARK: - QuestionControllerDataResponse
struct GetPersonaModel : Codable {
    let statusCode: Int?
    let message: String?
    let result: [ResultGetPersonaModel]?
}

// MARK: - Result
struct ResultGetPersonaModel : Codable{
    let profileId: Int?
    let personaName: String?
    let profileName: String?
    let statusMessage: String?
    let profileImgUrl: String?
    let createdAt: String?
}
