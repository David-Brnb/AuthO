//
//  UploadReportViewModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/10/25.
//

import Foundation
import SwiftUI
import Combine
import PhotosUI

class UploadReportViewModel:  ObservableObject {
    @Published var title: String = ""
    @Published var url: String = ""
    @Published var imageURL: String = ""
    @Published var description: String = ""
    @Published var category: CategoryModel?
    @Published var photoPickerItem: PhotosPickerItem?
    @Published var image: UIImage?
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
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
    
    func uploadPhoto() async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            var profilePhotoFilename: String? = nil
            if let image = image {
                let uploadResponse = try await APIService.shared.uploadFile(image: image)
                profilePhotoFilename = uploadResponse.filename
            }
            
            if(profilePhotoFilename == nil){
                throw APIError.custom("No se pudo subir la foto")
            }
            
            print(profilePhotoFilename!)
            
        } catch {
            errorMessage = error.localizedDescription
            print("Error: \(error)")
        }
    }
}
