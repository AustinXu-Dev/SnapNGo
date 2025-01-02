//
//  CreateTeamResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/2.
//

import Foundation

struct CreateTeamResponse: Codable{
    let message: String
    let team: CreateTeamModel
}

struct CreateTeamModel: Codable{
    let teamName: String
    let adminUsername: String
    let teamImageUrl: String
    let totalPoints: Int
    let totalTasks: Int
    let members: [String]?
    let maxMember: Int
    let assignedQuizzes: [String]?
    let _id: String
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}
