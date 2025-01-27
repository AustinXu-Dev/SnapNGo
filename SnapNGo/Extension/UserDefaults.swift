//
//  UserDefaults.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/25.
//

import Foundation

extension UserDefaults {
    // Get User Id
    func getUserId() -> String? {
       return string(forKey: Constants.UserDefaultsKeys.userId)
    }
}
