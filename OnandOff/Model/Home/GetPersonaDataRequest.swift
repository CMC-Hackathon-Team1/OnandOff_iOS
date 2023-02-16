//
//  GetPersonaDataRequest.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/15.
//

import Foundation
import Alamofire
import UIKit

class GetPersonaDataRequest{
    func getRequestData(_ viewController: HomeViewController){
        let accessToken = TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken")
        let url = "https://dev.onnoff.shop/profiles/my-profiles"
        let header : HTTPHeaders = [.authorization(bearerToken: accessToken!)]

        //HTTP Method GET
        AF.request(url,
                   method: .get,
//                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header
                   )
        .responseDecodable(of: GetPersonaModel.self) {response in

            switch response.result{
            case .success(let response):
                print("DEBUG>> GetPersonaDataRequest Success:  \(response)")
                viewController.didSuccess(response)

            case .failure(let error):
                print("DEBUG>> GetPersonaDataRequest Error : \(error.localizedDescription)")
                print(error.localizedDescription)
            }
        }
    }
}
