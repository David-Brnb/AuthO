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
    
    func fetchCommentComments(comment_id: Int) async throws -> [CommentDTO] {
        guard let url = baseURL?.appendingPathComponent("comment/\(comment_id)/children") else {
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
    
    func uploadComment(comment: commentResponse) async throws -> Bool {
        guard let url = baseURL?.appendingPathComponent("comment") else {
            return false;
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = KeychainService.shared.retrieve(for: "accessToken") {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            return false;
        }
        
        request.httpBody = try? JSONEncoder().encode(comment)
        
        print(request)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("No se pudo convertir la respuesta en HTTPURLResponse.")
            return false
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            print("❌ Error HTTP: \(httpResponse.statusCode)")

            // Mostrar headers (útil para debug)
            print("📬 Headers: \(httpResponse.allHeaderFields)")

            return false
        }
        
        return true;
    }
    
    func uploadReport(report: uploadReportCardModel) async throws -> Bool {
        guard let url = baseURL?.appendingPathComponent("reports") else {
            return false;
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = KeychainService.shared.retrieve(for: "accessToken") {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            return false;
        }
        
        request.httpBody = try? JSONEncoder().encode(report)
        
        print(request)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("No se pudo convertir la respuesta en HTTPURLResponse.")
            return false
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            print("❌ Error HTTP: \(httpResponse.statusCode)")

            // Mostrar headers (útil para debug)
            print("📬 Headers: \(httpResponse.allHeaderFields)")

            return false
        }
        
        return true;
        
    }
}
