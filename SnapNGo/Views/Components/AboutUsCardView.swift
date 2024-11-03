//
//  AboutUsCardView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 3/11/2567 BE.
//

import Foundation
import SwiftUI

struct AboutUsCardView: View {
    var image: String // Image URL or name
    var title: String
    var description: String
    var action:() -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Image(image) // Replace with AsyncImage if loading from a URL
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .cornerRadius(8)
            
            Text(title)
                .font(.headline)
                .padding(.top, 8)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(6)
            Spacer()
            HStack {
                Spacer()
                Button {
                    action()
                } label: {
                    Text("Explore")
                }
                .buttonStyle(.borderedProminent)
            }

        }
        .frame(width: 200, height: 280) // Adjust width for horizontal scrolling
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 3, x: 0, y:4)
    }
}
