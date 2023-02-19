//
//  PostModelDataRequest.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/17.
//

import Foundation
import Alamofire
import UIKit

class PostModelDataRequest{
    func getRequestData(_ viewController: PostViewController,
                        profileId: Int,
                        categoryId: Int,
                        hashTagList: [String],
                        content: String,
                        isSecret: String
    ){
        var accessToken = TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken")
        let url = "https://dev.onnoff.shop/feeds"
        let header : HTTPHeaders = [.authorization(bearerToken: accessToken!)]
        let parameters: [String : Any] = [
            "profileId": profileId,
            "categoryId": categoryId,
            "hashTagList": hashTagList,
            "content": content,
            "isSecret": isSecret
        ]

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                print(key)
                print(value)
            }
        }, to: url,
                  method: .post,
                  headers: header).responseDecodable(of: PostModel.self) { response in
            switch response.result {
            case .success(let response):
                print("PostModelDataRequest response is :\(response)")
                print(response.message)

            case .failure(_):
                print("PostModelDataRequest fail")
                print(error.localizedDescription)
            }
        }

    }
}

