//
//  UIButton+.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/25.
//

import Foundation
import UIKit

extension UIButton {
    func makeCheckButton() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.1529411765, green: 0.1450980392, blue: 0.1215686275, alpha: 1)
        button.snp.makeConstraints {
            $0.height.width.equalTo(16)
        }
        button.clipsToBounds = true
        button.layer.cornerRadius = 16 / 2
    }
}
