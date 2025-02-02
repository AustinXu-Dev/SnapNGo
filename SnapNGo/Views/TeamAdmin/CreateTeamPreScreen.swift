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
                    ForEach(getCreatedTeamsVM.teamsData, id: \._id) { team in
                        TeamSectionView(team: team){
                            AppCoordinator.push(.createdTeamMember(named: team))
                        }
                        .padding(.horizontal, Constants.LayoutPadding.medium)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 45)
        })
        .overlay {
            topOverlayView
        }
        .background(ColorConstants.background)
        .refreshable {
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
                .frame(width: 380)
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
                Text("Created Team")
                    .heading1()
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                Button {
                    AppCoordinator.push(.createTeam)
                } label: {
                    Image(systemName: "calendar.badge.plus")
                }
            }
            .frame(maxWidth: .infinity)
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    CreateTeamPreScreen()
}
