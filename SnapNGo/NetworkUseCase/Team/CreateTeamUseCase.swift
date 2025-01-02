//
//  CreateTeamUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/12/17.
//

import Foundation

class CreateTeamUseCase: APIManager{
    typealias ModelType = CreateTeamResponse
    var methodPath: String{
        return "/team"
    }
}
