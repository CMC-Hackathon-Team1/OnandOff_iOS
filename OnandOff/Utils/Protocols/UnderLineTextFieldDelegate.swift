//
//  UnderLineTextFieldDelegate.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/14.
//

import UIKit

protocol UnderLineTextFieldDelegate: AnyObject {
    func didChangeText(_ textfield: UITextField)
}
