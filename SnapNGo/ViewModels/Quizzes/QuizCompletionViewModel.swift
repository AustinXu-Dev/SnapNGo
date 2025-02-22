//
//  QuizCompletionViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation

class QuizCompletionViewModel: ObservableObject{
    
    @Published var userData: User? = nil
    @Published var isAnsweredCorrect: Bool = false
//    @Published var completedTaskCount: Int = 0
//    @Published var totalTaskCount: Int = 0
    
    @Published var isLoading : Bool = false
    @Published var loadingMessage: String = ""
    @Published var errorMessage : String? = nil
    
    func checkQuizAnswer(forUserId userId: String, forTaskId taskId: String, withAnswer selectedAnswer: Int, completion: @escaping (Error?) -> Void){
        isLoading = true
        let quizCompleteDTO = QuizCompleteDTO(userId: userId, taskId: taskId, selectedAnswer: selectedAnswer)
        let quizCompleteManager = QuizCompleteUseCase()
        
        quizCompleteManager.execute(data: quizCompleteDTO, getMethod: "POST") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.userData = response.user
                    self.isAnsweredCorrect = response.isAnswerCorrect
                    
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
}
