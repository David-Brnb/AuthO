//
//  CategoryMenuView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 25/09/25.
//

import SwiftUI

struct CategoryMenuView: View {
    @Binding var selectedCategory: CategoryModel?
    @StateObject private var categoryVM = CategoryViewModel.shared
    
    var body: some View {
        Menu {
            Button{
                selectedCategory = nil
            } label: {
                Label("General", systemImage: "ellipsis.circle")
                    .tint(.blue)
            }
            
            ForEach(categoryVM.categories, id: \.id){ category in
                Button {
                    selectedCategory = category
                }label: {
                    Label(category.name, systemImage: category.icon)
                        .tint(category.categoryColor)
                }
            }
            
        } label: {
            
            if let selected = selectedCategory {
                HStack {
                    Text(selected.name)
                    Image(systemName: selected.icon)
                }
                .foregroundStyle(selected.categoryColor)
            } else {
                HStack{
                    Text("Categoría")
                    Image(systemName: "ellipsis.circle")
                }
                .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    CategoryMenuView(selectedCategory: .constant(nil))
}
