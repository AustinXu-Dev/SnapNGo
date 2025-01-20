//
//  GetOneQuiz.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation

class GetOneQuiz: APIManager{
    typealias ModelType = OneQuizResponse
    
    var quizId: String
    
    init(quizId: String) {
        self.quizId = quizId
    }
    
    var methodPath: String{
        return "/quiz/\(quizId)"
    }
}
