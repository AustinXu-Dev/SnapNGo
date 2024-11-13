//
//  ChapelView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 14/11/2567 BE.
//

import SwiftUI

struct ChapelView: View {
    var body: some View {
        ScrollView{            
            DetailCardView(image: "sample", title: "CHAPEL OF THE ANNUNCIATION, HUAMAK CAMPUS", location: "Assumption Hall (A Building)", description: HistoryMockData.body0)
            .padding(.bottom, Constants.LayoutPadding.small)
            
            LineTextView(text: Constants.DetailView.massScheduleText)
            
            ScheduleView(title: "Saturday Morning on the First Saturday of the Month", day: "Monday - Friday", massType: "Thai Mass", time: "5:00 pm")
            
            ScheduleView(title: "Weekly Adoration", day: "Monday - Friday", massType: "", time: "5:00 pm")
            
            LinkBoxView(text: "Want to know more about our awesome university chapels? Check out this link for all the details:", url: "https://ministry.au.edu/index.php/en/about-us")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
    }
}

#Preview {
    TabView{
        ChapelView()
        ChapelView()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea()
    .tabViewStyle(.page(indexDisplayMode: .always))
    .indexViewStyle(.page(backgroundDisplayMode: .always))

}
