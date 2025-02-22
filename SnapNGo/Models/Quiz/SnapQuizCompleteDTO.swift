//
//  SnapQuizCompleteDTO.swift
//  SnapNGo
//
//  Created by Austin Xu on 21/02/2025.
//

import Foundation

struct SnapQuizCompleteDTO: Codable{
    let userId: String
    let taskId: String
    let selectedAnswer: String
}
