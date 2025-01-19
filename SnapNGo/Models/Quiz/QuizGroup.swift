//
//  QuizGroup.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

struct QuizResponse: Codable{
    let message: String
    let quizzes: [Quiz]
}

struct Quiz: Codable{
    let question: String
    let options: [String]
    let answer: Int
    let rewardPoints: Int
    let _id: String
}
