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
    let adminId: String
    let adminEmail: String
    let teamImageUrl: String
    let totalTasks: Int
    let members: [OneMemberModel]?
    let maxMember: Int
    let assignedQuizzes: [String]?
}

struct OneMemberModel: Codable{
    let _id: String
    let name: String
    let email: String
    let profileImageUrl: String
    let role: String
    let totalPoints: Int
    let teamIds: [String]?
}
