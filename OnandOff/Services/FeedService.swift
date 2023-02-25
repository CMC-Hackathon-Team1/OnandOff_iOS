//
//  FeedService.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/18.
//

import Foundation
import Alamofire

class FeedService {
    static let baseURL = "https://dev.onnoff.shop/"
    
    static func fetchFeed(_ profileId: Int, categoryId: Int, page: Int = 1, fResult: Bool = false, completion: @escaping ([FeedItem])->()) {
        let url = baseURL + "feeds/feedlist/\(profileId)?page=\(page)&categoryId=\(categoryId)&fResult=\(fResult)"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let request = AF.request(url, headers: header)
        
        request.responseString() { res in
            switch res.result {
            case .success(let str):
                print(str)
            case .failure(let error):
                print(error)
            }
        }
        request.responseDecodable(of: FeedListModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func toggleLike(profileId: Int, feedId: Int, completion: @escaping ()->()) {
        let url = baseURL + "likes"
        let parameter: Parameters = ["profileId" : profileId,
                                     "feedId" : feedId ]
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let request = AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
        request.responseString() { res in
            switch res.result {
            case .success(let str):
                print(str)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func togglefollow(fromProfileId: Int, toProfileId: Int, completion: @escaping ()->()) {
        let url = baseURL + "follow"
        let parameter: Parameters = ["fromProfileId" : fromProfileId,
                                     "toProfileId" : toProfileId ]
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let request = AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
        request.responseString() { res in
            switch res.result {
            case .success(let str):
                print(str)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
