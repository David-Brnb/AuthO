
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
}
