//
//  PurchaseItemResponse.swift
//  SnapNGo
//
//  Created by Austin Xu on 16/02/2025.
//

import Foundation

struct PurchaseItemResponse: Codable{
    let _id: String
    let name: String
    let email: String
    let password: String
    let profileImageUrl: String
    let dob: Date?
    let school: String
    let address: String
    let teamPoints: Int
    let totalPoints: Int
    let totalTasks: Int
    let tasks: [Tasks]?
    let gender: String
    let inventory: [PurchasedItemInventory]?
    let role: String
    let teamIds: [String]
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}

struct PurchasedItemInventory: Codable{
    let itemId: String
    let quantity: Int
    let isEquipped: Bool
    let _id: String
}
