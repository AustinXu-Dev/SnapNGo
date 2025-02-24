//
//  TeamView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI
import CodeScanner

struct TeamView: View {
    
    @State private var isShowingScanner = false
    @State private var isShowingAlert = false
    @State private var isLeavingTeam = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showErrorAlert = false
    @State private var lastFetch: Date?
    
    @StateObject private var joinTeamVM = UserJoinTeamViewModel()
    @StateObject private var leaveTeamVM = LeaveTeamViewModel()
    @EnvironmentObject var getOneTeamVM: GetOneTeamViewModel
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    
    var body: some View {
        ZStack{
            ScrollView{
                if getOneTeamVM.isSuccess{
                    membersView
                } else {
                    scanView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Loading View
            if joinTeamVM.isLoading {
                loadingBoxView(message: "Joining Team...")
            }
            
            if getOneTeamVM.isLoading {
                loadingBoxView(message: "Loading Team...")
            }
            
            if leaveTeamVM.isLoading{
                loadingBoxView(message: "Leaving Team...")
            }
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
        .onAppear{
            if let lastFetch = lastFetch, Date().timeIntervalSince(lastFetch) < 300{
                print("using cache data")
            } else {
                lastFetch = Date()
                if let teamId = getOneUserVM.teamId{
                    getOneTeamVM.getOneTeam(teamId: teamId) {_ in
                        
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "https://www.google.com", completion: handleScan)
        }
        .onReceive(joinTeamVM.$errorMessage) { errorMessage in
            if let message = errorMessage {
                alertMessage = message
                alertTitle = "Error joining team."
                isShowingAlert = true
            }
        }
        .onReceive(leaveTeamVM.$isSuccess, perform: { success in
            if success ?? false{
                getOneTeamVM.isSuccess = false
                getOneUserVM.teamId = nil
            }
        })
        .alert(alertTitle, isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        .alert(alertTitle, isPresented: $isLeavingTeam) {
            Button("Cancel", role: .cancel) {}
            Button("Leave", role: .destructive) {
                leaveTeamVM.leaveTeam(userId: getOneUserVM.userId, teamId: getOneTeamVM.teamId)
            }
        } message: {
            Text(alertMessage)
        }

        
        .refreshable {
            guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                print("Error here")
                return
            }
            if let teamId = getOneUserVM.teamId{
                getOneTeamVM.getOneTeam(teamId: teamId) { _ in }
            } else {
                getOneUserVM.getOneUser(userId: userId)
            }
        }
    }
    
    private func scanQRcode() {
        isShowingScanner = true
    }
    
    //MARK: - Scan Action
    private func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            guard let url = URL(string: result.string),
                  let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                  let teamId = components.queryItems?.first(where: { $0.name == "teamId" })?.value else {
                print("Invalid URL or teamId not found: \(result.string)")
                return
            }
            
            print("Scanned teamId: \(teamId)")
            guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                print("No user id found")
                return
            }
            
            joinTeamVM.joinTeam(teamId: teamId, userId: userId) { error in
                if let error = error {
                    print("Error joining team: \(error.localizedDescription)")
                } else {
                    if joinTeamVM.joinTeamSuccess{ 
                        let teamId = joinTeamVM.teamId
                        getOneTeamVM.getOneTeam(teamId: teamId) { _ in }
                        
                        // Refresh the background user state
                        // User will be updated with new team data & tasks
                        getOneUserVM.getOneUser(userId: userId)
                    }
                    print("Successfully joined team!")
                    
                }
            }
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Components
    private var scanView: some View{
        VStack(alignment: .center){
            Spacer()
                .frame(height: 40)
            Image(Constants.TeamViewConstant.teamHomeImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 8)
            Text(Constants.TeamViewConstant.welcomeMessage)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
                .frame(maxWidth: 300)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Text(Constants.TeamViewConstant.description)
                .frame(width: 280)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .fontWeight(.light)
                .padding(.bottom, 8)
            Button(action: scanQRcode) {
                Text(Constants.TeamViewConstant.joinButtonText)
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
    }
    
    private var membersView: some View{
        VStack{
            LineView()
            HStack{
                Image(Constants.TeamViewConstant.participantIcon)
                Text("^[\(getOneTeamVM.members.count) Team member](inflect: true)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVStack{
                ForEach(getOneTeamVM.members, id: \._id) { member in
                    let randomImage = MemberData.memberImages.randomElement() ?? "member_1"
                    
                    MemberCardView(image: randomImage, memberName: member.name, points: member.totalPoints)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Constants.LayoutPadding.medium)
        .onChange(of: getOneTeamVM.errorMessage) { _, error in
            // Show an error alert when errorMessage changes
            if error != nil {
                showErrorAlert = true
            }
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Error"),
                message: Text(getOneTeamVM.errorMessage ?? "Unknown error"),
                dismissButton: .default(Text("Retry")) {
                    // Retry fetching data on dismiss
                    guard let teamId = getOneUserVM.userData?.teamIds.first else { return }
                    getOneTeamVM.getOneTeam(teamId: teamId) { _ in }
                }
            )
        }
        
    }
    
    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 100)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
            HStack{
                if getOneTeamVM.isSuccess{
                    Button {
                        print("hello")
                    } label: {
                        Image(systemName: "calendar.badge.plus")
                            .opacity(0)
                    }
                    Spacer()
                    Text(getOneTeamVM.isSuccess ? getOneTeamVM.teamName : "Team")
                        .heading1()
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    Button {
                        isLeavingTeam = true
                        alertTitle = "Leave Team Warning"
                        alertMessage = "Are you sure you want to leave the team?"
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                    }
                } else {
                    Spacer()
                    Text(getOneTeamVM.isSuccess ? getOneTeamVM.teamName : "Team")
                        .heading1()
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                }
                
            }
            .frame(maxWidth: .infinity)
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    TeamView()
}
