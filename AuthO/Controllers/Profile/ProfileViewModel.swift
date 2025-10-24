//
//  ProfileViewModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/10/25.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var reports: [ReportCardModel] = []
    @Published var stats: ReportStats = ReportStats(totalReports: 0, acceptedReports: 0, rejectedReports: 0)
    
    @Published var isLoading: Bool = false
    @Published var error: String?
    var userId: Int
    
    init(userId: Int){
        self.userId = userId
        fetchData()
    }
    
    func updateUserId(id: Int){
        self.userId = id
    }
    
    func fetchData() {
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        isLoading = true
        error = nil
        
        Task{
            do {
                
                let reportsData = try await APIServiceProfile.shared.fetchUserReports(id: userId)
                
                await MainActor.run {
                    self.reports = FeedViewModel.shared.mapDTOtoModel(reportsData)
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    print("Error fetching reports: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func fetchReports() {
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        isLoading = true
        error = nil
        
        Task{
            do {
                
                let reportStats = try await APIServiceProfile.shared.fetchUserStats(id: userId)
                
                await MainActor.run {
                    self.stats = reportStats
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    print("Error fetching reports: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
