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
    let assignedSnapQuizzes: [IdModel]
}

struct IdModel: Codable{
    let _id: String
}

struct TeamMember: Codable {
    let _id: String
    let name: String
    let email: String
    let password: String
    let profileImageUrl: String
    let gender: String
    let dob: Date?
    let school: String
    let address: String
    let totalPoints: Int
    let totalTasks: Int
    let teamPoints: Int
    let tasks: [TeamTasks]?
    let snapTaskQuiz: [TeamSnapTask]?
    let inventory: [TeamInventoryItem]?
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

struct TeamSnapTask: Codable{
    let snapQuizId: String
    let status: SnapStatusModel
    let _id: String
}

struct TeamInventoryItem: Codable, Hashable {
    let itemId: String
    let quantity: Int
    let isEquipped: Bool
    let _id: String
}
