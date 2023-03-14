//
//  UIViewController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/15.
//

import UIKit

extension UIViewController {
    func defaultAlert(title: String?, message: String? = nil, completion: (()->())? = nil) {
        let alert = StandardAlertController(title: title, message: message)
        let ok = StandardAlertAction(title: "확인", style: .basic) { _ in
            completion?()
        }
        alert.addAction(ok)
        
        self.present(alert, animated: false)
    }
}
