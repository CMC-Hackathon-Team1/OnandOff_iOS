//
//  FeedService.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/18.
//

import Foundation
import Alamofire

class FeedService {
    private static let baseURL = "https://dev.onnoff.shop/"
    
    static func fetchFeed(_ profileId: Int, categoryId: Int, page: Int = 1, fResult: Bool = false, completion: @escaping ([FeedItem])->()) {
        let url = baseURL + "feeds/feedlist/\(profileId)?page=\(page)&categoryId=\(categoryId)&fResult=\(fResult)"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let request = AF.request(url, headers: header)
    
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
    
    static func searchFeed(_ profileId: Int, text: String, categoryId: Int, page: Int = 1, fResult: Bool = false, completion: @escaping ([FeedItem])->()) {
        let url = baseURL + "feeds/feedlist/\(profileId)/search"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameter: Parameters = ["page" : page,
                                     "categoryId" : categoryId,
                                     "fResult" : fResult,
                                     "query" : text]
        let request = AF.request(url, parameters: parameter, encoding: URLEncoding.queryString, headers: header)
        
        request.responseDecodable(of: FeedListModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getCategoryAPI(completion: @escaping ([CategoryItem])->()) {
        let url = baseURL + "categories/categories"
      
        let request = AF.request(url)
        request.responseDecodable(of: CategoryModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.result)
            case .failure(let error):
                print(error)
            }
        }  
    }
    
    static func reportFeed(feedId: Int, categoryId: Int, content: String?, completion: @escaping (ReportModel)->()) {
        let url = baseURL + "reports"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameter: Parameters = [ "feedId" : feedId,
                                      "reportedCategoryId" : categoryId,
                                      "content" : content ?? ""
        ]
        let request = AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
        request.responseDecodable(of: ReportModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getCalendarInfo(profileId: Int, year: String, month: String, completion: @escaping ([CalendarInfoItem])->Void) {
        let url = baseURL + "feeds/my-feeds/in-calendar?profileId=\(profileId)&year=\(year)&month=\(month)"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let request = AF.request(url, headers: header)
        request.responseDecodable(of: CalendarInfoModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
