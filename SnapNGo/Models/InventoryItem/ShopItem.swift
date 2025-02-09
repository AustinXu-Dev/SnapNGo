//
//  ShopItem.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import SwiftUI

struct ShopItem: Codable{
    let _id: String
    let name: String
    let category: String
    let imageUrl: String
    let price: Int
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}
