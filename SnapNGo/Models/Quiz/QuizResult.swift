//
//  QuizResult.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/25.
//

import Foundation

struct QuizResult: Codable{
    let userId: String
    let taskId: String
    let isAnswerCorrect: Bool?
    let selectedAnswer: Int
}
