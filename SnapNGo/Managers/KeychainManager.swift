//
//  KeychainManager.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation
import KeychainSwift

class KeychainManager {
    
    static let shared = KeychainManager()
    
    let keychain = KeychainSwift()
    
    private init() {}
}
