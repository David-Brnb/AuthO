//
//  FeedViewModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 22/10/25.
//

import Foundation
import Combine
import SwiftUI

class FeedViewModel: ObservableObject {
    static let shared = FeedViewModel()
    
    @Published var reports: [ReportCardModel] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    init(){
        fetchReports()
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
                
                let reportsData = try await APIServiceFeed.shared.fetchReports()
                
                await MainActor.run {
                    self.reports = mapDTOtoModel(reportsData)
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
    
    func mapDTOtoModel(_ dtos: [ReportCardModelDTO]) -> [ReportCardModel] {
        CategoryViewModel.shared.fetchCategories()
        let categories = CategoryViewModel.shared.categories
        
        if categories.isEmpty {
            return []
        }
        
        return dtos.map { dto in
            let category = categories.first(where: { $0.id == dto.category_id })

            if category == nil {
                fatalError("Category with id: \(dto.category_id) not found")
                
            } 
            
            return ReportCardModel(
                id: dto.id,
                title: dto.title,
                description: dto.description,
                report_pic_url: dto.report_pic_url,
                category_id: dto.category_id,
                user_id: dto.user_id,
                reference_url: dto.reference_url,
                creation_date: dto.creation_date,
                status_id: dto.status_id,
                deleted_at: dto.deleted_at,
                category: category!
            )
        }
    }
    
}
