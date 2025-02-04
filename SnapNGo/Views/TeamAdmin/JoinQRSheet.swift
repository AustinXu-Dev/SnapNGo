//
//  JoinQRSheet.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/4.
//

import SwiftUI

struct JoinQRSheet: View {
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
                AppCoordinator.dismissSheet()
            } label: {
                Text("Go back")
                    .heading2()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, Constants.LayoutPadding.large)
        }
    }
}
