//
//  StatisticsService.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/09.
//

import Foundation
import Alamofire

enum StatisticsType {
    case likeCount
    case feedCount
    case follower
    
    var description: String {
        switch self {
        case .feedCount: return "my-feeds"
        case .follower: return "followers"
        case .likeCount: return "likes"
        }
    }
}

class StatisticsService {
    private static let baseURL = "https://dev.onnoff.shop/"
    
    static func getStatistics(_ profileId: Int, completion: @escaping (StatisticsItem)->Void) {
        let url = baseURL + "statistics/\(profileId)/monthly"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let request = AF.request(url, headers: header)
        
        request.responseDecodable(of: StatisticsModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
