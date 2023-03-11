//
//  AuthService.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/10.
//

import Alamofire
import UIKit

struct AuthService {
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
    
    static func kakaoLogin(_ parameter: KakaoDataModel, completion: @escaping(AuthResultModel?) -> Void) {
        AF.request("https://dev.onnoff.shop/auth/kakao-login",
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
    
    static func googleLogin(_ parameter: GoogleDataModel, completion: @escaping(AuthResultModel?) -> Void) {
        AF.request("https://dev.onnoff.shop/auth/google-login",
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
