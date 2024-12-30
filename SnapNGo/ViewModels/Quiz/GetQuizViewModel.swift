//
//  GetQuizViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

class GetQuizViewModel: ObservableObject{
    @Published var quizzes: [QuizGroup] = []
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    
    func fetchQuiz(locations: [String]){
        isLoading = true
        let getQuiz = GetQuiz(locations: locations)
        
        getQuiz.execute { result in
            switch result {
            case .success(let response):
                self.isLoading = false
                print(response)
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print(error.localizedDescription)
            }
        }
        
    }
}
