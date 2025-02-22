//
//  SnapQuizCompleteUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 21/02/2025.
//

import Foundation

class SnapQuizCompleteUseCase: APIManager{
    typealias ModelType = SnapQuizCompleteResponse
    
    var methodPath: String{
        return "/snapquiz/completion"
    }
}

