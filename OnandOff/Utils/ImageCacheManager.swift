//
//  ImageCacheManager.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/18.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
