//
//  AuthService.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/10.
//

import Alamofire
import UIKit

struct AuthService {
    static let baseURL = "https://dev.onnoff.shop/"
    
    static func userLogin(email: String, password: String, completion: @escaping(AuthResultModel?) -> Void) {
        let url = baseURL + "auth/login"
        let parameter: Parameters = ["email" : email,
                                      "password" : password]
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default)
                   .responseDecodable(of: AuthResultModel.self) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Login Error: \(error.localizedDescription)")
            }
        }
    }
    
    static func kakaoLogin(_ accessToken: String, completion: @escaping(AuthResultModel?) -> Void) {
        let url = baseURL + "auth/kakao-login"
        print("kakao Token : \(accessToken)")
        let parameter: Parameters = ["access_token" : accessToken]
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default)
            .responseDecodable(of: AuthResultModel.self) { res in
                switch res.result {
                case .success(let result):
                    completion(result)
                    
                case .failure(let error):
                    print("Login Error: \(error.localizedDescription)")
                }
            }
    }
    
    static func googleLogin(_ idToken: String, completion: @escaping(AuthResultModel?) -> Void) {
        let url = baseURL + "auth/google-login"
        let parameter: Parameters = ["id_token" : idToken]
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default)
                   .responseDecodable(of: AuthResultModel.self) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Login Error: \(error.localizedDescription)")
            }
        }
    }
    
    static func appleLogin(_ idToken: String, completion: @escaping(AuthResultModel?)->Void) {
        let url = baseURL + "auth/apple-login"
        let parameter: Parameters = ["identity_token" : idToken]
    
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default)
            .responseDecodable(of: AuthResultModel.self) { res in
                switch res.result {
                case .success(let result):
                    completion(result)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func userRegister(email: String, password: String, level: Int, completion: @escaping(AuthResultModel?) -> Void) {
        let url = baseURL + "auth/signup/\(level)"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameter: Parameters = ["email" : email,
                                     "password" : password]
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: AuthResultModel.self) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("Register Error: \(error.localizedDescription)")
            }
        }
    }
    
    static func userLogOut(_ completion: @escaping(AuthResultModel?) -> Void) {
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request("https://dev.onnoff.shop/auth/logout",
                   method: .post,
                   headers: header).responseDecodable(of: AuthResultModel.self) { response in
            switch response.result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print("LogOut Error: \(error.localizedDescription)")
            }
        }
    }

    static func getUserEmail(completion: @escaping (EmailItem?)->Void) {
        let url = baseURL + "users/email"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request(url, headers: header)
            .responseDecodable(of: EmailModel.self) { res in
                switch res.result {
                case .success(let model):
                    if let item = model.result {
                        completion(item)
                    } else { completion(nil) }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func withdrawalMember(completion: @escaping (Bool)->Void) {
        let url = baseURL + "users/account"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request(url, method: .delete, headers: header)
            .responseDecodable(of: DefaultModel.self) { res in
                switch res.result {
                case .success(let model):
                    if model.statusCode == 100 {
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func changeAccountState(_ userStatus: String) {
        let url = baseURL + "users/status"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameter: Parameters = ["userStatus" : userStatus]
        AF.request(url, method: .patch, parameters: parameter, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: DefaultModel.self) { res in
                switch res.result {
                case .success(let model):
                    if model.statusCode == 100 { print("성공") }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func sendMail(content: String, completion: @escaping (Bool)->()) {
        let url = baseURL + "users/send-mail"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameter: Parameters = ["content" : content]
        let request = AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
            .responseDecodable(of: DefaultModel.self) { res in
                switch res.result {
                case .success(let model):
                    if model.statusCode == 100 {
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
