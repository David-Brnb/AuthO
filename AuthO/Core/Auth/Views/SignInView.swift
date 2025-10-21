//
//  SignInView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel: SignInViewModel
    @State private var showCaptcha: Bool = false
    @EnvironmentObject var session: SessionManager

    init() {
        _viewModel = StateObject(wrappedValue: SignInViewModel(sessionManager: SessionManager()))
    }

    var body: some View {
        NavigationStack{
            VStack{
                
                Image("logo")
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .padding(.top, 70)
                
                Card{
                    VStack(alignment: .center){
                        HStack{
                            Text("Bienvenido a O-Fraud!")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        
                        VStack(spacing: 20){
                            CustonInputField(icon: "envelope", placeholder: "Correo electrónico", isSecure: false, text: $viewModel.email)
                            
                            CustonInputField(icon: "lock", placeholder: "Password", isSecure: true, text: $viewModel.password)
                        }
                        
                        Spacer()
                        
                        Button{
                            showCaptcha = true
                        } label: {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Iniciar sesión")
                            }
                        }
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 300, height: 50)
                        .background(Color(.systemOrange))
                        .clipShape(Capsule())
                        .padding()
                        .disabled(viewModel.isLoading)
                    }
                    .padding()
                }
                .frame(width: 350, height: 250)
                .padding(.top, 40)
                
                
                
                Spacer()
                
                
                AuthDestinationView {
                    Text("¿Eres nuevo?")
                        .foregroundStyle(.white)
                    
                    NavigationLink{
                        SignUpView()
                            .toolbar(.hidden)
                    } label: {
                        Text("Registrate")
                            .foregroundColor(.orange)
                            .underline()
                    }
                }
            }
            .onAppear {
                viewModel.sessionManager = session
            }
            .sheet(isPresented: $showCaptcha) {
                CaptchaView() {
                    viewModel.isCaptchaCompleted = true
                    viewModel.login()
                }
            }
            .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
                Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("OK")) {
                    viewModel.errorMessage = nil
                })
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SignInView()
        .environmentObject(SessionManager())
}

