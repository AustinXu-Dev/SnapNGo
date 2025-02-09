//
//  PurchaseItemUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

class PurchaseItemUseCase: APIManager{
    typealias ModelType = User
    
    var methodPath: String{
        return "/purchase"
    }
}
