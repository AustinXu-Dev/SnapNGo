//
//  GetAllAdmins.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/31.
//

import Foundation

class GetAllAdmins: APIManager {
    typealias ModelType = [Admin]
    
    var methodPath: String {
        return "/admin"
    }
}
