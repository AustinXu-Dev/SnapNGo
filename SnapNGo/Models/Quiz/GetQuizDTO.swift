//
//  GetQuizDTO.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation

struct GetQuizDTO: Codable{
    let teamId: String
    let quizzes: [String]
    let snapQuizzes: [String]
}
