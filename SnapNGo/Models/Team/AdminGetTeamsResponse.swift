//
//  AdminGetTeamsResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/31.
//

import Foundation

struct AdminGetTeamsResponse: Codable{
    let message: String
    let teams: [CreatedTeam]
}

struct CreatedTeam: Codable, Hashable{
    let _id: String
    let teamName: String
    let adminId: String
    let adminEmail: String
    let teamImageUrl: String
    let totalTasks: Int
    let members: [String]
    let maxMember: Int
    let assignedQuizzes: [String]
    let assignedSnapQuizzes: [String]?
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}
