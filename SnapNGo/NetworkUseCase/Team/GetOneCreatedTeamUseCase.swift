//
//  GetOneCreatedTeamUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/5.
//

import Foundation

class GetOneCreatedTeamUseCase: APIManager{
    typealias ModelType = AdminGetOneTeamResponse
    
    var teamId: String
    var email: String

    init(teamId: String, email: String) {
        self.teamId = teamId
        self.email = email
    }
    
    var methodPath: String{
        return "/admin/teams/\(teamId)?adminEmail=\(email)"
    }
}
