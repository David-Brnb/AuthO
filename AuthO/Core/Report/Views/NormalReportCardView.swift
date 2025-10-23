//
//  NormalReportCardView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI

import Kingfisher

struct NormalReportCardView: View {
    let report: ReportCardModel
    let detail: Bool
    
    var body: some View {
        Card {
            VStack(alignment: .leading){
                Text(report.title)
                    .font(.title.bold())
                
                Text(report.reference_url)
                    .font(.caption)
                    .foregroundStyle(.blue)
                
                KFImage(URL(string: report.report_pic_url)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 170)
                    .clipped()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                    )
                    .shadow(color: .gray.opacity(80), radius: 5, x:0, y:0)
                    .padding(.top, 5)
                
                Text(report.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
//                CategoryField(category: report.category, sideView: !detail ? AnyView(LikeView(likes: report.likes){}) : AnyView(CommentsView(comments: report.comments.count){}))
                
                CategoryField(category: report.category, sideView: EmptyView())
                
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(width: 380)
        .frame(maxHeight: 450)
    }
}
