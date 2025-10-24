//
//  UserDailyLikesModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import Foundation

struct UserDailyLikesModel: Codable, Identifiable {
    var id = UUID()
    let day: Date
    let like_count: Int
    
    enum CodingKeys: String, CodingKey {
        case day = "date"
        case like_count = "likes_count"
    }
}
