//
//  NotificationName+.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/18.
//

import UIKit

extension Notification.Name {
    static let dismissStandardAlert = Notification.Name("dismissStandardAlert")
    static let selectCategory = Notification.Name("selectCategory")
    static let presentReportVC = Notification.Name("presentReportVC")
    static let presentLoginVC = Notification.Name("presentLoginVC")
    static let changeProfileId = Notification.Name("changeProfileId")
    static let getProfileId = Notification.Name("getProfileId")
    static let clcikDay = Notification.Name("clickDay")
    static let clickFollow = Notification.Name("clickFollow")
    static let changeCurrentPage = Notification.Name("changeCurrentPage")
    static let changeFeed = Notification.Name("changeFeed")
}
