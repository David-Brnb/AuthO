//
//  UserModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 26/09/25.
//

import Foundation

struct UserModel: Codable, Identifiable{
    let id: String
    let name: String
    let email: String
    let creationDate: Date
    let profileImageUrl: String
    let updateDate: Date
}

struct UserDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let admin: Int
}
