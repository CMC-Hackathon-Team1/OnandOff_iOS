//
//  ActionSheetDelegate.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/12.
//

import Foundation

protocol ActionSheetDelegate: AnyObject {
    func didClickFirstItem(id: Int)
    func didClickSecondItem(id: Int)
}
