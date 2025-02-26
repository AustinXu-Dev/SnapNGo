//
//  AdminProfileView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/4.
//

import SwiftUI

struct AdminProfileView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var taskSectionVM: TaskSectionViewModel
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @EnvironmentObject var getOneTeamVM: GetOneTeamViewModel
    @EnvironmentObject var getOneAdminVM: GetOneAdminViewModel
    @EnvironmentObject var getCreatedTeamsVM: GetAllCreatedTeamsViewModel
    
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue
    @ObservedObject var googleVM = GoogleAuthViewModel()
    
    @State var showAlert: Bool = false
    @State private var showAll = false
    

    var body: some View {
        
        ZStack{
            ScrollView{
                VStack{
                    profilePic
                    
                    LineView()
                    
                    profileDetail
                    
                    Button {
                        showAlert = true
                    } label: {
                        HStack{
                            Text("Log out")
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                        }
                        .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, Constants.LayoutPadding.large)
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, Constants.LayoutPadding.medium)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 45)
        })
        .overlay {
            topOverlayView
        }
        .refreshable {
            adminDataApiCall()
        }
        .alert("Are you sure you want to sign out?", isPresented: $showAlert) {
            Button("Cancel", role: .destructive) {}
            Button("Ok", role: .cancel) {
                // MARK: - Sign out Action
                googleVM.signOutWithGoogle()
                
                // Delete username and userId fro UserDefaults
                UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.username)
                UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.userId)
                
                taskSectionVM.reset()
                getOneUserVM.reset()
                getOneTeamVM.reset()
                getOneAdminVM.reset()
                getCreatedTeamsVM.reset()
                
                AppCoordinator.selectedTabIndex = .home
            }
        }

    }
    
    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 100)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
            HStack{
                Spacer()
                Text("Profile")
                    .heading1()
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var profilePic: some View{
        VStack{
            ZStack{
                Circle()
                    .foregroundStyle(.shopCardBackground)
                Image("male")
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity, maxHeight: 220)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
    }
    
    private var profileDetail: some View{
        VStack(alignment: .leading) {
            Text(getOneAdminVM.adminData?.name ?? "John Doe")
                .heading1()
            HStack{
                Image("tabler_school")
                Text(getOneAdminVM.adminData?.school ?? "Assumption University of Thailand")
                    .body1()
            }
            HStack{
                Image("profile_email_icon")
                Text(getOneAdminVM.adminData?.email ?? "uXXXXXX@au.edu")
                    .body1()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    private func adminDataApiCall(){
        guard let adminId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
            print("Error here")
            return
        }
        getOneAdminVM.getOneAdmin(adminId: adminId) { _ in
            
        }
    }
    
}

#Preview {
    ProfileView()
}
