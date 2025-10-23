//
//  ComentaryModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 26/09/25.
//

import Foundation

struct ComentaryModel: Codable {
    let id: Int
    let user: UserModel
    let content: String
    let createdAt: Date
    
    let likes: Int
    let comments: [ComentaryModel]
}

struct UserC: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let profilePicURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case profilePicURL = "profile_pic_url"
    }
}

struct CommentDTO: Codable, Identifiable {
    let id: Int
    let content: String
    let userID: Int
    let reportID: Int
    let parentCommentID: Int?
    let creationDate: String
    let deletedAt: String?
    let likes: Int
    let user: UserC

    enum CodingKeys: String, CodingKey {
        case id
        case content
        case userID = "user_id"
        case reportID = "report_id"
        case parentCommentID = "parent_comment_id"
        case creationDate = "creation_date"
        case deletedAt = "deleted_at"
        case likes
        case user
    }
}
