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
    case signUp
    case tab
    case adminTab
    case teamMembers
    case historyDetail(named: HistoryData)
    case chapelDetail(named: HistoryData)
    case campusDetail(named: HistoryData)
    case facultyDetail(named: FacultyData)
    case tasks
    case quizDetail(taskId: String, questionNo: Int, named: Quiz, status: StatusModel)
    case snapQuizDetail(named: SnapQuiz, questionNo: Int, taskId: String, hint: String)
    case mapView
    case createTeam
    case createdTeamMember(named: CreatedTeam)
    case joinQRCode(named: String)
    case joinedTeamView
    case editProfile(named: User)
    case editProfilePic(named: String)
    case shopView(userId: String, userPoints: Int)
    case teamTaskView(named: CreatedTeam)
    case adminQuizDetail(named: Quiz, questionNo: Int)
    case adminSnapQuizDetail(named: SnapQuiz, questionNo: Int, hint: String)
    
    var id: Self { return self }
}

enum Sheet: Identifiable, Hashable {
    
    case joinQRCode(named: String)
    var id: Self { return self }
    
}

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
