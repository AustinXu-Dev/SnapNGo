//
//  Test.swift
//  SnapNGo
//
//  Created by Austin Xu on 27/02/2025.
//

import SwiftUI

struct Test: View {
    var body: some View {
        ZStack{
            Circle()
                .foregroundStyle(.shopCardBackground)
            Image("male")
                .resizable()
                .scaledToFit()
                
            Button {
                //
            } label: {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.accent)
                    .overlay {
                        Image("profile_edit_icon")
                    }
            }
            .offset(x: 75,y: 80)
        }
        .frame(maxWidth: .infinity, maxHeight: 220)
    }
}

#Preview {
    Test()
}
