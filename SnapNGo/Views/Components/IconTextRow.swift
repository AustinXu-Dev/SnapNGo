//
//  IconTextRow.swift
//  SnapNGo
//
//  Created by Austin Xu on 26/02/2025.
//

import SwiftUI

struct IconTextRow: View {
    
    var icon: String
    var text: String
    var textColor: Color
    var IconColor: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack{
                Image(icon)
                    .padding(.horizontal, Constants.LayoutPadding.xsmall)
                Text(text)
                    .body1()
                    .foregroundStyle(textColor)
                Spacer()
                Image(systemName: "chevron.right")
                    .fontWeight(.semibold)
                    .foregroundStyle(IconColor)
                    .padding(.horizontal, Constants.LayoutPadding.xsmall)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 30)
        }
        .buttonStyle(.borderedProminent)
        .tint(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8) // Matches button shape
                .stroke(Color.accentColor, lineWidth: 0.5) // Blue border
        )
    }
}

