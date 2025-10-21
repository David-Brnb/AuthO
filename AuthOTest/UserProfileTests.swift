//
//  UserProfileTests.swift
//  AuthO
//
//  Created by Eduardo Mora on 16/10/25.
//

import Testing
import Foundation
@testable import AuthO

struct UserProfileTests {
    @Test func successfulUserProfileLoad() throws {
        let user = ExampleUsers.ana
        try? #expect(!user.id.isEmpty, "User ID should not be empty")
        try? #expect(!user.name.isEmpty, "User name should not be empty")
        try? #expect(!user.email.isEmpty, "User email should not be empty")
        try? #expect(user.creationDate != nil, "User creation date should exist")
        try? #expect(!user.profileImageUrl.isEmpty, "User profile image URL should not be empty")
        try? #expect(user.updateDate != nil, "User update date should exist")
        let emailIsValid = user.email.isValidEmail()
        try? #expect(emailIsValid, "User email should have a valid format")
        let profileImageIsValid = URL(string: user.profileImageUrl) != nil
        try? #expect(profileImageIsValid, "User profile image URL should be a valid URL")
        try? #expect(user.creationDate <= user.updateDate, "Creation date should be before or equal to update date")
        try? #expect(user.id == "u1", "User ID should match expected value")
        try? #expect(user.name == "Ana López", "User name should be Ana López")
        try? #expect(user.email == "ana.lopez@example.com", "User email should be ana.lopez@example.com")
    }
    @Test func multipleUsersProfileLoad() throws {
        let users = ExampleUsers.all

        try? #expect(users.count == 4, "Should have 4 example users")
        for user in users {
            try? #expect(!user.id.isEmpty, "Each user ID should not be empty")
            try? #expect(!user.name.isEmpty, "Each user name should not be empty")
            try? #expect(!user.email.isEmpty, "Each user email should not be empty")
            let emailIsValid = user.email.isValidEmail()
            try? #expect(emailIsValid, "Each user email should have a valid format")
            let profileImageIsValid = URL(string: user.profileImageUrl) != nil
            try? #expect(profileImageIsValid, "Each user profile image URL should be valid")
        }
    }
    @Test func userProfileDataIntegrity() throws {
        let originalUser = ExampleUsers.carlos
        let copiedUser = UserModel(
            id: originalUser.id,
            name: originalUser.name,
            email: originalUser.email,
            creationDate: originalUser.creationDate,
            profileImageUrl: originalUser.profileImageUrl,
            updateDate: originalUser.updateDate
        )
        try? #expect(originalUser.id == copiedUser.id, "User ID should remain consistent")
        try? #expect(originalUser.name == copiedUser.name, "User name should remain consistent")
        try? #expect(originalUser.email == copiedUser.email, "User email should remain consistent")
        try? #expect(originalUser.profileImageUrl == copiedUser.profileImageUrl, "User profile image URL should remain consistent")
    }
}
