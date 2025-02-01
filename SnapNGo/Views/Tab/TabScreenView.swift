//
//  TabScreenView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct TabScreenView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @State var selectedTab: TabViewEnum = .home
    
    var body: some View {
        ZStack {
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
                    .tag(TabViewEnum.adminHome)
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
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
            }
            .task {
                guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                    print("Error here")
                    return
                }
                if getOneUserVM.userData == nil {
                    getOneUserVM.getOneUser(userId: userId)
                }
            }            
            if getOneUserVM.isLoading {
                loadingBoxView(message: "loading")
            }
        }
    }
    
    private var loadingOverlay: some View {
        ZStack {
            Color.black.opacity(0.4) // Semi-transparent background
                .edgesIgnoringSafeArea(.all)
            ProgressView("Loading...")
                .padding(20)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    TabScreenView()
}

