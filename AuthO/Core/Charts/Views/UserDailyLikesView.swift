//
//  UserDailyLikesView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import SwiftUI
import Charts

struct UserDailyLikesView: View {
    var body: some View {
        NavigationStack {
            Form {
                Text("Mediante tus reportes has ayudado a  \(Text("más de \(ChartDataExamples.totalLikesReports) personas").bold())")
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                
                Section {
                    Chart {
                        ForEach(ChartDataExamples.userDailyLikes, id: \.id) { chartPoint in
                            LineMark(
                                x: .value("day", chartPoint.day),
                                y: .value("contribution", chartPoint.likes),
                            )
                            .opacity(Calendar.current.isDateInToday(chartPoint.day) ? 1 : 0.5)
                            
                            AreaMark(
                                x: .value("day", chartPoint.day),
                                y: .value("contribution", chartPoint.likes),
                            )
                            .opacity(0.2)
                            
                            PointMark(
                                x: .value("day", chartPoint.day),
                                y: .value("contribution", chartPoint.likes)
                            )
                            .symbol(.circle)
                            .symbolSize(50)
                            .foregroundStyle(.blue)
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
            }
            .navigationTitle("Impacto de reportes propios")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    UserDailyLikesView()
}
