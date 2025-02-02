//
//  TeamResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/12/17.
//

import Foundation

struct GetAllTeamsResponse: Codable{
    let message: String
    let teams: [AllTeamsModel]
}

struct AllTeamsModel: Codable{
    let _id: String
    let teamName: String
    let teamImageUrl: String
    let totalTasks: Int
    let members: [String]?
    let maxMember: Int
    let assignedQuizzes: [String]?
    let adminId: String
    let adminEmail: String
}
