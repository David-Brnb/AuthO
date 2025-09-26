//
//  CommentView.swift
//  AuthO
//
//  Created by Leoni Bernabe on 26/09/25.
//

import SwiftUI
import Kingfisher

struct CommentView: View {
    let comment: ComentaryModel
    
    var body: some View {
        Card {
            VStack(alignment: .leading){
                HStack (alignment: .top){
                    KFImage(URL(string: comment.user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                    
                    VStack (alignment: .leading){
                        HStack {
                            Text(comment.user.name)
                                .fontWeight(.semibold)
                            Text("2d")
                        }
                        
                        VStack (alignment: .leading){
                            Text(comment.content)
                            Spacer()
                        }
                        .frame(height: 80)
                    }
                    .foregroundStyle(.black)
                }
                
                HStack{
                    CommentsView(comments: comment.comments.count){}
                    Spacer()
                    
                    LikeView(likes: comment.likes){}
                }
                .foregroundStyle(.gray)
                .padding(.horizontal)
            }
            .padding()
            
        }
        .frame(width: 380)
        .frame(maxHeight: 100)
    }
}

#Preview {
    CommentView(comment: ExampleComments.comment3)
}
