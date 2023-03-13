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
        DispatchQueue.global().async {
            guard let url = URL(string: urlString) else { return }
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } catch(let error) {
                print(error)
            }
        }
    }
}
