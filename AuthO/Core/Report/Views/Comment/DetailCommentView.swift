//
//  DetailCommentView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 26/09/25.
//

import SwiftUI

struct DetailCommentView: View {
    @State var comment: CommentDTO
    @State var text = ""
    
    @StateObject private var viewModel: CommentViewModel = CommentViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack (alignment: .bottom){
                ScrollView{
                    CommentView(comment: comment)
                        .padding(.vertical, 50)
                    
                    Divider()
                        .padding(.horizontal, 10)
                    
                    if !viewModel.comments.isEmpty {
                        HStack{
                            Text("Comments")
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                            Spacer()
                        }
                        
                        ForEach(viewModel.comments, id: \.id) { comment in
                            NavigationLink {
                                DetailCommentView(comment: comment)
                            } label : {
                                CommentView(comment: comment)
                                    .padding(.vertical, 40)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .refreshable {
                    viewModel.fetchComments(commentId: comment.id)
                }
                
                FloatingInputText(text: $text){
                    print("Sending comment on comment \(text)")
                    viewModel.createComment(comment: commentResponse(content: text, report_id: comment.reportID, parent_comment_id: comment.id))
                    viewModel.fetchComments(commentId: comment.id)
                    text = ""
                    print("Comment sent")
                }
            }
            .navigationTitle("Comment")
            .navigationBarTitleDisplayMode( .inline )
            .onAppear(){
                viewModel.fetchComments(commentId: comment.id)
            }
            .alert(isPresented: .constant(viewModel.error != nil)) {
                Alert(title: Text("Error"), message: Text(viewModel.error ?? ""), dismissButton: .default(Text("OK")) {
                    viewModel.error = nil
                })
            }
        }
    }
}

//#Preview {
//    DetailCommentView(comment: ExampleComments.comment3)
//}
