//
//  GetOneAdmin.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/31.
//

import Foundation

class GetOneAdmin: APIManager {
    typealias ModelType = Admin
    
    var adminId: String
    
    init(adminId: String){
        self.adminId = adminId
    }
    var methodPath: String {
        return "/admin/\(adminId)"
    }
}
