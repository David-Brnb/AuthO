
import Foundation
import Combine

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isCaptchaCompleted = false

    var sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }

    func login() {
        guard isCaptchaCompleted else {
            errorMessage = "Please complete the CAPTCHA."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        let credentials = LoginCredentials(email: email, password: password)
        
        APIService.shared.login(credentials: credentials) { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                case .success:
                    self?.fetchUser()
                case .failure(let error):
                    self?.isLoading = false
                    switch error {
                    case .unauthorized:
                        self?.errorMessage = "Incorrect email or password."
                    default:
                        self?.errorMessage = "An unexpected error occurred. Please try again."
                    }
                }
            }
        }
    }
    
    private func fetchUser() {
        APIService.shared.fetchUserProfile(){ [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    self?.sessionManager.login(user: user)
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self?.errorMessage = "The URL for the request is invalid."
                    case .unauthorized:
                        self?.errorMessage = "Unauthorized: missing or invalid token."
                    case .requestFailed(let err):
                        self?.errorMessage = "Network request failed: \(err.localizedDescription)"
                    case .invalidResponse:
                        self?.errorMessage = "The server returned an invalid response."
                    case .decodingError(let err):
                        self?.errorMessage = "Failed to decode response: \(err.localizedDescription)"
                    case .custom(let message):
                        self?.errorMessage = message
                    }
                    print("❌ Fetch user error:", error)
                }
            }
        }
    }
}
