//
//  OneQuizResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation

struct OneQuizResponse: Codable{
    let message: String
    let question: Quiz
}

struct Quiz: Codable, Hashable{
    let question: String
    let options: [String]
    let answer: Int
    let rewardPoints: Int
    let _id: String
}
