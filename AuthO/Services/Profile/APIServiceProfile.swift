//
//  APIServiceProfile.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/10/25.
//

import Foundation

class APIServiceProfile {
    static var shared: APIServiceProfile = .init()
    private let baseURL = URL(string: "http://localhost:3001/")
    
    func fetchUserReports(id: Int) async throws -> [ReportCardModelDTO] {
        guard let url = baseURL?.appendingPathComponent("reports/user/\(id)") else {
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
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        let reportData = try JSONDecoder().decode([ReportCardModelDTO].self, from: data)
        return reportData
    }
    
    
}
