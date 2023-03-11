//
//  PostModel.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/17.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let questionControllerDataResponse = try? JSONDecoder().decode(QuestionControllerDataResponse.self, from: jsonData)

import Foundation

// MARK: - QuestionControllerDataResponse
struct PostModel : Codable{
    let statusCode: Int?
    let message: String?
}
