//
//  CreateTeamUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/12/17.
//

import Foundation

class CreateTeamUseCase: APIManager{
    typealias ModelType = TeamResponse
    var methodPath: String{
        return "/team"
    }
}
