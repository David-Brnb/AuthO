//
//  ChartsViewModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 24/10/25.
//

import Foundation
import Combine

class ChartsViewModel: ObservableObject {
    static let shared = ChartsViewModel()
    
    @Published var generalBarChartData: [DailyContributionModel] = []
    @Published var pieChartData: [MostLikedPageModel] = []
    @Published var userBarChartData: [DailyContributionModel] = []
    @Published var userDailyLikes: [UserDailyLikesModel] = []
    
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    private init(){
        fetchBarChartData()
        fetchPieChartData()
    }
    
    func fetchBarChartData() {
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                let data = try await APIServiceCharts.shared.fetchGeneralReportChart()
                
                await MainActor.run {
                    self.generalBarChartData = data
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    print("Error fetching general chart data: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchBarChartDataAccepted() {
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                let data = try await APIServiceCharts.shared.fetchGeneralReportChartAccepted()
                
                await MainActor.run {
                    self.generalBarChartData = data
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    print("Error fetching general chart data: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchPieChartData() {
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                let data = try await APIServiceCharts.shared.fetchPieChartData()
                
                var domainMap: [String: Int] = [:]
                
                for item in data {
                    domainMap[item.title, default: 0] += item.likes
                }
                
                let aggregatedData = domainMap.map { MostLikedPageModel(title: $0.key, likes: $0.value) }
                
                await MainActor.run {
                    self.pieChartData = aggregatedData
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    print("Error fetching pie chart data: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchUserBarChartData(userId: Int) {
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                let data = try await APIServiceCharts.shared.fetchUserBarChartData(userId: userId)
                
                await MainActor.run {
                    self.userBarChartData = data
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    print("Error fetching user chart data: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchUserBarChartDataAccepted(userId: Int) {
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        isLoading = true
        error = nil
        
        Task {
            do {
                let data = try await APIServiceCharts.shared.fetchUserBarChartDataAccepted(userId: userId)
                
                await MainActor.run {
                    self.userBarChartData = data
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    print("Error fetching user chart data: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func averageWeeklyContributions() -> Int {
        let data = generalBarChartData
        guard !data.isEmpty else { return 0 }
        
        let total = data.reduce(0) { $0 + $1.count }
        
        return Int(floor(Double(total) / 7.0))
    }
    
    func mostReportedPage() -> String {
        if pieChartData.max(by: { $0.likes < $1.likes }) != nil {
            return pieChartData.max(by: { $0.likes < $1.likes })!.title
        } else {
            return "No data"
        }
    }
    
    func mostReportedPagePercentage() -> Double {
        if pieChartData.isEmpty { return 0 }
        
        let maxLikes = pieChartData.max(by: { $0.likes < $1.likes })!.likes
        
        return (Double(maxLikes) / Double(pieChartData.reduce(0) { $0 + $1.likes })) * 100
    }
    
    func mostContributedDay() -> DailyContributionModel {
        if userBarChartData.isEmpty {
            return DailyContributionModel(day: Date(), count: 0)
        } else {
            return userBarChartData.max(by: { $0.count < $1.count })!
        }
    }
    
}

    
