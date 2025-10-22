
import Foundation
import SwiftUI
import Combine
import PhotosUI

class UploadProfilePhotoViewModel: ObservableObject {
    @Published var photoPickerItem: PhotosPickerItem?
    @Published var image: UIImage?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isCaptchaCompleted = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
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
    
    func registerUser(credentials: SignUpCredentials, completion: @escaping(Result<UserDTO, APIError>)->Void){
        APIService.shared.signUp(credentials: credentials) { result in
            switch result {
            case .success(let user):
                completion(.success(user))
            case.failure(let error):
                print("Error while signing up: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func uploadProfilePhoto(completion: @escaping (Result<String, APIError>) -> Void) {
        guard let image = image else {
            completion(.failure(.custom("No image selected")))
            return
        }
        
        isLoading = true
        
        APIService.shared.uploadFile(image: image) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    completion(.success(response.path))
                case .failure(let error):
                    self?.errorMessage = "Failed to upload image."
                    completion(.failure(error))
                }
            }
        }
    }
    
    func registerAndUpload(credentials: SignUpCredentials){
        guard isCaptchaCompleted else {
            errorMessage = "Please complete the CAPTCHA."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
//        do {
//            let user = try await APIService.shared.signUp(credentials: credentials)
//        } catch {
//            isLoading = false
//            errorMessage = error.localizedDescription
//            print("Error: \(error)")
//        }
//        
        self.registerUser(credentials: credentials) { [weak self] result in
            switch result {
            case .success(let user):
                self?.isLoading = false
                
                print("User signed up: \(user)")
                // deberia de aplicar aqui la funcion de login en un tipo guard let mejor
                
                self?.uploadProfilePhoto(){ [weak self] result in
                    switch result {
                    case .success(let path):
                        print(path)
                    case .failure(let error):
                        print(error)
                    }
                }
            case .failure(let error):
                print(error)
                self?.isLoading = false
            }
        }
    }
}
