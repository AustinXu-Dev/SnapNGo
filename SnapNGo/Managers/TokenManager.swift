//
//  TokenManager.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation

class TokenManager: ObservableObject {
    
    static let share = TokenManager()
    
    private init(){}
    
    // MARK: - Save Tokens in keychain
    func saveTokens(token: String) {
        KeychainManager.shared.keychain.set(token, forKey: "userToken")
    }
    
    // MARK: - Get Tokens for headers and API calls
    func getToken() -> String? {
        return KeychainManager.shared.keychain.get("userToken")
    }
    
    // MARK: - Delete Tokens
    func deleteToken() {
        KeychainManager.shared.keychain.delete("userToken")
    }
}
