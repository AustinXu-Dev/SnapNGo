//
//  UpdateUser.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

class UpdateUser: APIManager{
    typealias ModelType = User
    
    var userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    var methodPath: String{
        return "/user/\(userId)"
    }
}
