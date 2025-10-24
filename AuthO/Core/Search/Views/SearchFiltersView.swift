//
//  SearchFiltersView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 27/09/25.
//

import SwiftUI

struct SearchFiltersView: View {
    @Binding var description: Bool
    @Binding var url: Bool
    @Binding var title: Bool
    @Binding var category: Bool
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Título", isOn: $title)
                }
                
                Section {
                    Toggle("URL", isOn: $url)
                }
                
                Section {
                    Toggle("Descripción", isOn: $description)
                }
                
                Section {
                    Toggle("Categoría", isOn: $category)
                }
            }
            .navigationTitle("Filtros de Búsqueda")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    SearchFiltersView(description: .constant(true), url: .constant(true), title: .constant(true), category: .constant(true))
}
