//
//  QuizComplete.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation

class QuizCompleteUseCase: APIManager{
    typealias ModelType = QuizCompleteResponse
    
    var methodPath: String{
        return "/quiz/completion"
    }
}
