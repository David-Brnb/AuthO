
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
                self?.isLoading = false
                switch result {
                case .success:
                    self?.sessionManager.login()
                case .failure(let error):
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
}
