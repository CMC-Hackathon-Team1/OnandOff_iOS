//
//  HomeCalendarDataRequest.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/22.
//
import Foundation
import Alamofire
import UIKit

class HomeCalendarDataRequest{
    func getHomeCalendarRequestData(_ viewController: HomeViewController, profileId : Int, year : Int, month : String){
        
        let accessToken = TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken")
        let url = "https://dev.onnoff.shop/feeds/my-feeds/in-calendar?profileId=\(profileId)&year=\(year)&month=\(month)"
        let header : HTTPHeaders = [.authorization(bearerToken: accessToken!)]

        //HTTP Method GET
        AF.request(url,
                   method: .get,
//                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header
                   )
        .responseDecodable(of: [HomeCalendarModel].self) {response in

            switch response.result{
            case .success(let response):
                
                print("DEBUG>> getHomeCalendarRequestData Success:  \(response)")
                print(profileId)
                viewController.didSuccessCalendar(response)

            case .failure(let error):
                print("DEBUG>> getHomeCalendarRequestData Error : \(error.localizedDescription)")
                print(error.localizedDescription)
            }
        }
    }
}
