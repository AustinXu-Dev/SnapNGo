//
//  QuizCompleteDTO.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation

struct QuizCompleteDTO: Codable{
    let userId: String
    let taskId: String
    let selectedAnswer: Int
}
