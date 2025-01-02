//
//  QuizGroup.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

struct QuizGroup: Codable{
    let _id: String
    let location: String
    let quizzes: [Quiz]
    let __v: Int
}

struct Quiz: Codable{
    let question: String
    let options: [String]
    let answer: Int
    let rewardPoints: Int
    let _id: String
}
