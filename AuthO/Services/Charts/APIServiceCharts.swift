//
//  APIServiceCharts.swift
//  AuthO
//
//  Created by Leoni Bernabe on 24/10/25.
//

import Foundation


class APIServiceCharts {
    static let shared = APIServiceCharts()
    private let baseURL = URL(string: "http://localhost:3001/")
    
    func fetchGeneralReportChart() async throws -> [DailyContributionModel] {
        guard let url = baseURL?.appendingPathComponent("/stats/reports-by-day") else {
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
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let result = try decoder.decode([DailyContributionModel].self, from: data)
        return result
    }
    
    func fetchGeneralReportChartAccepted() async throws -> [DailyContributionModel] {
        guard let url = baseURL?.appendingPathComponent("/stats/reports-by-day-accepted") else {
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
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let result = try decoder.decode([DailyContributionModel].self, from: data)
        return result
    }
    
    func fetchPieChartData() async throws -> [MostLikedPageModel] {
        guard let url = baseURL?.appendingPathComponent("/stats/top-reported-pages") else {
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
        
        let result = try JSONDecoder().decode([MostLikedPageModel].self, from: data)
        return result
    }
    
    func fetchUserBarChartData(userId: Int) async throws -> [DailyContributionModel] {
        guard var components = URLComponents(url: baseURL!.appendingPathComponent("stats/reports-by-day-user"), resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "id", value: "\(userId)")
        ]
        
        guard let url = components.url else {
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
            print("No se pudo convertir la respuesta en HTTPURLResponse.")
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            print("Error HTTP: \(httpResponse.statusCode)")
            
            print("Headers: \(httpResponse.allHeaderFields)")

            throw APIError.invalidResponse
        }
        
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let result = try decoder.decode([DailyContributionModel].self, from: data)
        return result
    }
    
    func fetchUserBarChartDataAccepted(userId: Int) async throws -> [DailyContributionModel] {
        guard var components = URLComponents(url: baseURL!.appendingPathComponent("stats/reports-by-day-user-accepted"), resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "id", value: "\(userId)")
        ]
        
        guard let url = components.url else {
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
            print("No se pudo convertir la respuesta en HTTPURLResponse.")
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            print("Error HTTP: \(httpResponse.statusCode)")
            
            print("Headers: \(httpResponse.allHeaderFields)")

            throw APIError.invalidResponse
        }
        
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let result = try decoder.decode([DailyContributionModel].self, from: data)
        return result
    }
}
