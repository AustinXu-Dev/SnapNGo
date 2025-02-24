//
//  KickTeamUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 24/02/2025.
//

import Foundation

class KickTeamUseCase: APIManager{
    typealias ModelType = AdminKickMemberResponse
    
    var adminEmail: String
    var teamId: String
    var userId: String
    
    init(adminEmail: String, teamId: String, userId: String) {
        self.adminEmail = adminEmail
        self.teamId = teamId
        self.userId = userId
    }
    
    var methodPath: String{
        return "/admin/teams?adminEmail=\(adminEmail)&teamId=\(teamId)&userId=\(userId)"
    }
    
}
