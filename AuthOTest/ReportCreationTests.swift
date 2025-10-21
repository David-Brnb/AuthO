//
//  ReportCreationTests.swift
//  AuthO
//
//  Created by Usuario on 14/10/25.
//
import Testing
import Foundation
@testable import AuthO
struct ReportCreationTests {
        @Test func successfulFraudReportCreation() throws {
        let reportingUser = UserModel(
            id: "101",
            name: "PedroPerez",
            email: "pedroPerez@example.com",
            creationDate: Date(),
            profileImageUrl: "",
            updateDate: Date()
        )
        let fraudCategory = CategoryModel(
            id: 1,
            name: "Hogar",
            icon: "house",
            description: "Articulos y servicios para el hogar"
        )
        let fraudReport = CardModel(
            id: 201,
            titulo: "Hogar Limpio",
            descripcion: """
            La página 'Hogar Limpio' (www.HogarLimpio.com) anuncia una licuadora multifuncional con varias velocidades y vaso de vidrio resistente.
            Sin embargo, el producto recibido es solo una licuadora de plástico pequeña y frágil, muy diferente a lo mostrado en la web.
            """,
            url: "http://www.HogarLimpio.com",
            imageUrl: "https://ejemplo.com/imagen_licuadora_mostrada.jpg",
            user: reportingUser,
            categoria: fraudCategory,
            creationDate: Date(),
            status: "pending_review",
            likes: 0,
            comments: []
        )
        let isValidTitle = !fraudReport.titulo.isEmpty && fraudReport.titulo.count >= 3
        let isValidDescription = !fraudReport.descripcion.isEmpty && fraudReport.descripcion.count >= 10
        let isValidCategory = fraudReport.categoria != nil
        let isValidEmail = reportingUser.email.isValidEmail()
        let isValidUrl = URL(string: fraudReport.url) != nil        
        try? #require(isValidTitle, "The report must have a valid title.")
        try? #require(isValidDescription, "The report must have a detailed description of the fraud (minimum 10 characters).")
        try? #require(isValidCategory, "The report must have a complaint or fraud category.")
        try? #require(fraudReport.id > 0, "The report must have a valid ID.")
        try? #require(fraudReport.user != nil, "The report must have an associated user.")
        try? #require(isValidEmail, "The reporting user must have a valid email format.")
        try? #require(isValidUrl, "The report must include a valid URL of the fraud source (HogarLimpio.com).")
        try? #expect(URL(string: fraudReport.imageUrl) != nil, "It is recommended that the report includes a valid image URL for evidence.")
        try? #require(fraudReport.creationDate != nil, "The report must have a creation date.")
        try? #expect(fraudReport.likes == 0, "A new complaint report must start with 0 likes.")
        try? #expect(fraudReport.comments.isEmpty, "A new complaint report must start with no comments.")
        try? #expect(fraudReport.status == "pending_review", "The new complaint report must have a 'pending_review' status.")
    }
}
