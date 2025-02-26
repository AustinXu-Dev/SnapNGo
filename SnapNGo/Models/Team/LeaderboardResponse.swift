//
//  LeaderboardResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 27/02/2025.
//

import Foundation

struct LeaderboardResponse: Codable{
    let message: String
    let leaderboard: Leaderboard
}

struct Leaderboard: Codable{
    let teamName: String
    let members: [LeaderboardMember]
}

struct LeaderboardMember: Codable, Hashable{
    let name: String
    let teamPoints: Int
}
