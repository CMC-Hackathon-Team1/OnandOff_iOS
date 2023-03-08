//
//  ProfileService.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/08.
//

import Foundation
import Alamofire

class ProfileService {
    private static let baseURL = "https://dev.onnoff.shop/"
    
    static func editProfile(_ profileId: Int, profileName: String, statusMessage: String, image: String, defaultImage: Bool) {
        let url = baseURL + "/profiles/\(profileId)"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameter: Parameters = ["profileName" : profileName,
                                     "statusMessage" : statusMessage,
                                     "image" : image,
                                     "defaultImage" : defaultImage]
        let request = AF.request(url, parameters: parameter, encoding: JSONEncoding.default, headers: header)
        request.responseString() { res in}
    }
}
