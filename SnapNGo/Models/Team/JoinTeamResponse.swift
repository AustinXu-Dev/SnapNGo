//
//  JoinTeamResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

struct JoinTeamResponse: Codable{
    let message: String
    let team: JoinTeamModel
}

struct JoinTeamModel: Codable{
    let _id: String
    let teamName: String
    let adminId: String
    let adminEmail: String
    let teamImageUrl: String
    let totalTasks: Int
    let members: [String]?
    let maxMember: Int
    let assignedQuizzes: [String]?
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}
