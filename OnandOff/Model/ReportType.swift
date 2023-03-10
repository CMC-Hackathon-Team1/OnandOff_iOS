//
//  ReportType.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/16.
//

import Foundation

enum ReportType: Int, CaseIterable {
    case spam = 1
    case obscene = 2
    case curse = 3
    case repeating = 4
    case privacy = 5
    case other = 6
    
    var description: String {
        switch self {
        case .spam: return "스팸 및 홍보글"
        case .obscene: return "음란성이 포함된 글"
        case .curse: return "욕설 / 생명경시 / 혐오 / 차별적인 글"
        case .repeating: return "게시글 도배"
        case .privacy: return "개인정보 노출 및 불법 정보"
        case .other: return "기타"
        }
    }
}
