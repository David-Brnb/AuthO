//
//  DailyContributionModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import Foundation

struct DailyContributionModel: Codable, Identifiable {
    var id = UUID()
    let day: Date
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case day = "date"
        case count
    }
}
