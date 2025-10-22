
import Foundation
import SwiftUI
import Combine
import PhotosUI

@MainActor
class UploadProfilePhotoViewModel: ObservableObject {
    @Published var photoPickerItem: PhotosPickerItem?
    @Published var image: UIImage?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isCaptchaCompleted = false
    
    private var cancellables = Set<AnyCancellable>()
    
    var sessionManager: SessionManager
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
        $photoPickerItem
            .compactMap { $0 }
            .flatMap { item in
                Future<Data?, Never> { promise in
                    Task {
                        let data = try? await item.loadTransferable(type: Data.self)
                        promise(.success(data))
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                if let data = data, let uiImage = UIImage(data: data) {
                    self?.image = uiImage
                }
            }
            .store(in: &cancellables)
    }
    
    func registerAndUpload(credentials: SignUpCredentials) async {
        guard isCaptchaCompleted else {
            errorMessage = "Please complete the CAPTCHA."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await APIService.shared.signUp(credentials: credentials)
            
            let loginCredentials = LoginCredentials(email: credentials.email, password: credentials.password)
            let authResponse = try await APIService.shared.login(credentials: loginCredentials)
            
            var profilePhotoFilename: String? = nil
            if let image = image {
                let uploadResponse = try await APIService.shared.uploadFile(image: image)
                profilePhotoFilename = uploadResponse.filename
            }
            
            // hasta aqui todo funciona muy bien
            
            let updateUser = try await APIService.shared.updateUserProfile(body: UpdateUserProfileBody(id:user.id, profile_pic_url: profilePhotoFilename))
            
            if updateUser {
                sessionManager.login(user: user)
            } else {
                sessionManager.logout()
            }
        } catch {
            errorMessage = error.localizedDescription
            print("Error: \(error)")
        }
        
        
        isLoading = false
    }
}
