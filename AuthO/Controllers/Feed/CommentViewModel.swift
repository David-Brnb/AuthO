//
//  CommentViewModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 22/10/25.
//

import Foundation
import Combine

class CommentViewModel: ObservableObject {
    @Published var comments: [CommentDTO] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    func fetchComments(commentId: Int){
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        
        isLoading = true
        error = nil
        
        Task {
            do {
                let commentData = try await APIServiceFeed.shared.fetchCommentComments(comment_id: commentId)
                
                await MainActor.run {
                    self.comments = commentData
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    print("Error fetching categories: \(error.localizedDescription)")
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func createComment(comment: commentResponse){
        guard KeychainService.shared.retrieve(for: "accessToken") != nil else {
            self.error = "No token available"
            return
        }
        
        Task {
            do {
                print("commenting")
                let commented = try await APIServiceFeed.shared.uploadComment(comment: comment)
                
                if commented {
                    print("Commented h")
                    fetchComments(commentId: comment.parent_comment_id!)
                    
                } else {
                    print("No")
                    throw APIError.custom("Error while uploading comment");
                }
                
            } catch {
                throw error;
            }
        }
    }
}

    
    
