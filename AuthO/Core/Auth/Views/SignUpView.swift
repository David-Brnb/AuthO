//
//  SignUpView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var nameErrors: String = ""
    @State private var emailErrors: String = ""
    @State private var passwordErrors: String = ""
    
    @State private var showAviso: Bool = false
    @State private var showSelectPhoto: Bool = false
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
            VStack{
                
                Image("logo")
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .padding(.top, 70)
                
                Card{
                    VStack(alignment: .center){
                        HStack{
                            Text("Crea tu cuenta!")
                                .font(.title2)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        
                        VStack(spacing: 20){
                            CustonInputField(icon: "person", placeholder: "Nombre de Usuario", isSecure: false, text: $username, bottomText: nameErrors)
                            
                            CustonInputField(icon: "envelope", placeholder: "Correo electrónico", isSecure: false, text: $email, bottomText: emailErrors)
                            
                            CustonInputField(icon: "lock", placeholder: "Password", isSecure: true, text: $password, bottomText: passwordErrors)
                        }
                        
                        Button {
                            showAviso=true
                        } label: {
                            Text("Aviso de privacidad")
                                .underline()
                        }
                        .padding(.bottom)
                        
                        Spacer()
                        
                        Button{
                            print("Registrandose")
                            showSelectPhoto=true
                        } label: {
                            Text("Registrarme")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(width: 300, height: 50)
                                .background(email.isEmpty || password.isEmpty || username.isEmpty ? Color(.systemGray) : Color(.systemOrange))
                                .clipShape(Capsule())
                                .padding()
                        }
//                        .disabled(email.isEmpty || password.isEmpty || username.isEmpty)
                    }
                    .padding()
                }
                .frame(width: 350, height: 250)
                .padding(.top, 50)
                
                
                
                Spacer()
                
                
                AuthDestinationView {
                    Text("¿Ya tienes cuenta?")
                        .foregroundStyle(.white)
                    
                    Button{
                        dismiss()
                    } label: {
                        Text("Iniciar Sesion")
                            .foregroundColor(.orange)
                            .underline()
                    }
                }
            }
            .onChange(of: username) { oldValue, newValue in
                nameScopeValidation(newValue: newValue)
            }
            .onChange(of: email) { oldValue, newValue in
                validateEmailScope(newValue: newValue)
            }
            .onChange(of: password) { oldValue, newValue in
                validatePasswordScope(newValue: newValue)
            }
            .sheet(isPresented: $showAviso) {
                AvisoPrivacidadView()
            }
            .navigationDestination(isPresented: $showSelectPhoto){
                UploadProfilePhotoView(credentials: SignUpCredentials(name: username, email: email, password: password))
            }
            .ignoresSafeArea()
        
        
    }
}

#Preview {
    NavigationStack{
        SignUpView()
    }
}

extension SignUpView {
    
    func nameScopeValidation(newValue: String) {
        if newValue.isEmpty {
            nameErrors = "No puede estar vacio"
            
        } else if newValue.count < 5 {
            nameErrors = "Debe tener 5 caracteres al menos"
            
        } else {
            nameErrors = ""
        }
    }
    
    func validateEmailScope(newValue: String) {
        if newValue.isEmpty {
            emailErrors = "No puede estar vacío"
            
        } else if !newValue.isValidEmail() {
            emailErrors = "No se reconoce un correo valido"
            
        } else {
            emailErrors = ""
        }
    }
    
    func validatePasswordScope(newValue: String) {
        let specialCharacters = CharacterSet(charactersIn: ".!@#$%^&*")
        let numberCharacters = CharacterSet(charactersIn: "0123456789")
        
        if newValue.isEmpty {
            passwordErrors = "La contraseña no puede estar vacía"
             
        } else if newValue.count < 8 {
            passwordErrors = "Debe tener 8 caracteres al menos"
            
        } else if newValue.rangeOfCharacter(from: specialCharacters) == nil {
            passwordErrors = "Debe tener al menos un caracter .!@#$%^&*"
            
        } else if newValue.rangeOfCharacter(from: numberCharacters) == nil {
            passwordErrors = "Debe tener al menos un número"
            
        } else if newValue.rangeOfCharacter(from: .uppercaseLetters) == nil {
            passwordErrors = "Debe tener al menos una letra mayúscula"
            
        } else if newValue.rangeOfCharacter(from: .lowercaseLetters) == nil {
            passwordErrors = "Debe tener al menos una letra minúscula"
            
        } else {
            passwordErrors = ""
        }
    }
}
