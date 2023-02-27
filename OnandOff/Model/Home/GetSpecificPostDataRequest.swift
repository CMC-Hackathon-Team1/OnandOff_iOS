//
//  GetSpecificPostDataRequest.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/27.
//

import Foundation
import Alamofire
import UIKit

class GetSpecificPostDataRequest{
    func getSpecificPostRequestData(_ viewController: SpecificPostViewController, feedId : Int, profileId : Int){
        
        let accessToken = TokenService().read("https://dev.onnoff.shop/auth/login", account: "accessToken")
        let url = "https://dev.onnoff.shop/feeds/\(feedId)/profiles/\(profileId)"
        let header : HTTPHeaders = [.authorization(bearerToken: accessToken!)]
        //        HTTP Method GET
        AF.request(url,
                   method: .get,
                   //                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: header
        )
        .responseDecodable(of: GetSpecificPostModel.self) {response in
            
            switch response.result{
            case .success(let response):
                
                print("DEBUG>> GetFeedIdModel Success:  \(response)")
                viewController.didSuccessGetSpecificPost(response)
                
            case .failure(let error):
                print("DEBUG>> GetFeedIdModel Error : \(error.localizedDescription)")
                print(error.localizedDescription)
            }
            
        }
    }
    
}
