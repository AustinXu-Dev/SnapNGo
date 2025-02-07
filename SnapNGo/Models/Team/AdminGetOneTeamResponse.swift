//
//  AdminGetOneTeamResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/5.
//

import Foundation

struct AdminGetOneTeamResponse: Codable{
    let message: String
    let team: CreatedOneTeam
    let adminEmail: String
}

struct CreatedOneTeam: Codable{
    let _id: String
    let teamName: String
    let adminEmail: String
    let teamImageUrl: String
    let totalTasks: Int
    let members: [TeamMember]
    let maxMember: Int
    let assignedQuizzes: [String]
}

struct TeamMember: Codable {
    let _id: String
    let name: String
    let email: String
    let password: String
    let profileImageUrl: String
    let dob: Date?
    let school: String
    let address: String
    let totalPoints: Int
    let totalTasks: Int
    let tasks: [TeamTasks]?
    let inventory: [InventoryItem]?
    let role: String
    let teamIds: [String]
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}

struct TeamTasks: Codable{
    let quizId: String
    let status: StatusModel
    let _id: String
}
