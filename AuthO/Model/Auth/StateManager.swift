//
//  StateManager.swift
//  AuthO
//
//  Created by Leoni Bernabe on 24/09/25.
//

import Combine
import SwiftUI


@MainActor
class SessionManager: ObservableObject {
    @Published var logged: Bool
    @Published var currentUser: UserDTO?
    
    init(){
        // Check if a token exists in the keychain upon initialization
        logged = KeychainService.shared.retrieve(for: "accessToken") != nil
        
        if logged,
           let userData = UserDefaults.standard.data(forKey: "currentUser"),
           let user = try? JSONDecoder().decode(UserDTO.self, from: userData){
            currentUser = user
        }
    }
    
    func login(user: UserDTO) {
        self.currentUser = user
        self.logged = true
        
        print("Logged in as: \(user)")
        
        if let encoded = try? JSONEncoder().encode(user){
            UserDefaults.standard.set(encoded, forKey: "currentUser")
        }
    }

    func logout() {
        // Clear tokens from keychain and update state
        KeychainService.shared.delete(for: "accessToken")
        KeychainService.shared.delete(for: "refreshToken")
        
        self.logged = false
        self.currentUser = nil
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
}

