//
//  TeamResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/12/17.
//

import Foundation

struct TeamResponse: Codable{
    let message: String
    let teams: [TeamModel]
}

struct TeamModel: Codable{
    let _id: String
    let teamName: String
    let adminUsername: String
    let teamImageUrl: String
    let totalTasks: Int
    let members: [String]?
    let maxMember: Int
    let createdAt: String
    let updatedAt: String
    let __v: Int
}
