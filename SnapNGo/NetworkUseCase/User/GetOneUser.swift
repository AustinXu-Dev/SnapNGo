//
//  GetOneUser.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/3.
//

import Foundation

class GetOneUser: APIManager {
    typealias ModelType = User
    
    var userId: String
    
    init(userId: String){
        self.userId = userId
    }
    var methodPath: String {
        return "/user/\(userId)"
    }
}
