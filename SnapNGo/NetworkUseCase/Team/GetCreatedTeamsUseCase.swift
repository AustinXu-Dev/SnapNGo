//
//  GetCreatedTeamsUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/31.
//

import Foundation

class GetCreatedTeamsUseCase: APIManager{
    typealias ModelType = AdminGetTeamsResponse
    
    var adminEmail: String
    
    init(adminEmail: String) {
        self.adminEmail = adminEmail
    }
    
    var methodPath: String{
        return "/admin/teams?adminEmail=\(adminEmail)"
    }
}
