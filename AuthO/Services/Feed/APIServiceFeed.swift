//
//  APIServiceFeed.swift
//  AuthO
//
//  Created by Leoni Bernabe on 22/10/25.
//

import Foundation

class APIServiceFeed {
    static let shared = APIServiceFeed()
    private let baseURL = URL(string: "http://localhost:3001/")
    
    func fetchReports() async throws -> [ReportCardModelDTO] {
        guard let url = baseURL?.appendingPathComponent("reports") else {
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
    
    func fetchReportComments(report_id: Int) async throws -> [CommentDTO] {
        guard let url = baseURL?.appendingPathComponent("comment/report/\(report_id)/root") else {
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
        
        let commentData = try JSONDecoder().decode([CommentDTO].self, from: data)
        return commentData
        
        
    }
}
