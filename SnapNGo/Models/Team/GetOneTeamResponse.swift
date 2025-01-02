//
//  GetOneTeamResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/3.
//

import Foundation

struct GetOneTeamResponse: Codable{
    let message: String
    let team: OneTeamModel
}

struct OneTeamModel: Codable{
    let _id: String
    let teamName: String
    let adminUsername: String
    let teamImageUrl: String
    let totalPoints: Int
    let totalTasks: Int
    let members: [OneMemberModel]?
    let maxMember: Int
    let assignedQuizzes: [QuizGroup]?
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}

struct OneMemberModel: Codable{
    let _id: String
    let name: String
    let profileImageUrl: String
    let totalPoints: Int
}
