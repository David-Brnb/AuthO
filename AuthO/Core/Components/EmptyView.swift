//
//  EmptyView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/10/25.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack{
            Spacer()
                .padding(.top, 50)
            
            Image(systemName: "xmark.bin.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .foregroundStyle(Color(.systemGray))
            
            
            Text("Sin reportes por mostrar")
                .font(.title)
                .fontWeight(.semibold)
                .padding(20)
                .foregroundStyle(Color(.systemGray))
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    EmptyView()
}
