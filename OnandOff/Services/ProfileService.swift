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
        let parameters: Parameters = ["profileName" : profileName,
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
    
    static func createProfile(profileName: String, personaName: String, statusMessage: String, image: UIImage, completion: @escaping ()->Void) {
        let url = baseURL + "profiles/"
        var header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        header?["Content-Type"] = "multipart/form-data"
        let parameters: Parameters = ["profileName" : profileName,
                                     "statusMessage" : statusMessage,
                                     "personaName" : personaName]
        
        let request = AF.upload(multipartFormData: { (multipartFormData) in
            if let imageData = image.jpegData(compressionQuality: 0.4) {
                multipartFormData.append(imageData, withName: "image", fileName: "\(imageData).jpeg", mimeType: "image/jpeg")
            }
            for (key,value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
        }, to: url, method: .post, headers: header)
        
        request.responseString() { res in
            switch res.result {
            case .success(let str):
                print(str)
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getProfileModels(_ completion: @escaping (ProfileModels) -> Void) {
        let url = baseURL + "profiles/my-profiles"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")

        AF.request(url, headers: header)
        .responseDecodable(of: ProfileModels.self) { res in
            switch res.result{
            case .success(let models):
                completion(models)
            case .failure(let error):
                print("DEBUG>> GetPersonaDataRequest Error : \(error.localizedDescription)")
                print(error.localizedDescription)
            }
        }
    }
    
    static func deleteProfile(_ profileId: Int, completion: @escaping () -> Void) {
        let url = baseURL + "profiles/\(profileId)"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        AF.request(url, method: .delete, headers: header).responseString() { res in
            switch res.result {
            case .success(let str):
                print(str)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
}
