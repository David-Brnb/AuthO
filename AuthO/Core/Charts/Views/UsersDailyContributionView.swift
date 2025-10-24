//
//  UsersDailyContributionView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import SwiftUI
import Charts

struct UsersDailyContributionView: View {
    @StateObject private var viewModel = ChartsViewModel.shared
    @State private var showChart: Bool = true
    
    var body: some View {
        NavigationStack {
            Form {
                Text("El promedio de contribuciones \(showChart ? "" : "acceptadas") diarias en la semana fue de \(Text("\(viewModel.averageWeeklyContributions()) al día").bold()) dentro de la aplicación")
                    .listRowBackground(Color.clear)
                
                Section {
                    Chart {
                        if showChart {
                            ForEach(viewModel.generalBarChartData, id: \.id) { chartPoint in
                                BarMark(
                                    x: .value("day", chartPoint.day),
                                    y: .value("contribution", chartPoint.count),
                                    width: .fixed(15)
                                )
                                
                            }
                        }
                        
                    }
                    .frame(height: 200)
                    .chartXScale(range: .plotDimension(padding: 20))
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .day)) { value in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel(format: .dateTime.day().month(), centered: true)
                        }
                    }
                    .padding(2)
                }
                
                Section {
                    Toggle("Mostrar reportes sin aceptar", isOn: $showChart)
                }
            }
            .refreshable {
                if showChart {
                    viewModel.fetchBarChartData()
                } else {
                    viewModel.fetchBarChartDataAccepted()
                }
                
            }
            .onChange(of: showChart){ oldValue, newValue in
                if oldValue {
                    viewModel.fetchBarChartDataAccepted()
                } else {
                    viewModel.fetchBarChartData()
                }
            }
            .navigationTitle("Users Daily Contribution")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    UsersDailyContributionView()
}
