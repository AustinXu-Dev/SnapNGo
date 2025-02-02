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
        HStack {
            Image("sample")
                .resizable()
                .frame(width: 125, height: 125) // Set specific dimensions
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text(team.teamName)
                    .font(.headline)
                    .foregroundColor(.accent)
                Text("\(team.totalTasks) Tasks")
                    .font(.subheadline)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
            .background(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 125)
        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
        .padding(.vertical, 3)
        .onTapGesture {
            action()
        }
    }
}
