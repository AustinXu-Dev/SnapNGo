//
//  CreatedTeamMemberView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/2.
//

import SwiftUI

struct CreatedTeamMemberView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @StateObject var getOneCreatedTeamVM = GetOneCreatedTeamViewModel()
    
    var teamData: CreatedTeam
    @State var teamMembers: [TeamMember] = []
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    LineView()
                    HStack{
                        Image(Constants.TeamViewConstant.participantIcon)
                        Text("^[\(teamData.members.count-1) Team member](inflect: true)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVStack{
                        ForEach(teamMembers, id: \._id) { member in
                            MemberCardView(image: "sample", memberName: member.name, points: member.totalPoints)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, Constants.LayoutPadding.medium)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if getOneCreatedTeamVM.isLoading{
                loadingBoxView(message: "Loading team members...")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .navigationBarBackButtonHidden()
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 45)
        })
        .overlay {
            topOverlayView
        }
        .onAppear(perform: {
            getOneCreatedTeamVM.getOneCreatedTeam(teamId: teamData._id, adminEmail: teamData.adminEmail) { _ in
                teamMembers = getOneCreatedTeamVM.membersData
            }
            print(teamData)
        })
        .refreshable {
            getOneCreatedTeamVM.getOneCreatedTeam(teamId: teamData._id, adminEmail: teamData.adminEmail) { _ in
                teamMembers = getOneCreatedTeamVM.membersData
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
                    AppCoordinator.pop()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text("Team Members")
                    .heading1()
                Spacer()
                Button {
                    print("qr")
                    //MARK: show qr code view
                    AppCoordinator.presentSheet(.joinQRCode(named: teamData._id))
                } label: {
                    Image(systemName: "qrcode")
                }
            }
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
}
