//
//  ReportViewDelegate.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/16.
//

import Foundation

protocol ReportViewDelegate: AnyObject {
    func presentReportViewController(_ feedId: Int)
}
