//
//  UserDailyLikesView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 29/09/25.
//

import SwiftUI
import Charts

struct UserDailyLikesView: View {
    @StateObject private var viewModel = ChartsViewModel.shared
    @EnvironmentObject var sesion: SessionManager
    
    var body: some View {
        NavigationStack {
            Form {
                Text("Mediante tus reportes has ayudado a  \(Text("más de \(viewModel.getTotalUserLikes()) personas").bold())")
                    .listRowSeparator(.hidden)
                
                Section {
                    Chart {
                        ForEach(viewModel.userDailyLikes, id: \.id) { chartPoint in
                            LineMark(
                                x: .value("day", chartPoint.day),
                                y: .value("contribution", chartPoint.like_count),
                            )
                            .opacity(Calendar.current.isDateInToday(chartPoint.day) ? 1 : 0.5)
                            
                            AreaMark(
                                x: .value("day", chartPoint.day),
                                y: .value("contribution", chartPoint.like_count),
                            )
                            .opacity(0.2)
                            
                            PointMark(
                                x: .value("day", chartPoint.day),
                                y: .value("contribution", chartPoint.like_count)
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
            .refreshable {
                if let userId = KeychainService.shared.retrieveInt(for: "user_id") {
                    viewModel.fetchLikesReportsUser(userId: userId)
                } else {
                    print("No se encontró el ID del usuario en el Keychain")
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
