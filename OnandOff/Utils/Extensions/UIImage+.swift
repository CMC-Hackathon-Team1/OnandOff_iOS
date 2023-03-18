//
//  UIImage+.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/26.
//

import UIKit
import Alamofire

extension UIImageView {
    func loadImage(_ urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        if let cacheImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cacheImage
            return
        }
        
        AF.request(urlString).responseData() { res in
            switch res.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                    self.image = image
                } else {
                    print("올바르지 않은 이미지 URL")
                }
            case .failure(let error):
                print("Image load error : \(error)")
            }
        }
    }
}
