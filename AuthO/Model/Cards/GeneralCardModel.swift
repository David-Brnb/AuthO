//
//  GeneralCardModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 24/09/25.
//

import Foundation

struct CardModel: Codable, Identifiable {
    let id: Int
    let titulo: String
    let descripcion: String
    let url: String
    let imageUrl: String
    
    let user: UserModel
    let categoria: CategoryModel
    let creationDate: Date
    let status: String
    
    let likes: Int
    let comments: [ComentaryModel]
}

struct ReportCardModelDTO: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let report_pic_url: String
    let category_id: Int
    let user_id: Int
    let reference_url: String
    let creation_date: String
    let status_id: Int
    let deleted_at: String?
}

struct ReportCardModel: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let report_pic_url: String
    let category_id: Int
    let user_id: Int
    let reference_url: String
    let creation_date: String
    let status_id: Int
    let deleted_at: String?
    let category: CategoryModel
}

struct uploadReportCardModel: Codable {
    let title: String
    let description: String
    let report_pic_url: String
    let category_id: Int
    let reference_url: String
    let status_id: Int
}
