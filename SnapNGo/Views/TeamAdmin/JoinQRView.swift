//
//  JoinQRView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/2.
//

import SwiftUI

struct JoinQRView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneAdminVM: GetOneAdminViewModel
    @EnvironmentObject var getCreatedTeamsVM: GetAllCreatedTeamsViewModel
    
    var teamId: String
    
    var body: some View {
        VStack {
            Text("Display qr code")
                .heading1()
            
            CreateQRCodeView(teamId: teamId)
            
            Text("Scan the code above to join the team.")
            
            Button {
                AppCoordinator.popToRoot()
                getCreatedTeamsVM.getAllCreatedTeams(adminEmail: getOneAdminVM.adminEmail)
            } label: {
                Text("Go back")
                    .heading2()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, Constants.LayoutPadding.large)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    JoinQRView(teamId: "https://www.google.com")
}
