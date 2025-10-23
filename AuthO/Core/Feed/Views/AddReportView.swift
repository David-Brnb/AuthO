//
//  AddReportView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 24/09/25.
//

import SwiftUI
import PhotosUI

struct AddReportView: View {
    @Binding var showAddReport: Bool
    
    @StateObject private var viewModel: UploadReportViewModel
    
    init(showAddReport: Binding<Bool>) {
        self._showAddReport = showAddReport
        
        _viewModel = StateObject(wrappedValue: UploadReportViewModel())
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section("Titulo"){
                    TextField("Titulo", text: $viewModel.title)
                }
                
                Section("URL"){
                    TextField("URL", text: $viewModel.url)
                }
                
                Section("Imágen"){
                    PhotosPicker(selection: $viewModel.photoPickerItem, matching: .images){
                        HStack{
                            Spacer()
                            if let reportImage = viewModel.image {
                                Image(uiImage: reportImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .foregroundStyle(.gray)
                            } else {
                                Image(systemName: "photo.badge.plus")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                        }
                    }
                    
                }
                .listRowBackground(Color.clear)
                
                Section("Descripción"){
                    CustomTextEditor(placeholder: "Descripción", maxCharacters: 150, text: $viewModel.description)
                        .frame(height: 150)
                        
                }
                
                Section("Categoría"){
                    HStack{
                        Text("Categoria")
                        Spacer()
                        
                        CategoryMenuView(selectedCategory: $viewModel.category)
                    }
                }
                
                Button{
                    if validateFields() {
                        
                        Task {
                            let res = await viewModel.uploadPhotoReport()
                            
                            if res {
                                showAddReport = false;
                            }
                            FeedViewModel.shared.fetchReports()
                        }
                        
                    } else {
                        viewModel.errorMessage = "Por favor completa todos los campos"
                    }
                } label : {
                    HStack{
                        Spacer()
                        Text("Publicar")
                        Spacer()
                    }
                }
                .disabled(viewModel.isLoading)
            }
            .navigationTitle("Registrar Nuevo Reporte")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")) {
                    viewModel.errorMessage = nil
                })
            }
        }
    }
}

#Preview {
    AddReportView(showAddReport: .constant(true))
}

extension AddReportView {
    func shouldDisable(_ text: String) -> Bool {
        let words = text.split { $0.isWhitespace || $0.isNewline }
        return words.count >= 5 // for example, disable if >= 50 words
    }
    
    func validateFields() -> Bool {
        return !viewModel.title.isEmpty && !viewModel.url.isEmpty && !viewModel.description.isEmpty && viewModel.image != nil && viewModel.category != nil
    }
}
