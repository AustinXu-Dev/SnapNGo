//
//  UnequipItemByIdUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

class UnequipItemByIdUseCase: APIManager{
    typealias ModelType = UnequipItemsResponse
    
    var methodPath: String{
        return "/unequip"
    }
}
