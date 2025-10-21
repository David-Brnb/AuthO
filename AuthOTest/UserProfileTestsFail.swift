//
//  UserProfileTestsFail.swift
//  AuthO
//
//  Created by Eduardo Mora on 16/10/25.
//

import Testing
import Foundation
@testable import AuthO
struct UserProfileTestsFail {
    @Test func invalidUserProfileWithEmptyEmail() throws {
        let invalidUser = UserModel(
            id: "u_invalid_1",
            name: "Invalid User",
            email: "",
            creationDate: Date(),
            profileImageUrl: "https://example.com/image.jpg",
            updateDate: Date()
        )
        let emailIsValid = invalidUser.email.isValidEmail()
        try? #require(!emailIsValid, "User email should not be valid when empty")
        try? #require(!invalidUser.email.isEmpty == false, "User email must not be empty")
    }
    @Test func invalidUserProfileWithMalformedEmail() throws {
        let invalidUser = UserModel(
            id: "u_invalid_2",
            name: "John Doe",
            email: "notanemail",
            creationDate: Date(),
            profileImageUrl: "https://example.com/image.jpg",
            updateDate: Date()
        )
        let emailIsValid = invalidUser.email.isValidEmail()
        try? #require(!emailIsValid, "Email 'notanemail' should not be valid format")
    }
    @Test func invalidUserProfileWithInvalidImageUrl() throws {
        let invalidUser = UserModel(
            id: "u_invalid_3",
            name: "Jane Smith",
            email: "jane.smith@example.com",
            creationDate: Date(),
            profileImageUrl: "not a valid url",
            updateDate: Date()
        )
        let profileImageIsValid = URL(string: invalidUser.profileImageUrl) != nil
        try? #require(!profileImageIsValid, "Profile image URL 'not a valid url' should not be a valid URL")
    }
    @Test func invalidUserProfileWithEmptyName() throws {
        let invalidUser = UserModel(
            id: "u_invalid_4",
            name: "",
            email: "user@example.com",
            creationDate: Date(),
            profileImageUrl: "https://example.com/image.jpg",
            updateDate: Date()
        )
        try? #require(invalidUser.name.isEmpty, "User name should be empty")
        try? #require(invalidUser.name.count == 0, "User name should have zero characters")
    }
    @Test func invalidUserProfileWithEmptyId() throws {
        let invalidUser = UserModel(
            id: "",
            name: "Invalid User",
            email: "user@example.com",
            creationDate: Date(),
            profileImageUrl: "https://example.com/image.jpg",
            updateDate: Date()
        )
        try? #require(invalidUser.id.isEmpty, "User ID should be empty")
    }
    @Test func invalidUserProfileWithFutureDateCreation() throws {
        let futureDate = Date(timeIntervalSinceNow: 86400 * 10) 
        let invalidUser = UserModel(
            id: "u_invalid_5",
            name: "Future User",
            email: "future@example.com",
            creationDate: futureDate,
            profileImageUrl: "https://example.com/image.jpg",
            updateDate: Date()
        )
        try? #require(invalidUser.creationDate > Date(), "Creation date should not be in the future")
        try? #require(invalidUser.creationDate > invalidUser.updateDate, "Creation date should not be after update date")
    }
    @Test func invalidUserProfileWithEmptyProfileImageUrl() throws {
        let invalidUser = UserModel(
            id: "u_invalid_6",
            name: "No Image User",
            email: "noimage@example.com",
            creationDate: Date(),
            profileImageUrl: "",
            updateDate: Date()
        )
        try? #require(invalidUser.profileImageUrl.isEmpty, "Profile image URL should be empty")
        let profileImageIsValid = URL(string: invalidUser.profileImageUrl) != nil
        try? #require(!profileImageIsValid, "Empty profile image URL should not be a valid URL")
    }
    @Test func invalidUserProfileWithInvalidEmailFormat() throws {
        let invalidEmails = [
            "user@",
            "@example.com",
            "user@.com",
            "user..name@example.com",
            "user @example.com",
            "user@example",
            "user.example.com"
        ]
        for email in invalidEmails {
            let invalidUser = UserModel(
                id: "u_invalid_email",
                name: "Test User",
                email: email,
                creationDate: Date(),
                profileImageUrl: "https://example.com/image.jpg",
                updateDate: Date()
            )
            let emailIsValid = invalidUser.email.isValidEmail()
            try? #require(!emailIsValid, "Email '\(email)' should not be valid format")
        }
    }
}
