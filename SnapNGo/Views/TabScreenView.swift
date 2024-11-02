//
//  TabScreenView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct TabScreenView: View {
    
    @State var selectedTab: TabViewEnum = .home
    var body: some View {
        TabView(selection: $selectedTab) {
            TeamView()
                .tabItem {
                    Label("", image: selectedTab == .team ? "team-icon-click" : "team-icon")
                }
                .tag(TabViewEnum.team)
            HomeView()
                .tabItem {
                    Label("", image: selectedTab == .home ? "home-icon-click" : "home-icon")
                }
                .tag(TabViewEnum.home)
            TasksView()
                .tabItem {
                    Label("", image: selectedTab == .task ? "tasks-icon-click" : "tasks-icon")
                }
                .tag(TabViewEnum.task)
            ProfileView()
                .tabItem {
                    Label("", image: selectedTab == .profile ? "profile-icon-click" : "profile-icon")
                }
                .tag(TabViewEnum.profile)
            
        }
    }
}

#Preview {
    TabScreenView()
}
