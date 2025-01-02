//
//  AdminTabScreenView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import SwiftUI

struct AdminTabScreenView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @State var selectedTab: TabViewEnum = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CreateTeamPreScreen()
                .tabItem {
                    Label("", image: selectedTab == .team ? "team-icon-click" : "team-icon")
                }
                .tag(TabViewEnum.team)
            HomeView()
                .tabItem {
                    Label("", image: selectedTab == .home ? "home-icon-click" : "home-icon")
                }
                .tag(TabViewEnum.home)
            ProfileView()
                .tabItem {
                    Label("", image: selectedTab == .profile ? "profile-icon-click" : "profile-icon")
                }
                .tag(TabViewEnum.profile)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }

    }
}

#Preview {
    AdminTabScreenView()
}
