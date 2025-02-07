//
//  ProfileView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue
    @ObservedObject var googleVM = GoogleAuthViewModel()
    @State var showAlert: Bool = false

    var body: some View {
        
        ZStack{
            ScrollView{
                VStack{
                    Circle()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                    
                    VStack(alignment: .leading) {
                        Text(getOneUserVM.userData?.name ?? "John Doe")
                            .heading1()
                        Text(getOneUserVM.teamId ?? "")
                            .body1()
                            .foregroundStyle(.accent)
                        HStack{
                            Image("profile_email_icon")
                            Text(getOneUserVM.userData?.school ?? "Assumption University of Thailand")
                                .body1()
                        }
                        HStack{
                            Image("tabler_school")
                            Text(getOneUserVM.userData?.email ?? "uXXXXXX@au.edu")
                                .body1()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LineView()
                    
                    Button {
                        showAlert = true
                    } label: {
                        Text("sign out")
                    }
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
        .alert("Are you sure you want to sign out?", isPresented: $showAlert) {
            Button("Cancel", role: .destructive) {}
            Button("Ok", role: .cancel) {
                googleVM.signOutWithGoogle()
                
                // Delete username and userId fro UserDefaults
                UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.username)
                UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.userId)
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
                Button {
                    print("hello")
                } label: {
                    Image(systemName: "calendar.badge.plus")
                        .opacity(0)
                }
                Spacer()
                Text("Profile")
                    .heading1()
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                Button {
                    //MARK: Navigate to shop
                    
                } label: {
                    Image("basket_icon")
                }
            }
            .frame(maxWidth: .infinity)
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ProfileView()
}
