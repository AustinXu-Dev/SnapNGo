//
//  UnequipItemsUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

class UnequipItemsUseCase: APIManager{
    typealias ModelType = UnequipItemsResponse
    
    var methodPath: String{
        return "/unequip"
    }
}
