//
//  APIServiceGeneral.swift
//  AuthO
//
//  Created by Leoni Bernabe on 22/10/25.
//

import Foundation

class APIServiceGeneral {
    private init() {}
    
    static func handleResponse(data: Data?, response: URLResponse?, error: Error?) -> Result<Data, APIError> {
        if let error = error {
            return .failure(.requestFailed(error))
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(.invalidResponse)
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            if httpResponse.statusCode == 401 {
                return .failure(.unauthorized)
            } else {
                return .failure(.invalidResponse)
            }
        }
        
        guard let data = data else {
            return .failure(.invalidResponse)
        }
        
        return .success(data)
    }
}
