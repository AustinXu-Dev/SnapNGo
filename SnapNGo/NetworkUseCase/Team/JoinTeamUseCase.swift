//
//  JoinTeamUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

class JoinTeamUseCase: APIManager{
    typealias ModelType = JoinTeamResponse
    
    var teamId: String
    
    init(teamId: String){
        self.teamId = teamId
    }
    
    var methodPath: String{
        return "/team/join?teamId=\(teamId)"
    }
}
