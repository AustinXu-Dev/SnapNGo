//
//  CreateTeamPreScreen.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 17/12/2567 BE.
//

import SwiftUI

struct CreateTeamPreScreen: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneAdminVM: GetOneAdminViewModel
    @EnvironmentObject var getCreatedTeamsVM: GetAllCreatedTeamsViewModel

    var body: some View {
        ZStack{
            ScrollView{
                if getOneAdminVM.createdTeamIds.isEmpty{
                    createTeamPreScreen
                } else {
                    teamListView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden()
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 45)
        })
        .overlay {
            topOverlayView
        }
        .background(ColorConstants.background)
        .refreshable {
            guard let adminId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                print("Error here")
                return
            }
            getOneAdminVM.getOneAdmin(adminId: adminId){ _ in
            }
        }
        .onChange(of: getOneAdminVM.createdTeamIds) { oldValue, newValue in
            getCreatedTeamsVM.getAllCreatedTeams(adminEmail: getOneAdminVM.adminEmail)
        }
        
    }
    
    private var createTeamPreScreen: some View{
        VStack(alignment: .center){
            Image(Constants.CreateTeamViewConstant.createTeamPreScreenImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 8)
            Image(Constants.CreateTeamViewConstant.logo)
                .resizable()
                .frame(width: 280, height: 84)
                .aspectRatio(contentMode: .fill)
            Text(Constants.CreateTeamViewConstant.welcomeMessage)
                .heading1()
                .padding(.bottom, 8)
            Text(Constants.CreateTeamViewConstant.description)
                .frame(width: 375)
                .multilineTextAlignment(.center)
                .body1()
                .padding(.bottom, 8)
            Button {
                AppCoordinator.push(.createTeam)
            } label: {
                Text(Constants.CreateTeamViewConstant.createButtonText)
                    .heading2()
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, Constants.LayoutPadding.medium)
    }
    
    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 100)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
            HStack {
                Button {
                    print("hello")
                } label: {
                    Image(systemName: "calendar.badge.plus")
                        .opacity(0)
                }
                Spacer()
                Text(getOneAdminVM.createdTeamIds.isEmpty ? "Create Team" : "Team List")
                    .heading1()
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                if getOneAdminVM.createdTeamIds.isEmpty{
                    Button {
                        print("hello")
                    } label: {
                        Image(systemName: "calendar.badge.plus")
                            .opacity(0)
                    }
                } else {
                    Button {
                        AppCoordinator.push(.createTeam)
                    } label: {
                        Image("create_team_icon")
                        
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var teamListView: some View{
        VStack{
            LineView()
            HStack{
                Image(Constants.TeamViewConstant.participantIcon)
                Text("^[\(getCreatedTeamsVM.teamsData.count) Team](inflect: true)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(getCreatedTeamsVM.teamsData, id: \._id) { team in
                TeamCardView(image: team.teamImageUrl, teamName: team.teamName, membersCount: team.members.count-1){
//                    AppCoordinator.push(.createdTeamMember(named: team))
                    // Team Task View
                    AppCoordinator.push(.teamTaskView(named: team))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, Constants.LayoutPadding.medium)
    }
}

#Preview {
    CreateTeamPreScreen()
}
