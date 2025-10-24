//
//  ReportLikesView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import SwiftUI
import Charts

struct ReportLikesView: View {
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
                
                
                Text("La pagina del reporte con más likes fue \(Text(ChartDataExamples.mostLikedReport!.title).foregroundColor(.blue)) con un total de \(Text("\(String(format: "%.2f", ChartDataExamples.mostLikedPercentaje))%").bold()) del total")
                    .listRowSeparator(.hidden)
                
                switch selectedOption{
                case 0:
                    pieChart
                case 1:
                    EmptyView()
                case 2:
                    EmptyView()
                    
                default:
                    pieChart
                }
                
                Spacer()
                
                
            }
            .padding(.horizontal)
            .navigationTitle("Reports Impact")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ReportLikesView()
}


extension  ReportLikesView {
    var pieChart: some View {
        Chart(ChartDataExamples.likedReports, id: \.id) { dataItem in
            SectorMark(angle: .value("Type", dataItem.likes),
                       innerRadius: .ratio(0.5),
                       angularInset: 0.5)
                .foregroundStyle(by: .value("Type", dataItem.title))
        }
        .chartLegend(position: .bottom, alignment: .center)
        .padding(.horizontal, 20)
        .frame(height: 500)
    }
}
