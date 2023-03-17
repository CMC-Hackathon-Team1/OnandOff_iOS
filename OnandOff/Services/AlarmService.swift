//
//  AlarmService.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/16.
//

import Foundation
import Alamofire

final class AlarmService {
    static let baseURL = "https://dev.onnoff.shop/"
    
    static func sendToken(_ alarmToken: String) {
        let url = baseURL + "alarms/token"
        let parameter: Parameters = ["alarmToken" : alarmToken]
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
            .responseString() { res in
                switch res.result {
                case .success(let str):
                    print(str)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func getCurrentStatus(completion: @escaping (AlarmStatusItem)->Void) {
        let url = baseURL + "alarms/status"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request(url, headers: header)
            .responseDecodable(of: AlarmStatusModel.self) { res in
                switch res.result {
                case .success(let model):
                    if let item = model.result {
                        completion(item)
                    } else {
                        print(model.message)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func changeNoticeAlert(_ isUse: Bool, completion: @escaping (Bool)->Void) {
        let url = baseURL + "alarms/notice"
        let parameter: Parameters = ["statusCode" : isUse ? 0 : 1]
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request(url, method: .patch, parameters: parameter, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: DefaultModel.self) { res in
                switch res.result {
                case .success(let model):
                    if model.statusCode == 3501 {
                        completion(true)
                    } else if model.statusCode == 3502 {
                        completion(false)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func changeLikeAlert(_ isUse: Bool, completion: @escaping (Bool)->Void) {
        let url = baseURL + "alarms/like"
        let parameter: Parameters = ["statusCode" : isUse ? 0 : 1]
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request(url, method: .patch, parameters: parameter, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: DefaultModel.self) { res in
                switch res.result {
                case .success(let model):
                    if model.statusCode == 3501 {
                        completion(true)
                    } else if model.statusCode == 3502 {
                        completion(false)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func changeFollowingAlert(_ isUse: Bool, completion: @escaping (Bool)->Void) {
        let url = baseURL + "alarms/following"
        let parameter: Parameters = ["statusCode" : isUse ? 0 : 1]
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request(url, method: .patch, parameters: parameter, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: DefaultModel.self) { res in
                switch res.result {
                case .success(let model):
                    if model.statusCode == 3501 {
                        completion(true)
                    } else if model.statusCode == 3502 {
                        completion(false)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
