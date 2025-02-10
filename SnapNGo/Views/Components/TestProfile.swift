//
//  TestProfile.swift
//  SnapNGo
//
//  Created by Austin Xu on 11/02/2025.
//

import SwiftUI

struct TestProfile: View {
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .foregroundStyle(.shopCardBackground)
                Image("boy_hat")
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity, maxHeight: 220)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.background)
    }
}

#Preview {
    TestProfile()
}
