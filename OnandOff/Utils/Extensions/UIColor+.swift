//
//  UIColor+.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit

extension UIColor {
    class var mainColor: UIColor { return UIColor(named: "main") ?? UIColor() }
    class var text1: UIColor { return UIColor(named: "text1") ?? UIColor() }
    class var text2: UIColor { return UIColor(named: "text2") ?? UIColor() }
    class var text3: UIColor { return UIColor(named: "text3") ?? UIColor() }
    class var text4: UIColor { return UIColor(named: "text4") ?? UIColor() }
    class var point: UIColor { return UIColor(named: "point") ?? UIColor() }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
