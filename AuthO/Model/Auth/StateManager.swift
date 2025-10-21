//
//  StateManager.swift
//  AuthO
//
//  Created by Leoni Bernabe on 24/09/25.
//

import Combine
import SwiftUI


class SessionManager: ObservableObject {
    @Published var logged: Bool
    
    init(){
        // Check if a token exists in the keychain upon initialization
        logged = KeychainService.shared.retrieve(for: "accessToken") != nil
    }
    
    func login() {
        // This will be called after a successful login API call
        DispatchQueue.main.async {
            self.logged = true
        }
    }

    func logout() {
        // Clear tokens from keychain and update state
        KeychainService.shared.delete(for: "accessToken")
        KeychainService.shared.delete(for: "refreshToken")
        DispatchQueue.main.async {
            self.logged = false
        }
    }
}

