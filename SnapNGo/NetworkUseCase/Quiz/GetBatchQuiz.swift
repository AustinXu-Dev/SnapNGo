//
//  GetQuiz.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

class GetBatchQuiz: APIManager{
    typealias ModelType = QuizResponse
    
    var methodPath: String{
        return "/quiz/details"
    }
}
