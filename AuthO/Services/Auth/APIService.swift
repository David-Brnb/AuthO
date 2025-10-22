import Foundation
import UIKit

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case unauthorized
    case custom(String)
}

class APIService {
    
    static let shared = APIService()
    private let baseURL = URL(string: "http://localhost:3001/")
    
    private init() {}
    
    // MARK: - Authentication
    
    func login(credentials: LoginCredentials) async throws -> AuthResponse {
        guard let url = baseURL?.appendingPathComponent("auth/login") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(credentials)
        } catch {
            throw APIError.decodingError(error)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == 401 {
                throw APIError.unauthorized
            } else {
                throw APIError.invalidResponse
            }
        }
        
        do {
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            KeychainService.shared.save(token: authResponse.accessToken, for: "accessToken")
            KeychainService.shared.save(token: authResponse.refreshToken, for: "refreshToken")
            return authResponse
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    func signUp(credentials: SignUpCredentials) async throws -> UserDTO {
        guard let url = baseURL?.appendingPathComponent("users") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(credentials)
            
        } catch {
            throw APIError.decodingError(error)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 401 {
                throw APIError.unauthorized
            }
            throw APIError.invalidResponse
        }
        
        do {
            let signUpResponse = try JSONDecoder().decode(UserDTO.self, from: data)
            return signUpResponse
        } catch {
            throw APIError.decodingError(error)
        }
    }

    func uploadFile(image: UIImage) async throws -> FileUploadResponse {
        guard let url = baseURL?.appendingPathComponent("file/upload") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        guard let token = KeychainService.shared.retrieve(for: "accessToken") else {
            throw APIError.unauthorized
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        // Construir el body multipart
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"photo.jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw APIError.custom("Could not convert UIImage to JPEG data.")
        }
        data.append(imageData)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = data
        
        // Llamada async con URLSession
        let (responseData, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == 401 {
                throw APIError.unauthorized
                
            } else {
                throw APIError.invalidResponse
            }
        }
        
        do {
            let fileUploadResponse = try JSONDecoder().decode(FileUploadResponse.self, from: responseData)
            return fileUploadResponse
            
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    // MARK: - Authenticated Request Example
    
    func fetchUserProfile() async throws -> UserDTO {
        guard let url = baseURL?.appendingPathComponent("auth/profile") else {
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
        
        let userProfile = try JSONDecoder().decode(UserDTO.self, from: data)
        return userProfile
    }
    
    func updateUserProfile(body: UpdateUserProfileBody) async throws -> Bool {
        guard let url = baseURL?.appendingPathComponent("users") else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = KeychainService.shared.retrieve(for: "accessToken") else {
            throw APIError.unauthorized
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(body)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse{
            if httpResponse.statusCode == 200 {
                return true
                
            } else {
                print(httpResponse.statusCode)
                return false
            }
        } else {
            return false
        }
    }
}

