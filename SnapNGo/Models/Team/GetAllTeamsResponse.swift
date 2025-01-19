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
    let adminUsername: String
    let teamImageUrl: String
    let totalPoints: Int
    let totalTasks: Int
    let members: [String]?
    let maxMember: Int
    let assignedQuizzes: [String]?
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}
