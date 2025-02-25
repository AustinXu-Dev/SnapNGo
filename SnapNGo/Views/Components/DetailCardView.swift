//
//  DetailCardView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 14/11/2567 BE.
//

import SwiftUI
import ExpandableText
import Kingfisher

struct DetailCardView: View {
    var image: String?
    var title: String
    var location: String
    var description: String
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack(spacing: 0){
                if let imageUrl = image{
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 140)
                        .scaledToFit()
                } else {
                    Image("huamak_chapel")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 140)
                }
            }
            
            Text(title)
                .lineLimit(2)
                .heading2()
            HStack{
                Image(Constants.DetailView.locationIcon)
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Constants.LayoutPadding.small)
        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
    }
}

