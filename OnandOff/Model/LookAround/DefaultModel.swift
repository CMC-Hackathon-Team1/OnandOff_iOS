//
//  DefaultModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/13.
//

import Foundation

class DefaultModel: Codable {
    let statusCode: Int
    let message: String
    let error: String?
}
