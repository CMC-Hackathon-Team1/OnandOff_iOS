//
//  HomeCalendarModel.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/22.
//
//
//import Foundation
//
//// MARK: - HomeCalendarModel
//struct HomeCalendarModel : Codable {
//    let feedId: Int?
//    let feedImgUrl: String?
//    let day: String?
//}


import Foundation

// MARK: - HomeCalendarModel
struct HomeCalendarModel : Codable{
    let statusCode: Int?
    let message: String?
    let result: [HomeCalendarModelResult]?
}

// MARK: - Result
struct HomeCalendarModelResult : Codable{
    let feedId: Int?
    let feedImgUrl: String?
    let day: String?
}
