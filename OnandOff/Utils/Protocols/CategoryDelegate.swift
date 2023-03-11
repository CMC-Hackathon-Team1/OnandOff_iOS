//
//  CategoryDelegate.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/11.
//

import Foundation

protocol CategoryDelegate: AnyObject {
    func selectedCategory(_ categoryId: Int)
}
