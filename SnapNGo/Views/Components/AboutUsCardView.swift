//
//  AboutUsCardView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 3/11/2567 BE.
//

import Foundation
import SwiftUI

struct AboutUsCardView: View {
    var image: String
    var title: String
    var description: String

    var body: some View {
        VStack(alignment: .center) {
            Image(image) // Replace with AsyncImage if loading from a URL
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .cornerRadius(8)
            
            Text(title)
                .heading2()
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
            Text(description)
                .body2()
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.top, Constants.LayoutPadding.small)

        }
        .frame(width: 160, height: 250)
        .padding(Constants.LayoutPadding.small)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 3, x: 0, y:4)
    }
}
