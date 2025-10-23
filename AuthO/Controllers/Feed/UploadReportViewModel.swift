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
    
    func uploadPhotoReport() async -> Bool {
        
        isLoading = true
        errorMessage = nil
        
        do {
            var reportPhotoFilename: String? = nil
            if let image = image {
                let uploadResponse = try await APIService.shared.uploadFile(image: image)
                reportPhotoFilename = uploadResponse.filename
            }
            
            if(reportPhotoFilename == nil){
                isLoading = false;
                return false;
            }
            
            print(reportPhotoFilename!)
            
            let report = uploadReportCardModel(title: title, description: description, report_pic_url: reportPhotoFilename!, category_id: category!.id, reference_url: url, status_id: 1)
            
            let uploadReportResponse = try await APIServiceFeed.shared.uploadReport(report: report)
            
            
            isLoading = false;
            if uploadReportResponse {
                print("Report uploaded successfully")
                return true;
                
            } else {
                errorMessage = "No se pudo subir el reporte"
                return false;
            }
            
            
        } catch {
            isLoading = false;
            errorMessage = error.localizedDescription
            print("Error: \(error)")
            return false;
        }
    }
    
}
