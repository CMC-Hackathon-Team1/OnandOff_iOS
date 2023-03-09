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
    
    static func editProfile(_ profileId: Int, profileName: String, statusMessage: String, image: UIImage?, defaultImage: Bool) {
        let url = baseURL + "profiles/\(profileId)"
        var header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        header?["Content-Type"] = "multipart/form-data"
        var parameters: Parameters = ["profileName" : profileName,
                                     "statusMessage" : statusMessage,
                                     "defaultImage" : defaultImage]
        
        let request = AF.upload(multipartFormData: { (multipartFormData) in
            if let imageData = image?.pngData() {
                multipartFormData.append(imageData, withName: "image", fileName: "\(imageData).png", mimeType: "image/png")
            }
            for (key,value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
        }, to: url, method: .patch, headers: header)
        
        request.responseString() { res in
            switch res.result {
            case .success(let str):
                print(str)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
