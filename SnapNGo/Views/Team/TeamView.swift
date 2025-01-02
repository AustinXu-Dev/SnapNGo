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
    @State private var alertMessage: String = ""
    
    @StateObject private var joinTeamVM = UserJoinTeamViewModel()
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    
    var body: some View {
        ZStack{
            VStack(alignment: .center){
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
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "https://www.google.com", completion: handleScan)
            }
            
            if joinTeamVM.isLoading{
                ProgressView("Joining Team...")
            }
        }
        .onReceive(joinTeamVM.$errorMessage) { errorMessage in
            if let message = errorMessage {
                alertMessage = message
                isShowingAlert = true
            }
        }
        .alert("Error joining team.", isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
    
    func scanQRcode() {
        isShowingScanner = true
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
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
                        AppCoordinator.push(.joinedTeamView)
                    }
                    print("Successfully joined team!")
                }
            }
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    TeamView()
}
