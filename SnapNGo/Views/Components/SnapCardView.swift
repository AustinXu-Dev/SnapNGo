//
//  SnapCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/19.
//

import SwiftUI

struct SnapCardView<ButtonContent: View>: View {
    
    var snapQuestion: String
    var buttonContent: () -> ButtonContent
    
    var body: some View {
        HStack() {
            Image("snap_icon")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .padding(.horizontal, 8)
            VStack(alignment: .leading) {
                Text("Find an object")
                    .font(.headline)
                    .padding(.bottom, 5)
                Text("hint: It's located near somewhere.")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .lineLimit(5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.leading, 5)
            
            buttonContent()
        }
        .frame(maxWidth: .infinity, maxHeight: 90)
        .padding(.horizontal, 5)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
    }
}
