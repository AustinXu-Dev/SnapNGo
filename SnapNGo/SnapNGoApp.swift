//
//  SnapNGoApp.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/10/21.
//

import SwiftUI

@main
struct SnapNGoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
//            SnapQuizView()
//            CreateTeamView()
        }
    }
}
