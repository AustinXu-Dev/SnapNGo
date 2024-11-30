//
//  SignInResponse.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation

struct SignInResponse: Codable{
    let message: String
    let token: String
    let user: SignInUser
}

struct SignInUser: Codable{
    let id: String
    let name: String
    let email: String
    let school: String
    let role: String
}
