//
//  HomdFeedDelegate.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/12.
//

import Foundation


protocol FeedDelegate: AnyObject {
    func didClickEllipsisButton(id: Int)
    func didClickHeartButton(id: Int)
    func didClickFollowButtonn(id: Int)
}

extension FeedDelegate {
    func didClickEllipsisButton(id: Int) { }
    func didClickHeartButton(id: Int) { }
    func didClickFollowButtonn(id: Int) { }
}
