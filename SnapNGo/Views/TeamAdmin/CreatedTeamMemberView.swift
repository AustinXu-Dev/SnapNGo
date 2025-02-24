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
    @StateObject var kickMemberVM = AdminKickMemberViewModel()
    
    var teamData: CreatedTeam
    @State var teamMembers: [TeamMember] = []
    @State var showKickMemberAlert: Bool = false
    @State private var showSuccessAlert: Bool = false
    @State private var memberImages: [String: String] = [:]
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    LineView()
                    HStack{
                        Image(Constants.TeamViewConstant.participantIcon)
                        Text("^[\(teamMembers.count) Team member](inflect: true)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVStack{
                        ForEach(teamMembers, id: \._id) { member in
                            let image = memberImages[member._id] ?? "member_1"

                            MemberCardView(image: image, memberName: member.name, points: member.totalPoints)
                                .onTapGesture {
                                    showKickMemberAlert = true
                                }
                                .alert("Are you sure you want to kick \(member.name) from this team? (This action cannot be undone)?", isPresented: $showKickMemberAlert){
                                    Button("Cancel", role: .destructive) {}
                                    Button("Ok", role: .cancel) {
                                        kickMemberVM.kickMember(adminEmail: teamData.adminEmail, teamId: teamData._id, userId: member._id) { sucess in
                                                showSuccessAlert = true
                                        }
                                    }
                                }
                                .alert("Member has been successfully removed!", isPresented: $showSuccessAlert) {
                                    Button("OK", role: .cancel) {
                                        getOneCreatedTeamVM.getOneCreatedTeam(teamId: teamData._id, adminEmail: teamData.adminEmail) { _ in
                                            teamMembers = getOneCreatedTeamVM.membersData
                                        }
                                    }
                                }
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
            if kickMemberVM.isLoading{
                loadingBoxView(message: "Kicking member")
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
                for member in teamMembers {
                    if memberImages[member._id] == nil {
                        memberImages[member._id] = MemberData.memberImages.randomElement() ?? "member_1"
                    }
                }
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
