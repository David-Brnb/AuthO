//
//  FeedView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI

struct FeedView: View {
    @Binding var selectedIndex: Int
    @State private var showAddReport: Bool = false
    @State private var selectedCategory: CategoryModel? = nil
    @State private var selectedReport: ReportCardModel? = nil
    
    @StateObject private var viewModel: FeedViewModel = FeedViewModel.shared
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    Divider()
                        .padding(.top, 170)
                    
                    if viewModel.reports.isEmpty {
                        EmptyView()
                    } else {
                        let filteredCards = selectedCategory == nil
                        ? viewModel.reports
                            : viewModel.reports.filter { $0.category == selectedCategory }
                        
                        ForEach(filteredCards, id: \.id) { card in
                            
                            Button {
                                selectedReport = card
                            } label : {
                                NormalReportCardView(report: card, detail: false)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                            }
                            .buttonStyle(.plain)
                            
                            
                        }
                        
                        Spacer()
                            .frame(height: 90)
                    }
                }
                .refreshable {
                    viewModel.fetchReports()
                }
                .navigationTitle("Feed")
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
                    
                    ToolbarItem(placement: .topBarTrailing){
                        CategoryMenuView(selectedCategory: $selectedCategory)
                        
                    }
                    
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            print("Crear Reporte")
                            showAddReport=true
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                        .tint(Color(.systemBlue))
                    }
                }
            }
            .sheet(isPresented: $showAddReport) {
                AddReportView(showAddReport: $showAddReport)
            }
            .sheet(item: $selectedReport){ report in
                ReportDetailView(report: report)
            }
            .ignoresSafeArea()
            .onAppear(){
                if viewModel.reports.isEmpty {
                    print("NO hay datos")
                    
                    viewModel.fetchReports()
                }
            }
        }
    }
}


#Preview {
    FeedView(selectedIndex: .constant(1))
}
