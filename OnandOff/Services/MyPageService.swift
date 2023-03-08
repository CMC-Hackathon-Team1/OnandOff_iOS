//
//  MyPageService.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/06.
//

import Foundation
import Alamofire

class MyPageService {
    private static let baseURL = "https://dev.onnoff.shop/"
    
    static func fetchFeedWithDate(_ baseId: Int, targetId: Int, year: String, month: String, day: Int?, page: Int = 1, completion: @escaping ([MyPageItem])->()) {
        let url = baseURL + "feeds/monthly"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        var parameter: Parameters = ["baseProfileId" : baseId,
                                     "targetProfileId" : targetId,
                                     "year" : year,
                                     "month" : month,
                                     "page" : page]
        if let day = day { parameter["day"] = day }
        let request = AF.request(url, parameters: parameter, encoding: URLEncoding.queryString, headers: header)
        request.responseDecodable(of: MyPageModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.result.feedArray)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func fetchProfile(_ profileId: Int, completion: @escaping (ProfileItem)->()) {
        let url = baseURL + "profiles/" + "\(profileId)"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let request = AF.request(url, headers: header)
        request.responseDecodable(of: ProfileModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
