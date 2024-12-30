//
//  JoinTeamUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

class JoinTeamUseCase: APIManager{
    typealias ModelType = TeamResponse
    
    var teamId: String
    
    init(teamId: String){
        self.teamId = teamId
    }
    
    var methodPath: String{
        return "/join?teamId=\(teamId)"
    }
}
