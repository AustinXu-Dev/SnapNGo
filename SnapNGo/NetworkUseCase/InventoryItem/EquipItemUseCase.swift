//
//  EquipItemUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

class EquipItemUseCase: APIManager{
    typealias ModelType = EquipItemResponse
    
    var methodPath: String{
        return "/item/equip"
    }
}
