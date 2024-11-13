//
//  HistoryDetailView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 13/11/2567 BE.
//

import SwiftUI
import ExpandableText

struct HistoryDetailView: View {
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView{
            VStack{
                HStack(spacing: 0){
                    Image("sample")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 125)
                    Image("sample")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 125)
                }
                ExpandableText(HistoryMockData.body0)
                    .enableCollapse(true)
                    .lineLimit(7)
                    .moreButtonColor(.accent)
                    .body1()
            }
            .frame(width: 370)
            .padding(Constants.LayoutPadding.small)
            .background(RoundedRectangle(cornerRadius: 8).fill(.white))
            .padding(Constants.LayoutPadding.medium)
            
            LineView()
                .padding(.horizontal, Constants.LayoutPadding.small)
            
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(HistoryMockData.cards, id: \.0) { item in
                    AboutUsCardView(image: "sample", title: item.0, description: item.1)
                }
            }
            .padding(.horizontal, Constants.LayoutPadding.medium)
            
            LineView()
                .padding(.horizontal, Constants.LayoutPadding.small)
            
            LinkBoxView(text: "Check out our school website for detailed infos :", url: "https://www.au.edu/about-au")

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        
    }
}

#Preview {
    HistoryDetailView()
}
