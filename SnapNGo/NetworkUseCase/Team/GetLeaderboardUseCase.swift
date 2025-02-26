//
//  GetLeaderboardUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 27/02/2025.
//

import Foundation

class GetLeaderboardUseCase: APIManager {
    typealias ModelType = LeaderboardResponse
    
    var teamId: String
    
    init(teamId: String) {
        self.teamId = teamId
    }
    
    var methodPath: String{
        return "/leaderboard/\(teamId)"
    }
}
