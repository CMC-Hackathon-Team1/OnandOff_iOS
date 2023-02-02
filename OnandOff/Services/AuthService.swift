//
//  AuthService.swift
//  OnandOff
//
//  Created by e2phus on 2023/01/31.
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
    
    static func userRegister(_ parameter: AuthDataModel, completion: @escaping(AuthResultModel?) -> Void) {

        AF.request("https://dev.onnoff.shop/auth/signup",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: nil).validate().responseDecodable(of: AuthResultModel.self) { response in
            switch response.result {
            case .success(let result):
                print("StatusCode: \(result.statusCode)")
                completion(result)
                
            case .failure(let error):
                print("Register Error: \(error.localizedDescription)")
            }
        }
    }
    
    static func userLogOut(_ parameter: AuthDataModel?, headers: HTTPHeaders, completion: @escaping(AuthResultModel?) -> Void) {

        AF.request("https://dev.onnoff.shop/auth/logout",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).validate().responseDecodable(of: AuthResultModel.self) { response in
            switch response.result {
            case .success(let result):
                print("StatusCode: \(result.statusCode)")
                print("Message: \(result.message)")
                print("Todo: \(result.result?.TODO ?? "")")
                completion(result)
                
            case .failure(let error):
                print("LogOut Error: \(error.localizedDescription)")
            }
        }
    }
}
