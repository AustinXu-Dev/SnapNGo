//
//  GetItemByIdUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

class GetItemByIdUseCase: APIManager{
    typealias ModelType = ShopItem
    
    var itemId: String
    
    init(itemId: String) {
        self.itemId = itemId
    }
    
    var methodPath: String{
        return "/item/\(itemId)"
    }
}
