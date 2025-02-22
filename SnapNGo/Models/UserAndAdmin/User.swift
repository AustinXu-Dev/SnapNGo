//
//  User.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation

struct User: Codable, Hashable {
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
    let snapTaskQuiz: [SnapTaskQuiz]?
    let gender: String
    let inventory: [InventoryItem]?
    let role: String
    let teamIds: [String]
    let createdAt: Date
    let updatedAt: Date
    let __v: Int
}

struct Tasks: Codable, Hashable {
    let quizId: String
    let status: StatusModel
    let _id: String
    let quizDetails: Quiz
}

struct SnapTaskQuiz: Codable, Hashable {
    let snapQuizId: String
    let status: SnapStatusModel
    let _id: String
    let snapQuizDetails: SnapQuiz
}

struct SnapStatusModel: Codable, Hashable{
    let type: String
    let isFinished: Bool
    let isAnswerCorrect: Bool
    let userAnswerNumber: String?
}


struct StatusModel: Codable, Hashable{
    let type: String
    let isFinished: Bool
    let isAnswerCorrect: Bool
    let userAnswerNumber: Int?
}

struct InventoryItem: Codable, Hashable {
    let itemId: String
    let quantity: Int
    let isEquipped: Bool
    let _id: String
    let itemInfo: ShopItem
}
