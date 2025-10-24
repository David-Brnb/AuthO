//
//  ReportLikesView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import SwiftUI
import Charts

struct ReportLikesView: View {
    @StateObject private var viewModel = ChartsViewModel.shared
    @State private var selectedOption = 0
    let options = ["Pay", "Barras", "Barra"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Opciones", selection: $selectedOption) {
                    ForEach(0..<options.count, id: \.self) { index in
                        Text(options[index])
                    }
                }
                .pickerStyle(.segmented)
                
                
                Text("La pagina del reporte con más likes fue \(Text(viewModel.mostReportedPage()).foregroundColor(.blue)) con un total de \(Text("\(String(format: "%.2f", viewModel.mostReportedPagePercentage()))%").bold()) del total")
                    .listRowSeparator(.hidden)
                
                switch selectedOption{
                case 0:
                    pieChart
                case 1:
                    barsChart
                case 2:
                    barChart
                    
                default:
                    pieChart
                }
                
                Spacer()
                
                
            }
            .padding(.horizontal)
            .navigationTitle("Impacto de reportes")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ReportLikesView()
}


extension  ReportLikesView {
    var pieChart: some View {
        Chart(viewModel.pieChartData, id: \.id) { dataItem in
            SectorMark(angle: .value("Type", dataItem.likes),
                       innerRadius: .ratio(0.5),
                       angularInset: 0.5)
                .foregroundStyle(by: .value("Type", dataItem.title))
        }
        .chartLegend(position: .bottom, alignment: .center)
        .padding(.horizontal, 20)
        .frame(height: 500)
    }
    
    var barChart: some View {
        Chart(viewModel.pieChartData, id: \.id) { dataItem in
            BarMark(
                x: .value("Bar", "Total"),
                y: .value("Likes", dataItem.likes),
                stacking: .standard
            )
            .foregroundStyle(by: .value("Domain", dataItem.title))
        }
        .chartLegend(position: .bottom, alignment: .center)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .frame(height: 500)
    }
    
    var barsChart: some View {
        Chart(viewModel.pieChartData, id: \.id) { dataItem in
            BarMark(
                x: .value("title", dataItem.title),
                y: .value("Likes", dataItem.likes),
                stacking: .standard
            )
            .foregroundStyle(by: .value("Domain", dataItem.title))
        }
        .chartLegend(.hidden)
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .frame(height: 500)
    }
}
