import SwiftUI
import Kingfisher

struct ReportDetailView: View {
    @State var report: ReportCardModel
    @State private var replyText: String = ""
    
    @StateObject private var viewModel: ReportCardDetailViewModel = ReportCardDetailViewModel()
    @StateObject private var viewModelComment: CommentViewModel = CommentViewModel()
    
    init(report: ReportCardModel) {
        self.report = report
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                
                ScrollView {
                    VStack(spacing: 0) {
                        NormalReportCardView(report: report, detail: true)
                            .padding()
                        
                        Divider()
                            .padding(.horizontal, 10)
                        
                        if !viewModel.comments.isEmpty {
                            HStack {
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
                                } label: {
                                    CommentView(comment: comment)
                                        .padding(.vertical, 40)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        
                        Spacer(minLength: 80)
                    }
                }
                .refreshable {
                    viewModel.fetchComments(reportCardId: report.id)
                }
                
                
                FloatingInputText(text: $replyText){
                    // aqui va lo que se manda en el mensaje
                    print("sending comment on report")
                    viewModelComment.createComment(comment: commentResponse(content: replyText, report_id: report.id, parent_comment_id: nil))
                    viewModel.fetchComments(reportCardId: report.id)
                    replyText=""
                }
            }
            .navigationTitle("Reporte")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear() {
                viewModel.fetchComments(reportCardId: report.id)
            }
        }
    }
}

