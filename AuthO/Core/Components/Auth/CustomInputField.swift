//
//  CustomInputField.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI

struct CustonInputField: View {
    let icon: String
    let placeholder: String
    let isSecure: Bool
    
    @Binding var text: String
    var bottomText: String = ""
    @State var showText: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color(.gray))
                
                Group{
                    if isSecure {
                        if showText {
                            TextField(placeholder, text: $text)
                                .frame(height: 20)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField(placeholder, text: $text)
                                .frame(height: 20)
                        }
                        
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .font(.default)
                
                if isSecure {
                    Button {
                        showText.toggle()
                    } label: {
                        
                        Image(systemName: showText ? "eye.slash" : "eye")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color(.gray))
                    }
                    
                }
            }
            Divider()
            
            HStack{
                Text(bottomText)
                    .font(.callout)
                    .foregroundStyle(Color(.secondaryLabel))
                Spacer()
            }
            .padding(.horizontal)
        }
        
    }
}
