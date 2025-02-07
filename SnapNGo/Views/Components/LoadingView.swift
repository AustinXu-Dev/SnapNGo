//
//  LoadingView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import Foundation
import SwiftUI

func loadingBoxView(message: String) -> some View {
    ZStack {
        // Background blur and dim
        Color.black.opacity(0.3)
            .ignoresSafeArea()
            .blur(radius: 5)

        // Centered loading box
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5) // Larger indicator
            Text(message)
                .foregroundColor(.gray)
                .body1()
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 180, height: 120) // Size of the loading box
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
    .zIndex(1)
}
