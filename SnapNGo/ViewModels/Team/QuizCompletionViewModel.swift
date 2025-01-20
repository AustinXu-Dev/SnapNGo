//
//  QuizCompletionViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation

class QuizCompletionViewModel: ObservableObject{
    
    @Published var quizData: Quiz? = nil
    @Published var userData: User? = nil
    @Published var isAnsweredCorrect: Bool? = nil
    @Published var progress: String = ""
    
    @Published var isLoading : Bool = false
    @Published var loadingMessage: String = ""
    @Published var errorMessage : String? = nil
    
    func getOneQuiz(forQuizId quizId: String, completion: @escaping (Error?) -> Void){
        isLoading = true
        loadingMessage = "Fetching Quiz"
        let getOneQuizManager = GetOneQuiz(quizId: quizId)
        
        getOneQuizManager.execute(getMethod: "GET") { result in
            switch result {
            case .success(let response):
                self.quizData = response.question
                
                self.isLoading = false
                self.loadingMessage = ""
                completion(nil)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("Error in quiz complete vm: ", error.localizedDescription)
                self.isLoading = false
                completion(error)
            }
        }
    }
    
    func checkQuizAnswer(forUserId userId: String, forTaskId taskId: String, withAnswer selectedAnswer: Int, completion: @escaping (Error?) -> Void){
        isLoading = true
        let quizCompleteDTO = QuizCompleteDTO(userId: userId, taskId: taskId, selectedAnswer: selectedAnswer)
        let quizCompleteManager = QuizCompleteUseCase()
        
        quizCompleteManager.execute(data: quizCompleteDTO, getMethod: "POST") { result in
            switch result {
            case .success(let response):
                self.userData = response.user
                self.isAnsweredCorrect = response.isAnswerCorrect
                self.progress = response.progress
                
                self.isLoading = false
                completion(nil)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("Error in quiz complete vm: ", error.localizedDescription)
                self.isLoading = false
                completion(error)
            }
        }
    }
}
