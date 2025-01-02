//
//  GetQuizViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

class GetQuizViewModel: ObservableObject{
    @Published var quizzes: [QuizGroup] = []
    @Published var quizzesId: [String] = []
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func fetchQuiz(locations: [String], completion: @escaping (Error?) -> Void){
        isLoading = true
        let getQuiz = GetQuiz(locations: locations)
        
        getQuiz.execute { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.isLoading = false
                    self.quizzesId = response.map { $0._id } // Collect all IDs in one step
                    self.quizzes = response   
                    completion(nil)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                    completion(error)
                }
            }
        }
        
    }
}
