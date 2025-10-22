//
//  CategoryViewModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 22/10/25.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    static let shared = CategoryViewModel()
    
    @Published var categories: [CategoryModel] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    private init() {
        fetchCategories()
    }
    
    func fetchCategories() {
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        isLoading = true
        error = nil
        
        Task{
            do {
                let categoryData = try await APIServiceCategory.shared.fetchCategories()
                
                await MainActor.run {
                    self.categories = categoryData
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    print("Error fetching categories: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
