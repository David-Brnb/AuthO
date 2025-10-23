//
//  DetailCommentView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 26/09/25.
//

import SwiftUI

struct DetailCommentView: View {
    @State var comment: CommentDTO
    
    var body: some View {
        NavigationStack{
            ZStack (alignment: .bottom){
                ScrollView{
                    CommentView(comment: comment)
                        .padding(.vertical, 50)
                    
                    Divider()
                        .padding(.horizontal, 10)
                    
//                    if !comment.comments.isEmpty {
//                        HStack{
//                            Text("Comments")
//                                .font(.caption)
//                                .foregroundStyle(.gray)
//                                .padding(.horizontal, 20)
//                                .padding(.top, 20)
//                            Spacer()
//                        }
//                        
//                        ForEach(comment.comments, id: \.id) { comment in
//                            NavigationLink {
//                                DetailCommentView(comment: comment)
//                            } label : {
//                                CommentView(comment: comment)
//                                    .padding(.vertical, 40)
//                            }
//                            .buttonStyle(.plain)
//                        }
//                    }
                }
                
                FloatingInputText(text: .constant("")){
                    
                }
            }
            .navigationTitle("Comment")
            .navigationBarTitleDisplayMode( .inline )
        }
    }
}

//#Preview {
//    DetailCommentView(comment: ExampleComments.comment3)
//}
