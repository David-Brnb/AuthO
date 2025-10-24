//
//  UserDailyContributionView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import SwiftUI
import Charts

struct UserDailyContributionView: View {
    @StateObject private var viewModel = ChartsViewModel.shared
    @EnvironmentObject var sesion: SessionManager
    @State private var showChart: Bool = true
    
    var body: some View {
        NavigationStack {
            Form {
                Text("Tu día con mas contribuciones de la semana fue de \(Text("\(viewModel.mostContributedDay().count) reportes").bold()) el \(viewModel.mostContributedDay().day,  format: Date.FormatStyle().day().month())")
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                
                Section {
                    Chart {
                        ForEach(viewModel.userBarChartData, id: \.id) { chartPoint in
                            BarMark(
                                x: .value("day", chartPoint.day),
                                y: .value("contribution", chartPoint.count),
                                width: .fixed(15)
                            )
                            .opacity(Calendar.current.isDateInToday(chartPoint.day) ? 1 : 0.5)
                        }
                        
                    }
                    .frame(height: 200)
                    .chartXScale(range: .plotDimension(padding: 20))
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .day)) { value in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel(format: .dateTime.day(), centered: true)
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .padding(2)
                }
                
                Section {
                    Toggle("Mostrar reportes rechazados o pendientes", isOn: $showChart)
                }
            }
            .refreshable {
                if showChart {
                    viewModel.fetchUserBarChartData(userId: sesion.currentUser!.id)
                    
                } else {
                    viewModel.fetchUserBarChartDataAccepted(userId: sesion.currentUser!.id)
                }
            }
            .onChange(of: showChart) { oldValue, newValue in
                if newValue {
                    viewModel.fetchUserBarChartData(userId: sesion.currentUser!.id)
                    
                } else {
                    viewModel.fetchUserBarChartDataAccepted(userId: sesion.currentUser!.id)
                }
                
            }
            .navigationTitle("Contribuciones diarias")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    UserDailyContributionView()
}
