//
//  SnapQuizCompleteResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 21/02/2025.
//

import Foundation

struct SnapQuizCompleteResponse: Codable{
    let message: String
    let user: User
    let isAnswerCorrect: Bool
    let completedTaskCount: Int
    let totalTaskCount: Int
}
