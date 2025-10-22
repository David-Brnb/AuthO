
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
        
        Task { [weak self] in
            do {
                _ = try await APIService.shared.login(credentials: credentials)
                await self?.fetchUser()
                
            } catch let error as APIError {
                switch error {
                case .unauthorized:
                    await MainActor.run { self?.errorMessage = "Incorrect email or password." }
                default:
                    await MainActor.run { self?.errorMessage = "An unexpected error occurred. Please try again." }
                }
                
            } catch {
                await MainActor.run { self?.errorMessage = error.localizedDescription }
            }
            
            await MainActor.run { self?.isLoading = false }
            
        }
    }
    
    private func fetchUser() {
        isLoading = true
        
        Task { [weak self] in
            do{
                let user = try await APIService.shared.fetchUserProfile()
                
                await MainActor.run {
                    self?.isLoading = false
                    self?.sessionManager.login(user: user)
                }
                
            } catch let error as APIError {
                await MainActor.run {
                    self?.isLoading = false
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
                
            } catch {
                await MainActor.run {
                    print("Error while fetching user: \(error)")
                    self?.isLoading = false
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
