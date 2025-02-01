//
//  AdminTabScreenView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import SwiftUI

struct AdminTabScreenView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneAdminVM: GetOneAdminViewModel
    @EnvironmentObject var getCreatedTeamsVM: GetAllCreatedTeamsViewModel
    
    @State var selectedTab: TabViewEnum = .adminHome
    
    var body: some View {
        ZStack{
            TabView(selection: $selectedTab) {
                CreateTeamPreScreen()
                    .tabItem {
                        Label("", image: selectedTab == .team ? "team-icon-click" : "team-icon")
                    }
                    .tag(TabViewEnum.team)
                AdminHomeView()
                    .tabItem {
                        Label("", image: selectedTab == .adminHome ? "home-icon-click" : "home-icon")
                    }
                    .tag(TabViewEnum.adminHome)
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
                guard let adminId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                    print("Error here")
                    return
                }
                if getOneAdminVM.adminData == nil {
                    getOneAdminVM.getOneAdmin(adminId: adminId){ _ in
                        getCreatedTeamsVM.getAllCreatedTeams(adminEmail: getOneAdminVM.adminEmail)
                    }
                }
            }
            if getOneAdminVM.isLoading {
                loadingBoxView(message: "loading")
            }
            if getCreatedTeamsVM.isLoading{
                loadingBoxView(message: "loading teams")
            }
        }
    }
}

#Preview {
    AdminTabScreenView()
}
