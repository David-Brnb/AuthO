//
//  SearchView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI

struct SearchView: View {
    @State var description: Bool = true
    @State var url: Bool = true
    @State var title: Bool = true
    @State var category: Bool = true
    @State var showFilters: Bool = false
    
    @Binding var selectedIndex: Int
    @State var searchText: String = ""
    
    @StateObject private var viewModel: FeedViewModel = FeedViewModel.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView{
                    if searchText.isEmpty {
                        ForEach(viewModel.reports, id: \.id) { card in
                            NormalReportCardView(report: card, detail: false)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        }
                        
                    } else {
                        let filteredCards = searchCards(
                            cards: viewModel.reports
                        )
                        
                        ForEach(filteredCards, id: \.card.id) { reportSearch in
                            SearchReportCardView(report: reportSearch)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        }
                        
                    }
                    
                }
            }
            .searchable(text: $searchText, prompt: "Buscar reporte...")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        selectedIndex=0
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            
                    }
                    .tint(Color(.systemBlue))
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFilters=true
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                    .tint(Color(.systemBlue))
                }
            }
            .sheet(isPresented: $showFilters){
                SearchFiltersView(description: $description, url: $url, title: $title, category: $category)
            }
            
        }
    }
}

#Preview {
    SearchView(selectedIndex: .constant(0))
}


extension SearchView {
    func searchCards(
        cards: [ReportCardModel],
    ) -> [SearchCardModel] {
        let lowercasedSearch = searchText.lowercased()
        var results: [SearchCardModel] = []
        
        for card in cards {
            var relatedFields: [String] = []
            
            if description, card.description.lowercased().contains(lowercasedSearch) {
                relatedFields.append("descripcion")
            }
            
            if url, card.reference_url.lowercased().contains(lowercasedSearch) {
                relatedFields.append("url")
            }
            
            if title, card.title.lowercased().contains(lowercasedSearch) {
                relatedFields.append("titulo")
            }
            
            if category, card.category.name.lowercased().contains(lowercasedSearch) {
                relatedFields.append("categoria")
            }
            
            if !relatedFields.isEmpty {
                results.append(SearchCardModel(card: card, relatedFields: relatedFields))
            }
        }
        
        return results
    }
}
