//
//  EmailModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/15.
//

import Foundation

class EmailModel: Codable {
    let statusCode: Int
    let message: String
    let result: EmailItem?
    let error: String?
    
}

class EmailItem: Codable {
    let email: String
}
