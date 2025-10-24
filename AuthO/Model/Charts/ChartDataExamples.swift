//
//  ChartDataExamples.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import Foundation

struct ChartDataExamples {
    // General Users Contribution Data
    static let usersContribution: [DailyContributionModel] = {
        let today = Date()
        let calendar = Calendar.current
        
        return (0...6).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: -offset, to: today) {
                let randomCount = Int.random(in: 1...10)
                return DailyContributionModel(day: date, count: randomCount)
            }
            return nil
        }.reversed()
    }()
    
    // Liked reports data
    static let likedReports: [MostLikedPageModel] = (1...10).map { i in
        MostLikedPageModel(
            title: "Page \(i)",
            likes: Int.random(in: 10...100)
        )
    }
    
    static let mostLikedReport = likedReports.max(by: { $0.likes < $1.likes })

    private static let totalLikes = likedReports.reduce(0) { $0 + $1.likes }
    
    static let mostLikedPercentaje = Double(mostLikedReport!.likes) / Double(totalLikes) * 10
    
    
    // User daily contribution data
    static let userContribution: [UserDailyContributionModel] = {
        let today = Date()
        let calendar = Calendar.current
        
        return (0...6).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: -offset, to: today) {
                let randomContributions = Int.random(in: 1...10)
                return UserDailyContributionModel(day: date, contributions: randomContributions)
            }
            return nil
        }.reversed()
    }()
    
    static let mostContributedDay = userContribution.max(by: { $0.contributions < $1.contributions })!
    
    
    // Daily likes data
    static let userDailyLikes: [UserDailyLikesModel] = {
        let today = Date()
        let calendar = Calendar.current
        
        return (0...6).compactMap { offset in
            if let date = calendar.date(byAdding: .day, value: -offset, to: today) {
                let randomLikes = Int.random(in: 1...10)
                return UserDailyLikesModel(day: date, like_count: randomLikes)
            }
            return nil
        }.reversed() // para que vaya de más antiguo a más reciente
    }()
    
    static let totalLikesReports = userDailyLikes.reduce(0) { $0 + $1.like_count }
        
}
