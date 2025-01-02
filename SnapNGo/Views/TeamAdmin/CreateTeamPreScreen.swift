//
//  CreateTeamPreScreen.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 17/12/2567 BE.
//

import SwiftUI

struct CreateTeamPreScreen: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl

    var body: some View {
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
        .background(ColorConstants.background)
    }
}

#Preview {
    CreateTeamPreScreen()
}
