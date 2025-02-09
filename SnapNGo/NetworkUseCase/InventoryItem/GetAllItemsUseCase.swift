//
//  GetAllItemsUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

class GetAllItemsUseCase: APIManager{
    typealias ModelType = [ShopItem]
    
    var methodPath: String{
        return "/item"
    }
}
