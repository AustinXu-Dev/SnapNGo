//
//  UnequipItemByIdDTO.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

struct UnequipItemByIdDTO: Codable{
    let userId: String
    let itemIds: [String]
}
