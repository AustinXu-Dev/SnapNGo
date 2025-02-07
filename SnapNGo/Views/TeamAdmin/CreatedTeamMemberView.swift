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
                        Text("^[\(teamData.members.count) Team member](inflect: true)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVStack{
                        ForEach(teamMembers, id: \._id) { member in
                            MemberCardView(image: "sample", memberName: member.name, points: member.totalPoints)
                            //                        Text(member)
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
        .onAppear(perform: {
            getOneCreatedTeamVM.getOneCreatedTeam(teamId: teamData._id, adminEmail: teamData.adminEmail) { _ in
                teamMembers = getOneCreatedTeamVM.membersData
            }
        })
        .refreshable {
            getOneCreatedTeamVM.getOneCreatedTeam(teamId: teamData._id, adminEmail: teamData.adminEmail) { _ in
                teamMembers = getOneCreatedTeamVM.membersData
            }
        }
        .navigationTitle(teamData.teamName)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    AppCoordinator.presentSheet(.joinQRCode(named: teamData._id))
                } label: {
                    Image(systemName: "qrcode")
                }

            }
        }
    }
}
