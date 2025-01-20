//
//  QuizResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation

struct QuizResponse: Codable{
    let message: String
    let quizzes: [Quiz]
}
