//
//  SearchReportCardView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 23/09/25.
//

import SwiftUI

import Kingfisher

struct SearchReportCardView: View {
    let report: SearchCardModel
    
    var body: some View {
        Card {
            VStack(alignment: .leading){
                Text(report.card.title)
                    .font(.title.bold())
                
                Text(report.card.reference_url)
                    .font(.caption)
                    .foregroundStyle(.blue)
                
                KFImage(URL(string: report.card.report_pic_url)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 340, height: 170)
                    .clipped()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                    )
                    .shadow(color: .gray.opacity(80), radius: 5, x:0, y:0)
                    .padding(.top, 5)
                
                Text(report.card.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .lineLimit(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    .foregroundStyle(.secondary)
                
                Spacer()
                    .frame(height: 40)
                
                CategoryField(category: report.card.category, sideView: EmptyView())
                
                VStack(alignment: .leading, spacing: 4){
                    Text("Campos Encontrados")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    HStack{
                        ForEach(report.relatedFields, id:\.self) { field in
                            filter(field)
                        }
                        Spacer()
                    }
                }
                .padding(.top, 5)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .frame(width: 380)
        .frame(maxHeight: 500)
    }
}

//#Preview {
//    SearchReportCardView(report: ExampleSeachCards.searchCards[0])
//}

extension SearchReportCardView {
    
    func filter(_ category: String) -> some View {
        HStack {
            Text(category)
                .font(.footnote)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .overlay(
            Capsule()
                .stroke(lineWidth: 1)
        )
        .foregroundStyle(.gray)
    }
}

