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
        // guardamos el id del usuario en keychain por seguridad
        KeychainService.shared.save(id: user.id, for: "user_id")
        
        // borramos le id y el email del user porque son datos sensibles y que no están seguros si se mantienen
        var safeUser = user
        safeUser.id = -1
        safeUser.email = ""
        
        self.currentUser = safeUser
        self.logged = true
        
        print("Logged in as: \(safeUser)")
        
        if let encoded = try? JSONEncoder().encode(safeUser){
            UserDefaults.standard.set(encoded, forKey: "currentUser")
        }
    }

    func logout() {
        // Clear tokens from keychain and update state
        KeychainService.shared.delete(for: "accessToken")
        KeychainService.shared.delete(for: "refreshToken")
        KeychainService.shared.delete(for: "user_id")
        
        self.logged = false
        self.currentUser = nil
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
}

