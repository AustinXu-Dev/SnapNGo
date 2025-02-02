//
//  CreatedTeamMemberView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/2.
//

import SwiftUI

struct CreatedTeamMemberView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl

    var teamData: CreatedTeam
    
    var body: some View {
        ScrollView{
            VStack{
                LineView()
                HStack{
                    Image(Constants.TeamViewConstant.participantIcon)
                    Text("^[\(teamData.members.count) Team member](inflect: true)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVStack{
                    ForEach(teamData.members, id: \.self) { member in
//                        MemberCardView(image: "sample", memberName: member.name, points: member.totalPoints)
                        Text(member)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Constants.LayoutPadding.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(teamData.teamName)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    AppCoordinator.push(.joinQRCode(named: teamData._id))
                } label: {
                    Image(systemName: "qrcode")
                }

            }
        }
    }
}
