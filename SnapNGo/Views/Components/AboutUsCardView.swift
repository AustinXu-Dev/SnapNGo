//
//  AboutUsCardView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 3/11/2567 BE.
//

import Foundation
import SwiftUI
import Kingfisher

struct AboutUsCardView: View {
    var image: String?
    var title: String
    var description: String

    var body: some View {
        VStack(alignment: .center) {
            if let imageUrl = image{
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .frame(height: 100)
                    .scaledToFit()
                    .cornerRadius(8)
            } else {
                Image("history_and_bg")
                    .resizable()
                    .frame(height: 100)
                    .scaledToFit()
                    .cornerRadius(8)
            }
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
