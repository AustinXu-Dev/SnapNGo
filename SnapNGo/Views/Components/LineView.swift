//
//  LineView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/2.
//

import Foundation
import SwiftUI

struct LineView: View {
    var color: Color = .accentColor
    var height: CGFloat = 1
    var horizontalPadding: CGFloat = 8
    var verticalPadding: CGFloat = 8

    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundColor(color.opacity(0.5))
            .padding(.vertical, verticalPadding)
    }
}

struct LineTextView: View {
    var text: String
    var color: Color = .accentColor
    var height: CGFloat = 2
    var horizontalPadding: CGFloat = 8
    var verticalPadding: CGFloat = 8

    var body: some View {
        HStack{
            Rectangle()
                .frame(height: height)
                .foregroundColor(color)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
            Text(text)
                .heading2()
                .foregroundStyle(.accent)
            Rectangle()
                .frame(height: height)
                .foregroundColor(color)
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
        }
    }
}
