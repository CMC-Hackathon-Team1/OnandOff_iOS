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
    
    static func createProfile(profileName: String, personaName: String, statusMessage: String, image: UIImage, completion: @escaping (Int)->Void) {
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
        
        request.responseDecodable(of: CreateProfileModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.statusCode)
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
            }
        }
        
        request.responseString() { res in
            switch res.result {
            case .success(let str):
                print(str)
            case .failure(let error):
                print(error)
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
    
    static func blockProfile(_ toProfileId: Int, block: Bool, completion: @escaping (Int) -> Void) {
        let url = baseURL + "profile-block"
        let fromProfileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        let parameter: Parameters = ["fromProfileId" : fromProfileId,
                                     "toProfileId" : toProfileId,
                                     "type" : block ? "BLOCK" : "UNBLOCK"
        ]
    
        let request = AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
        request.responseDecodable(of: DefaultModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model.statusCode)
            case .failure(let error):
                print("HTTP Error: \(error)")
            }
        }
    }
    
    static func fetchBlockProfileList(completion: @escaping (BlockProfileModel) -> Void) {
        let profileId = UserDefaults.standard.integer(forKey: "selectedProfileId")
        let url = baseURL + "profile-block/blocked-profiles?profileId=\(profileId)"
        let header = TokenService().getAuthorizationHeader(serviceID: "https://dev.onnoff.shop/auth/login")
        
        let request = AF.request(url, headers: header)
        
        request.responseDecodable(of: BlockProfileModel.self) { res in
            switch res.result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                print(error)
            }
        }
    }
}
