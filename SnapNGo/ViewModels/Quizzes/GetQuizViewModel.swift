//
//  GetQuizViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

class GetQuizViewModel: ObservableObject{
    
    @Published var teamId: String = ""
    @Published var quizzesId: [String] = []

    @Published var quizzes: [Quiz] = []
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func fetchQuiz(completion: @escaping (Error?) -> Void){
        isLoading = true
        let getQuizDTO = GetQuizDTO(teamId: teamId, quizzes: quizzesId)
        let getBatchQuiz = GetBatchQuiz()
        
        getBatchQuiz.execute(data: getQuizDTO, getMethod: "POST") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.quizzes = response.quizzes
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            }
        }
        
        
    }
}
