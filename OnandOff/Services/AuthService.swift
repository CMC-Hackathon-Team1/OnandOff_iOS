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
    static func userLogin(_ parameter: AuthDataModel, completion: @escaping(AuthResultModel?) -> Void) {
        AF.request("https://dev.onnoff.shop/auth/login",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil).validate().responseDecodable(of: AuthResultModel.self) { response in
            switch response.result {
            case .success(let result):
                print("AccessToken: \(result.result?.jwt)")
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
                    print("AccessToken: \(result.result?.jwt)")
                    print("statusCode: \(result.statusCode)")
                    print("error: \(result.error)")
                    print("state: \(result.result?.state)")
                    print("message: \(result.message)")
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
                    print("AccessToken: \(result.result?.jwt)")
                    print("statusCode: \(result.statusCode)")
                    print("error: \(result.error)")
                    print("state: \(result.result?.state)")
                    print("message: \(result.message)")
                    completion(result)
                case .failure(let error):
                    print(error)
                }
            }
     
    }
    
    static func userRegister(_ parameter: AuthDataModel, completion: @escaping(AuthResultModel?) -> Void) {
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request("https://dev.onnoff.shop/auth/signup",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: header).validate().responseDecodable(of: AuthResultModel.self) { response in
            switch response.result {
            case .success(let result):
                print("StatusCode: \(result.statusCode)")
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
}
