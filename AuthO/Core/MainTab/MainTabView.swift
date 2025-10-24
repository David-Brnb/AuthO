//
//  MainTabView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedIndex: Int = 0
    
    var body: some View {
        TabView(selection: $selectedIndex){
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Perfil")
                }
                .tag(0)
            
            FeedView(selectedIndex: $selectedIndex)
                .tabItem{
                    Image(systemName: "text.document")
                    Text("Reportes")
                }
                .tag(1)
            
            ChartView(selectedIndex: $selectedIndex)
                .tabItem{
                    Image(systemName: "chart.pie")
                    Text("Gráficas")
                }
                .tag(2)
            
            SearchView(selectedIndex: $selectedIndex)
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Buscar")
                }
                .tag(3)
        }
    }
}

#Preview {
    MainTabView()
}
