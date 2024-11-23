//
//  SignUpResponse.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation

struct SignUpResponse: Codable{
    let messsage: String
    let token: String
    let user: SignUpUser
}

struct SignUpUser: Codable{
    let id: String
    let name: String
    let email: String
    let dob: String?
    let school: String
    let address: String
    let totalPoints: Int
    let totalTasks: Int
    let tasks: [String]
    let completedTasks: [String]
    let inventory: [String]
    let role: String
}
