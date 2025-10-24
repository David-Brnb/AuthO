//
//  ProfileView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @EnvironmentObject var sesion: SessionManager
    @State private var navigateToFAQs = false
    @State private var navigateToCategories = false
    
    @StateObject private var viewModel: ProfileViewModel
    
    init(){
        _viewModel = .init(wrappedValue: ProfileViewModel(userId: 0))
    }
    
    
    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView {
                    Divider()
                    .padding(.top, 170)
                
                    headerView
                    
                    VStack(alignment: .leading){
                        
                        Text("Reportes")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                        
                
                        ForEach(viewModel.reports, id: \.id) { card in
                            ReportCard(report: card)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        }
                        
                        Spacer()
                            .frame(height: 90)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                }
                .scrollIndicators(.hidden)
                .refreshable {
                    viewModel.fetchData()
                }
                    
            }
            .navigationTitle("O-Fraud")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading){
                    Menu {
                        Button {
                            navigateToFAQs = true
                        } label: {
                            Text("FAQs")
                        }

                        Divider()

                        Button {
                            navigateToCategories = true
                        } label: {
                            Text("Categorías")
                        }
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .foregroundStyle(.blue)
                    }
                    .foregroundColor(.blue)
                    
                }
                
                ToolbarItem(placement: .topBarLeading){
                    NavigationLink {
                        AvisoPrivacidadView()
                        
                    } label: {
                        
                        Image(systemName: "exclamationmark.shield")
                            .foregroundStyle(.blue)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sesion.logout()
                        
                    } label: {
                        Image(systemName: "door.right.hand.open")
                    }
                    .tint(.red)
                }
            }
            .navigationDestination(isPresented: $navigateToCategories) {
                CategoriesView()
            }
            .navigationDestination(isPresented: $navigateToFAQs) {
                FAQsView()
            }
            .ignoresSafeArea()
            .onAppear(){
                _ = FeedViewModel.shared
                viewModel.updateUserId(id: sesion.currentUser!.id)
                viewModel.fetchData()
            }
        }
        
    }
}

#Preview {
    ProfileView()
}

extension ProfileView {
    var headerView: some View {
        Group{
            if let profilePicPath = sesion.currentUser?.profile_pic_url{
                let url = APIServiceGeneral.baseURL.appendingPathComponent("file/download/\(profilePicPath)")
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .padding(.top, 20)
            } else {
                Circle()
                    .frame(width: 120, height: 120)
                    .padding(.top, 20)
            }
            
            Group{
                if sesion.currentUser != nil{
                    Text(sesion.currentUser!.name)
                } else {
                    Text("Unknown")
                }
            }
            .font(.title3)
            .padding(.top, 20)
            
            VStack(alignment: .center){
                HStack(spacing: 25){
                    VStack{
                        Text("8")
                        Text("Reportes")
                        Text("Aceptador")
                    }
                    
                    Divider()
                        .frame(height: 60)
                    
                    VStack{
                        Text("8")
                        Text("Reportes")
                        Text("Totales")
                    }
                    
                    Divider()
                        .frame(height: 60)
                    
                    VStack{
                        Text("8")
                        Text("Reportes")
                        Text("Rechazados")
                    }
                }
                
                Divider()
                    .padding(.horizontal, 25)
                    .foregroundStyle(.blue)
            }
            .foregroundStyle(.gray)
        }
    }
    
}
