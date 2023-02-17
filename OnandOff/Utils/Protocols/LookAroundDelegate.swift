//
//  LookAroundDelegate.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/16.
//

import Foundation

protocol LookAroundDelegate: AnyObject {
    func didClickEllipsis()
    func didClickHeart()
    func didClickFollow()
    func didClickReportButton()
}
