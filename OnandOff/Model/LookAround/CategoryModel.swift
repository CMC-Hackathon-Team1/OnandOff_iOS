//
//  CategoryModel.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/26.
//

import Foundation

class CategoryModel: Decodable {
    let statusCode: Int
    let message: String
    let result: [CategoryItem]
}

class CategoryItem: Decodable {
    let categoryId: Int
    let categoryName: String
}


