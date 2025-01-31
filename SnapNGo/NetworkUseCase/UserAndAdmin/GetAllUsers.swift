//
//  GetAllUsers.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation

class GetAllUsers: APIManager {
    typealias ModelType = [User]
    
    var methodPath: String {
        return "/user"
    }
}
