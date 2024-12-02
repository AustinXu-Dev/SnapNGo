//
//  ChapelView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 14/11/2567 BE.
//

import SwiftUI

struct ChapelView: View {
    
    var chapelData: HistoryData
    
    var body: some View {
        TabView{
            ForEach(chapelData.chapels ?? [], id: \.self) { chapel in
                ScrollView{
                    VStack{
                        DetailCardView(image: "sample", title: chapel.name, location: chapel.location ?? "", description: chapel.description)
                            .padding(.bottom, Constants.LayoutPadding.small)
                        
                        LineTextView(text: Constants.DetailView.massScheduleText)
                        
                        ScheduleView(title: "Saturday Morning on the First Saturday of the Month", day: "Monday - Friday", massType: "Thai Mass", time: "5:00 pm")
                        
                        ScheduleView(title: "Weekly Adoration", day: "Monday - Friday", massType: "", time: "5:00 pm")
                        
                        LinkBoxView(text: "Want to know more about our awesome university chapels? Check out this link for all the details:", url: chapel.link)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, Constants.LayoutPadding.medium)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(ColorConstants.background)
//                .ignoresSafeArea(edges: .horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(edges: .bottom)
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .navigationTitle(chapelData.title)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
//    TabView{
//        ChapelView()
//        ChapelView()
//    }
//    .frame(maxWidth: .infinity, maxHeight: .infinity)
//    .ignoresSafeArea()
//    .tabViewStyle(.page(indexDisplayMode: .always))
//    .indexViewStyle(.page(backgroundDisplayMode: .always))

}
