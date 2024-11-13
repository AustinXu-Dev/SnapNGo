//
//  DetailCardView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 14/11/2567 BE.
//

import SwiftUI
import ExpandableText

struct DetailCardView: View {
    var image: String
    var title: String
    var location: String
    var description: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack(spacing: 0){
                Image(image)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 125)
            }
            
            Text(title)
                .lineLimit(2)
                .heading3()
            HStack{
                Image("location_icon")
                Text(location)
                    .body2()
                    .lineLimit(2)
            }
            
            ExpandableText(description)
                .font(.system(size: 12, weight: .regular))
                .expandAnimation(.easeInOut)
                .moreButtonColor(.accent)
                .enableCollapse(true)
                .lineLimit(7)
            
        }
        .frame(width: 370)
        .padding(Constants.LayoutPadding.small)
        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
    }
}

