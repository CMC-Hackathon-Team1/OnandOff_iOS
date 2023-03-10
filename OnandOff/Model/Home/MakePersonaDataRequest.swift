//
//  PersonaDataRequest.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/14.
//

import Foundation
import Alamofire
import UIKit

class MakePersonaDataRequest{
    func getRequestData(_ viewController: ProfileMakeViewController,
                        profileName: String,
                        personaName: String,
                        statusMessage: String,
                        image: UIImage
    ){
        var accessToken = TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken")
        let url = "https://dev.onnoff.shop/profiles"
        let header : HTTPHeaders = [.authorization(bearerToken: accessToken!)]
        let parameters: [String : Any] = [
            "profileName": profileName,
            "personaName": personaName,
            "statusMessage": statusMessage
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                print(key)
                print(value)
            }
            if let imageData = image.pngData() {
                multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
                print(imageData)
            }
           
        }, to: url,
                  method: .post,
                  headers: header).responseDecodable(of: PersonaModel.self) { response in
            switch response.result {
            case .success(let response):
                print("response is :\(response)")
                print(response.message)
                print(response.result?.profileId)
                
            case .failure(_):
                print("fail")
                print(error.localizedDescription)
            }
        }
        
    }
}


public enum MyError: Error {
    case customError
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError:
            return NSLocalizedString("A user-friendly description of the error.", comment: "My error")
        }
    }
}

let error: Error = MyError.customError
 // A user-friendly description of the error.
