//
//  QuizCompleteResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation

struct QuizCompleteResponse: Codable{
    let message: String
    let user: User
    let isAnswerCorrect: Bool
    let completedTaskCount: Int
    let totalTaskCount: Int
}
