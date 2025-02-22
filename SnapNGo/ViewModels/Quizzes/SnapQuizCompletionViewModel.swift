//
//  SnapQuizCompletionViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 21/02/2025.
//

import Foundation

class SnapQuizCompletionViewModel: ObservableObject {
    
    @Published var userData: User? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func checkQuizAnswer(userId: String, taskId: String, selectedAnswer: String, completion: @escaping () -> Void){
        isLoading = true
        let snapQuizDTO = SnapQuizCompleteDTO(userId: userId, taskId: taskId, selectedAnswer: selectedAnswer)
        let useCase = SnapQuizCompleteUseCase()
        
        useCase.execute(data: snapQuizDTO, getMethod: "POST") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.userData = response.user
                    self.isLoading = false
                    completion()
                case .failure(let failure):
                    self.isLoading = false
                    self.errorMessage = failure.localizedDescription
                    print("Error in snap quiz completion: \(failure.localizedDescription)")
                    completion()
                }
            }
        }
    }
}
