//
//  User.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation

struct User: Codable {
    let _id: String
    let name: String
    let email: String
    let password: String
    let profileImageUrl: String
    let dob: Date?
    let school: String
    let address: String
    let totalPoints: Int
    let totalTasks: Int
    let tasks: [Tasks]
    let completedTasks: [Tasks]
    let inventory: [InventoryItem]? // Marked as optional
    let role: String
    let createdAt: String
    let updatedAt: String
}

struct Tasks: Codable {
    let id: String
    let title: String
    let description: String
    let completed: Bool
    let dueDate: Date?
}

struct InventoryItem: Codable {
    let id: String
    let name: String
    let description: String
    let quantity: Int
}
