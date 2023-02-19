//
//  HomeStatisticsDataRequest.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/18.
//

import Foundation
import Alamofire
import UIKit

class HomeStatisticsDataRequest{
    func getStatisticsRequestData(_ viewController: HomeViewController, profileId : Int){
        
        let accessToken = TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken")
        let url = "https://dev.onnoff.shop/statistics/\(profileId)/monthly"
        let header : HTTPHeaders = [.authorization(bearerToken: accessToken!)]

        //HTTP Method GET
        AF.request(url,
                   method: .get,
//                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header
                   )
        .responseDecodable(of: HomeStatisticsModel.self) {response in

            switch response.result{
            case .success(let response):
                
                print("DEBUG>> HomeStatisticsDataRequest Success:  \(response)")
                print(profileId)
                viewController.didSuccessStatistics(response)

            case .failure(let error):
                print("DEBUG>> HomeStatisticsDataRequest Error : \(error.localizedDescription)")
                print(error.localizedDescription)
            }
        }
    }
}
