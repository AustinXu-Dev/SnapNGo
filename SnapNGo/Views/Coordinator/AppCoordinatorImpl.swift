//
//  AppCoordinatorImpl.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import Foundation
import SwiftUI

class AppCoordinatorImpl: AppCoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
//    @Published var sheet: Sheet?
//    @Published var fullScreenCover: FullScreenCover?
    
    // MARK: - Navigation Functions
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
//    func presentSheet(_ sheet: Sheet) {
//        self.sheet = sheet
//    }
    
//    func presentFullScreenCover(_ fullScreenCover: FullScreenCover) {
//        self.fullScreenCover = fullScreenCover
//    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
//    func dismissSheet() {
//        self.sheet = nil
//    }
//    
//    func dismissFullScreenOver() {
//        self.fullScreenCover = nil
//    }
    
    // MARK: - Presentation Style Providers
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .signIn:
            SignInView()
        case .signUp:
            SignUpView()
        case .tab:
            TabScreenView(selectedTab: .home)
        case .adminTab:
            AdminTabScreenView(selectedTab: .adminHome)
        case .tasks:
            ContentView()
        case .quizDetail(taskId: let taskId, questionNo: let questionNo, named: let quizData, status: let statusData):
            QuizDetailView(taskId: taskId, questionNo: questionNo, quizData: quizData, statusData: statusData)
        case .historyDetail(named: let historyData):
            HistoryDetailView(historyData: historyData)
        case .chapelDetail(named: let chapelData):
            ChapelView(chapelData: chapelData)
        case .campusDetail(named: let campusData):
            CampusDetailView(campusData: campusData)
        case .facultyDetail(named: let facultyData):
            FacultyDetailView(facultyData: facultyData)
        case .teamMembers:
            ContentView()
        case .mapView:
            MapDetailView()
        case .createTeam:
            CreateTeamView()
        case .createdTeamMember(named: let createdTeamData):
            CreatedTeamMemberView(teamData: createdTeamData)
        case .joinQRCode(named: let link):
            JoinQRView(link: link)
        case .joinedTeamView:
            TeamMemberView()
        }
    }
    
//    @ViewBuilder
//    func build(_ sheet: Sheet) -> some View {
//        switch sheet {
//        case .detailTask(named: let task):
//            DetailTaskView(task: task)
//        }
//    }
//    
//    @ViewBuilder
//    func build(_ fullScreenCover: FullScreenCover) -> some View {
//        switch fullScreenCover {
//        case .addHabit(onSaveButtonTap: let onSaveButtonTap):
//            AddHabitView(onSaveButtonTap: onSaveButtonTap)
//        }
//    }
}
