//
//  APIServiceCategory.swift
//  AuthO
//
//  Created by Leoni Bernabe on 22/10/25.
//

import Foundation

class APIServiceCategory: Codable {
    
    static let shared = APIServiceCategory()
    private let baseURL = URL(string: "http://localhost:3001/")
    
    private init() {}
    
    func fetchCategories() async throws -> [CategoryModel] {
        guard let url = baseURL?.appendingPathComponent("category") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        if let token = KeychainService.shared.retrieve(for: "accessToken") {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            throw APIError.unauthorized
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            let body = String(data: data, encoding: .utf8) ?? "No body"
            print("❌ Invalid response (\(httpResponse.statusCode)): \(body)")
            throw APIError.invalidResponse
        }
        
        let categoryData = try JSONDecoder().decode([CategoryModel].self, from: data)
        return categoryData
    }
}
