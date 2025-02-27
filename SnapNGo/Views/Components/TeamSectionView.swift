//
//  TeamSectionView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/1.
//

import SwiftUI

struct TeamSectionView: View {
    
    var team: CreatedTeam
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .center){
            Image(team.teamImageUrl.isEmpty ? "team_image_1" : team.teamImageUrl)
                .resizable()
                .frame(maxWidth: 64, maxHeight: 64) 
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.all, 5)
            VStack(alignment: .leading) {
                Text(team.teamName)
                    .font(.headline)
                    .foregroundColor(.accent)
                Text("\(team.totalTasks) Tasks")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            Circle()
                .frame(width: 30, height: 30)
                .overlay {
                    Image("members_icon")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaledToFit()
                }
                .foregroundStyle(.clear)
                .padding(.trailing, 8)

        }
        .frame(maxWidth: .infinity, maxHeight: 72)
        .background(RoundedRectangle(cornerRadius: 5).fill(.white))
        .onTapGesture {
            action()
        }
    }
}
