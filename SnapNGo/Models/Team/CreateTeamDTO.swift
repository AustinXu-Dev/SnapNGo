//
//  CreateTeamDTO.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/12/17.
//

import Foundation

struct CreateTeamDTO: Codable{
    let teamName: String
    let adminUsername: String
    let teamImageUrl: String
    let totalTasks: Int
    let maxMember: Int
    let assignedQuizzes: [String]?
}
