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
    
    func signUp(credentials: SignUpCredentials, completion: @escaping (Result<UserDTO, APIError>) -> Void){
        guard let url = baseURL?.appendingPathComponent("users") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(credentials)
            
        } catch {
            completion(.failure(.decodingError(error)))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let result = APIServiceGeneral.handleResponse(data: data, response: response, error: error)
            
            switch result {
            case.success(let data):
                DispatchQueue.main.async{
                    do {
                        let signUpResponse = try JSONDecoder().decode(UserDTO.self, from: data)
                        completion(.success(signUpResponse))
                        
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
                }
            case.failure(let apiError):
                DispatchQueue.main.async{
                    completion(.failure(apiError))
                }
            }
        }.resume()
        
    }

    func uploadFile(image: UIImage, completion: @escaping (Result<FileUploadResponse, APIError>) -> Void) {
        guard let url = baseURL?.appendingPathComponent("file/upload") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        if let token = KeychainService.shared.retrieve(for: "accessToken") {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            completion(.failure(.unauthorized))
            return
        }

        var data = Data()
        // Add the image data to the request body
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"photo.jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            data.append(imageData)
        }
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = data

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let fileUploadResponse = try JSONDecoder().decode(FileUploadResponse.self, from: data)
                    completion(.success(fileUploadResponse))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }.resume()
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
}

