//
//  HistoryDetailView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 13/11/2567 BE.
//

import SwiftUI
import ExpandableText

struct HistoryDetailView: View {
    
    var historyData: HistoryData
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView{
            VStack{
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
                    ExpandableText(historyData.description)
                        .font(.system(size: 12, weight: .regular))
                        .expandAnimation(.easeInOut)
                        .moreButtonColor(.accent)
                        .enableCollapse(true)
                        .lineLimit(7)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(Constants.LayoutPadding.small)
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
                
                LineView(horizontalPadding: 0)

                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(historyData.campuses ?? [], id: \.self){ item in
                        AboutUsCardView(image: "sample", title: item.name, description: item.description)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                LineView(horizontalPadding: 0)
                
                LinkBoxView(text: "Check out our school website for detailed infos :", url: historyData.campuses?[0].link ?? "https://www.au.edu/about-au")
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Constants.LayoutPadding.medium)
            
            .navigationTitle(historyData.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .ignoresSafeArea(edges: .horizontal)
    }
}

#Preview {
//    HistoryDetailView()
}
