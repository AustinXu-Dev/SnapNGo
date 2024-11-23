//
//  CoordinatorEnum.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import Foundation
import SwiftUI

enum Screen: Identifiable, Hashable {
    case signIn
    case tab
    case teamMembers
    case historyDetail
    case chapelDetail
    case campusDetail
    case facultyDetail
    case tasks
    
    var id: Self { return self }
}

//enum Sheet: Identifiable, Hashable {
//    
//    var id: Self { return self }
//}

//enum FullScreenCover: Identifiable, Hashable {
//    case addHabit(onSaveButtonTap: ((Habit) -> Void))
//
//    var id: Self { return self }
//}
//
//extension FullScreenCover {
//    // Conform to Hashable
//    func hash(into hasher: inout Hasher) {
//        switch self {
//        case .addHabit:
//            hasher.combine("addHabit")
//        }
//    }
//    
//    // Conform to Equatable
//    static func == (lhs: FullScreenCover, rhs: FullScreenCover) -> Bool {
//        switch (lhs, rhs) {
//        case (.addHabit, .addHabit):
//            return true
//        }
//    }
//}
