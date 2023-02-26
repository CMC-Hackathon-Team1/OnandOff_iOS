//
//  GetFeedIdDataRequest.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/22.
//
import Foundation
import Alamofire
import UIKit

class GetFeedIdDataRequest{
    func getHomeCalendarRequestData(_ viewController: HomeViewController, profileId : Int, year : Int, month : String, day : String, page : Int){
        
        let accessToken = TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken")
        let url = "https://dev.onnoff.shop/feeds/my-feeds/by-month?profileId=\(profileId)&year=\(year)&month=\(month)&day=\(day)&page=\(page)"
        let header : HTTPHeaders = [.authorization(bearerToken: accessToken!)]
        //        HTTP Method GET
        AF.request(url,
                   method: .get,
                   //                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header
        )
        .responseDecodable(of: GetFeedIdModel.self) {response in
            
            switch response.result{
            case .success(let response):
                
                print("DEBUG>> GetFeedIdModel Success:  \(response)")
                print(profileId)
                print(year)
                print(month)
                print(day)
                print(page)
                viewController.didSuccessGetFeedId(response)
                
            case .failure(let error):
                print("DEBUG>> GetFeedIdModel Error : \(error.localizedDescription)")
                print(error.localizedDescription)
            }
            
        }
    }
    
}
