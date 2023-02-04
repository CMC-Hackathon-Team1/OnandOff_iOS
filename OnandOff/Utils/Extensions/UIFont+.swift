//
//  UIFont+.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit

extension UIFont {
    enum Family: String {
        case Bold, Regular
    }
    
    static func notoSans(size: CGFloat, family: Family = .Regular) -> UIFont {
        return UIFont(name: "NotoSans-\(family)", size: size) ?? UIFont()
    }
    
    static func interBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Bold", size: size) ?? UIFont()
    }
}
