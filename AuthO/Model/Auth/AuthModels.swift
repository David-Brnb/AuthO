
import Foundation

struct LoginCredentials: Codable {
    let email: String
    let password: String
}

struct SignUpCredentials: Codable {
    let name: String
    let email: String
    let password: String
}

struct UpdateUserProfileBody: Codable {
    let id: Int
    var name: String? = nil
    var email: String? = nil
    var password: String? = nil
    var profile_pic_url: String? = nil
}

struct AuthResponse: Codable {
    let accessToken: String
    let refreshToken: String
}

struct RefreshTokenInput: Codable {
    let refreshToken: String
}
