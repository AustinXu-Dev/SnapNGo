//
//  TeamView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct TeamView: View {
    
    var body: some View {
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
    }
    
    func scanQRcode() {
        print("hello")
    }
}

#Preview {
    TeamView()
}
