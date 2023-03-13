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
    
    static func createFeed(_ profileId: Int, categoryId: Int, hasTagList: [String], content: String, isSecret: String, images: [UIImage], completion: @escaping () -> Void) {
        let url = baseURL + "feeds"
        var header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        header?["Content-Type"] = "multipart/form-data"
        let parameters: Parameters = ["profileId" : profileId,
                                     "categoryId" : categoryId,
                                     "hashTagList" : hasTagList,
                                     "content" : content,
                                     "isSecret" : isSecret]
        let request = AF.upload(multipartFormData: { multipartFormData in
            for image in images {
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    multipartFormData.append(imageData, withName: "images", fileName: "\(imageData).jpeg", mimeType: "image/jpeg")
                }
            }
            for (key,value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
        }, to: url, method: .post, headers: header)
        
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
    
    static func fetchFeed(_ profileId: Int, categoryId: Int, page: Int = 1, fResult: Bool = false, completion: @escaping ([FeedItem])->()) {
        let url = baseURL + "feeds/feedlist/\(profileId)?page=\(page)&categoryId=\(categoryId)&fResult=\(fResult)"
        print(url)
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let request = AF.request(url, headers: header)
    
        request.responseDecodable(of: FeedListModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.result ?? [])
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
                completion(model.result ?? [])
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
    
    static func getFeedWithFeedId(_ profileId: Int, feedId: Int, completion: @escaping (DetailFeedItem) -> Void) {
        let url = baseURL + "feeds/\(feedId)/profiles/\(profileId)"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let request = AF.request(url, headers: header)
        request.responseDecodable(of: DetailFeedItem.self) { res in
            switch res.result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func editFeed(_ profileId: Int, feedId: Int, categoryId: Int, hashTagList: [String], content: String, isSecret: String, completion: @escaping ()->Void) {
        let url = baseURL + "feeds"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameters: Parameters = ["profileId" : profileId,
                                     "categoryId" : categoryId,
                                     "hashTagList" : hashTagList,
                                      "feedId" : feedId,
                                     "content" : content,
                                     "isSecret" : isSecret]
        let request = AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: header)
        
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
    
    static func deleteFeed(profileId: Int, feedId: Int, completion: @escaping () -> Void) {
        let url = baseURL + "feeds/status"
        var header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameter: Parameters = ["profileId" : profileId,
                                     "feedId" : feedId]
        let request = AF.request(url, method: .patch, parameters: parameter, encoding: JSONEncoding.default, headers: header)
        request.responseString() { res in
            switch res.result {
            case .success(let str):
                completion()
                print(str)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func isFollowing(fromProfileId: Int, toProfileId: Int, completion: @escaping (Bool)->Void) {
        let url = baseURL + "follow/test"
        var header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameter: Parameters = ["fromProfileId" : fromProfileId,
                                     "toProfileId" : toProfileId]
        let request = AF.request(url, method: .post, parameters: parameter,headers: header)
        request.responseDecodable(of: DefaultModel.self) { res in
            switch res.result {
            case .success(let model):
                print(model)
                var isFollowing = model.message == "Follow" ? true : false
                completion(isFollowing)
            case .failure(let error):
                print(error)
            }
        }
    }
}
