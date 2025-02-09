//
//  UnequipItemsResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

struct UnequipItemsResponse: Codable{
    let message: String
    let EquipItems: [String]?
}
