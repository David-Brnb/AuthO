//
//  UploadProfilePhotoView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 09/10/25.
//

import SwiftUI
import PhotosUI

struct UploadProfilePhotoView: View {
    @StateObject private var viewModel = UploadProfilePhotoViewModel()
    @State private var openCatpcha: Bool = false
    
    @EnvironmentObject var sesion: SessionManager
    
    var body: some View {
        VStack{
            header
            
            PhotosPicker(selection: $viewModel.photoPickerItem, matching: .images) {
                if let profileImage = viewModel.image {
                    Image(uiImage: profileImage)
                        .resizable()
                        .modifier(ProfileImageModifier())
                    
                } else {
                    Image("add_photo")
                        .resizable()
                        .renderingMode(.template)
                        .modifier(ProfileImageModifier())
                }
            }
            .frame(height: 350)
            
            Button {
                openCatpcha=true
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Continue")
                }
            }
            .font(.headline)
            .foregroundStyle(.white)
            .frame(width: 300, height: 50)
            .background((viewModel.image==nil) ? Color(.systemGray4) : Color(.systemOrange))
            .clipShape(Capsule())
            .padding()
            .shadow(color: .gray.opacity(0.5), radius: 10, x:0, y:0)
            .disabled(viewModel.image==nil || viewModel.isLoading)
            
            Spacer()
        }
        .sheet(isPresented: $openCatpcha){
            CaptchaView() {
                viewModel.uploadProfilePhoto { result in
                    switch result {
                    case .success:
                        print("yes")
//                        sesion.login()
                    case .failure:
                        // Optionally handle the error, e.g., show an alert
                        break
                    }
                }
            }
        }
        .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")) {
                viewModel.errorMessage = nil
            })
        }
        .ignoresSafeArea(edges: .all)
    }
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(
                LinearGradient(
                    colors: [Color(.systemYellow), Color(.systemOrange)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 250, height: 250)
            .clipShape(Circle())
    }
}


#Preview {
    UploadProfilePhotoView()
//        .environment(SessionManager(), .init())
}

extension UploadProfilePhotoView {
    var header: some View {
        VStack(alignment: .leading) {
            Text("Selecciona una ")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("foto de perfil! ")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            HStack{
                Spacer()
            }
            
        }
        .frame(height: 260)
        .padding(.leading)
        .background(
            LinearGradient(
                colors: [Color(.systemOrange), Color(.systemYellow)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .foregroundStyle(.white)
        .clipShape(RoundedShape(corners: [.bottomRight], cornerRadius: 80))
    }
}
