//
//  LookAroundDelegate.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/16.
//

import Foundation

protocol LookAroundDelegate: AnyObject {
    func didClickEllipsis()
    func didClickHeart(_ feedId: Int)
    func didClickFollow(_ toProfileId: Int)
    func didClickReportButton()
}
