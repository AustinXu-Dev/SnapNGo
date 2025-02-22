//
//  Admin.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/31.
//

import Foundation

struct Admin: Codable, Hashable{
    let _id: String
    let name: String
    let email: String
    let school: String
    let profileImageUrl: String
    let dob: Date?
    let address: String
    let gender: String
    let teamPoints: Int
    let totalPoints: Int
    let totalTasks: Int
    let tasks: [Tasks]?
    let snapTaskQuiz: [SnapTaskQuiz]?
    let inventory: [InventoryItem]?
    let role: String
    let teamIds: [String]
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}
