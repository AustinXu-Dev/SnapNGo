//
//  SnapCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/19.
//

import SwiftUI

struct SnapCardView<ButtonContent: View>: View {
    
    var snapQuestion: String
    var hint: String
    var buttonContent: () -> ButtonContent
    
    var body: some View {
        HStack() {
            Image("snap_icon")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .padding(.horizontal, 8)
            VStack(alignment: .leading) {
                Text(snapQuestion)
                    .font(.headline)
                    .padding(.bottom, 5)
                Text("hint: It can be found \(hint).")
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

struct AdminSnapCardView: View {
    
    var snapQuestion: String
    var hint: String
    var action: () -> Void
    
    var body: some View {
        HStack() {
            Image("snap_icon")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .padding(.horizontal, 8)
            VStack(alignment: .leading) {
                Text(snapQuestion)
                    .font(.headline)
                    .padding(.bottom, 5)
                Text("hint: It can be found \(hint).")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .lineLimit(5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.leading, 5)
            
            Image(systemName: "chevron.right")
                .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: 90)
        .padding(.horizontal, 5)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
        .onTapGesture {
            action()
        }
    }
}
