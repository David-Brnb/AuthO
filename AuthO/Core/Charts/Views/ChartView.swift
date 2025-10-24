//
//  ChartView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI
import Charts
import Kingfisher

struct ChartView: View {
    @Binding var selectedIndex: Int
    @StateObject private var viewModel = ChartsViewModel.shared
    @EnvironmentObject var sesion: SessionManager
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    NavigationLink {
                        UsersDailyContributionView()
                    } label: {
                        usersDailyContributions
                            .contentShape(Rectangle())
                    }
                    
                }
                
                Section {
                    NavigationLink {
                        ReportLikesView()
                    } label: {
                        mostLikedReport
                    }
                }
                
                Section {
                    NavigationLink {
                        UserDailyContributionView()
                    } label: {
                        userDailyContribution
                    }
                }
                
                Section {
                    NavigationLink {
                        UserDailyLikesView()
                    } label: {
                        userDailyLikes
                    }
                }
                
                
            }
            .navigationTitle("Gráficas")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        selectedIndex = 0
                    } label: {
                        if let profilePicPath = sesion.currentUser?.profile_pic_url{
                            KFImage(APIServiceGeneral.resolveProfileURL(from: profilePicPath))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                            
                    }
                    .tint(Color(.systemBlue))
                }
                
            }
        }
        .onAppear(){
            Task {
                let refreshed = await APIService.shared.refreshToken()
                
                if !refreshed {
                    sesion.logout()
                }
                viewModel.fetchUserBarChartData(userId: sesion.currentUser!.id)
            }
        }
    }
}

#Preview {
    ChartView(selectedIndex: .constant(0))
}

extension ChartView {
    var usersDailyContributions: some View {
        VStack {
            Text("El promedio de contribuciones diarias en la semana fue de \(Text("\(viewModel.averageWeeklyContributions()) al día").bold()) dentro de la aplicación")
                .listRowSeparator(.hidden)
            
            Chart {
                ForEach(ChartDataExamples.usersContribution, id: \.id) { chartPoint in
                    BarMark(
                        x: .value("day", chartPoint.day),
                        y: .value("contribution", chartPoint.count),
                        width: .fixed(15)
                    )
                }
                
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: 80)
            .padding(.horizontal)
        }
    }
    
    var mostLikedReport: some View {
        HStack {
            Text("La pagina del reporte con más likes fue \(Text(viewModel.mostReportedPage()).foregroundColor(.blue)) con un total de \(Text("\(String(format: "%.2f", viewModel.mostReportedPagePercentage()))%").bold()) del total")
                .listRowSeparator(.hidden)
            
            Chart(viewModel.pieChartData, id: \.id) { dataItem in
                SectorMark(angle: .value("Type", dataItem.likes),
                           innerRadius: .ratio(0.5),
                           angularInset: 0.5)
                    .foregroundStyle(by: .value("Type", dataItem.title))
            }
            .frame(width: 80, height: 100)
            .chartLegend(.hidden)
            
        }
    }
    
    var userDailyContribution: some View {
        VStack {
            Text("Tu día con mas contribuciones del més con fue de \(Text("\(viewModel.mostContributedDay().count) reportes").bold()) el \(viewModel.mostContributedDay().day,  format: Date.FormatStyle().day().month())")
                .listRowSeparator(.hidden)
            
            Chart {
                ForEach(ChartDataExamples.userContribution, id: \.id) { chartPoint in
                    BarMark(
                        x: .value("day", chartPoint.day),
                        y: .value("contribution", chartPoint.contributions),
                        width: .fixed(15)
                    )
                    .opacity(Calendar.current.isDateInToday(chartPoint.day) ? 1 : 0.5)
                }
                
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: 80)
            .padding(.horizontal)
        }
    }
    
    var userDailyLikes: some View {
        VStack {
            Text("Mediante tus reportes has ayudado a  \(Text("más de \(ChartDataExamples.totalLikesReports) personas").bold())")
                .listRowSeparator(.hidden)
            
            Chart {
                ForEach(ChartDataExamples.userDailyLikes, id: \.id) { chartPoint in
                    LineMark(
                        x: .value("day", chartPoint.day),
                        y: .value("contribution", chartPoint.likes),
                    )
                    .opacity(Calendar.current.isDateInToday(chartPoint.day) ? 1 : 0.5)
                    
                    PointMark(
                        x: .value("day", chartPoint.day),
                        y: .value("contribution", chartPoint.likes)
                    )
                    .symbol(.circle)
                    .symbolSize(50) 
                    .foregroundStyle(.blue)
                }
                
            }
//            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: 120)
            .padding(.horizontal)
        }
    }
    
}

