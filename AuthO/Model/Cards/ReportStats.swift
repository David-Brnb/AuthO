//
//  ReportStats.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/10/25.
//

import Foundation

struct ReportStats: Codable {
    let totalReports: Int
    let acceptedReports: Int
    let rejectedReports: Int
}
