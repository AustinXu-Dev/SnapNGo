//
//  LeaveTeamUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/6.
//

import Foundation

class LeaveTeamUseCase: APIManager{
    typealias ModelType = LeaveTeamResponse
    
    var methodPath: String{
        return "/team/leave"
    }
}
