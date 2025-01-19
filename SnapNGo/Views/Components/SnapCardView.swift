//
//  SnapCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/19.
//

import SwiftUI

struct SnapCardView: View {
    
    var action:() -> Void

    var body: some View {
        HStack(spacing: 5) {
            Image("snap_icon")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .padding(.horizontal, 8)
            VStack(alignment: .leading) {
                Text("Find an object")
                    .font(.headline)
                    .padding(.bottom, 5)
                Text("hint: It's located near somewhere")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .lineLimit(5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.leading, 5)
            
            Button {
                action()
            } label: {
                Text("Snap")
                    .font(.footnote)
            }
            .buttonStyle(.borderedProminent)
            .padding(.trailing, 8)

        }
        .frame(maxWidth: .infinity, maxHeight: 90)
        .padding(.horizontal, 5)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
    }
}
#Preview {
    SnapCardView(action: {})
}
