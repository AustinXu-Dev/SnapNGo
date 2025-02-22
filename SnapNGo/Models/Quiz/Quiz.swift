//
//  Quiz.swift
//  SnapNGo
//
//  Created by Austin Xu on 21/02/2025.
//

import Foundation

struct Quiz: Codable, Hashable{
    let question: String
    let options: [String]
    let answer: Int
    let rewardPoints: Int
    let _id: String
}
