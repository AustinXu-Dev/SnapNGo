//
//  GetAllTeamsUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/3.
//

import Foundation

class GetAllTeamsUseCase: APIManager{
    typealias ModelType = GetAllTeamsResponse
    
    var methodPath: String{
        return "/team"
    }
}
