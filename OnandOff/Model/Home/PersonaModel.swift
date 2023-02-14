//
//  PersonaModel.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/14.
//

import Foundation

// MARK: - PersonaModel
struct PersonaModel : Codable{
    let statusCode: Int?
    let message: String?
    let result: Result?
}

// MARK: - Result
struct Result : Codable{
    let profileId: Int?
}
