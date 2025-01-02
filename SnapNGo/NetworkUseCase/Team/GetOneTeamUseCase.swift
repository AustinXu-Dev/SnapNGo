//
//  GetOneTeamUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/3.
//

import Foundation

class GetOneTeamUseCase: APIManager{
    typealias ModelType = GetOneTeamResponse
    
    var teamId: String
    
    init(teamId: String) {
        self.teamId = teamId
    }
    
    var methodPath: String{
        return "/team/\(teamId)"
    }
}
