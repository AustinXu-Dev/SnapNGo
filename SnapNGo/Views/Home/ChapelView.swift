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
    
        GeometryReader { proxy in
            TabView {
                ForEach(chapelData.chapels ?? [], id: \.self) { chapel in
                    ScrollView {
                        VStack {
                            DetailCardView(image: chapel.images?.first, title: chapel.name, location: chapel.location ?? "", description: chapel.description)
                                .padding(.bottom, Constants.LayoutPadding.small)
                                .padding(.horizontal, Constants.LayoutPadding.small)
                            
                            LineTextView(text: Constants.DetailView.massScheduleText)
                            
                            if chapel._id == "67576d3d370538b8e6f3f4e7"{
                                // Huamak
                                ScheduleView(title: "Daily Mass", day: "Monday - Friday", massType: "", time: "5:00 pm")
                                ScheduleView(title: "Weekly Adoration", day: "Thursday", massType: "", time: "4:30 - 5:00 pm")
                                ScheduleView(title: "Saturday Morning on the First Saturday of the Month", day: "Saturday", massType: "", time: "9:30 pm")
                                ScheduleView(title: "Saturday Evening", day: "Saturday", massType: "", time: "5:00 pm")
                                
                                VStack(spacing: Constants.LayoutPadding.small) {
                                    Text("Sunday Morning")
                                        .heading2()
                                        .frame(maxWidth: 220)
                                        .lineLimit(2)
                                        .multilineTextAlignment(.center)
                                    
                                    HStack {
                                        Text("Sunday")
                                            .body1()
                                        
                                        Spacer()
                                        
                                        Text("Thai Mass")
                                            .heading2()
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        
                                        Spacer()
                                        
                                        Text("8:30 pm")
                                            .body1()
                                    }
                                    .padding(.horizontal,Constants.LayoutPadding.medium)
                                    
                                    HStack {
                                        Text("Sunday")
                                            .body1()

                                        Spacer()
                                        
                                        Text("English Mass")
                                            .heading2()
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        
                                        Spacer()
                                        
                                        Text("10:00 pm")
                                            .body1()
                                    }
                                    .padding(.horizontal,Constants.LayoutPadding.medium)
                                    
                                    LineView()
                                }
                                
                            } else{
                                // Suvarnabhumi
                                ScheduleView(title: "Sunday Mass", day: "Sunday", massType: "English Mass", time: "5:00 pm")
                            }
                            
                            
                            LinkBoxView(text: "Want to know more about our awesome university chapels? Check out this link for all the details:", url: chapel.link)
                                .padding(.horizontal, Constants.LayoutPadding.small)

                        }
                        .frame(width: proxy.size.width) // Ensure proper layout
                        .padding(.horizontal, Constants.LayoutPadding.medium)
                    }
                    .padding(.horizontal, Constants.LayoutPadding.small)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .navigationTitle(chapelData.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(ColorConstants.background)

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

//        TabView{
//            ForEach(chapelData.chapels ?? [], id: \.self) { chapel in
//                ScrollView{
//                    VStack{
//                        DetailCardView(image: "sample", title: chapel.name, location: chapel.location ?? "", description: chapel.description)
//                            .padding(.bottom, Constants.LayoutPadding.small)
//
//                        LineTextView(text: Constants.DetailView.massScheduleText)
//
//                        ScheduleView(title: "Saturday Morning on the First Saturday of the Month", day: "Monday - Friday", massType: "Thai Mass", time: "5:00 pm")
//
//                        ScheduleView(title: "Weekly Adoration", day: "Monday - Friday", massType: "", time: "5:00 pm")
//
//                        LinkBoxView(text: "Want to know more about our awesome university chapels? Check out this link for all the details:", url: chapel.link)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal, Constants.LayoutPadding.medium)
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(ColorConstants.background)
////                .ignoresSafeArea(edges: .horizontal)
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .ignoresSafeArea(edges: .all)
//        .tabViewStyle(.page(indexDisplayMode: .always))
//        .indexViewStyle(.page(backgroundDisplayMode: .never))
//        .navigationTitle(chapelData.title)
//        .navigationBarTitleDisplayMode(.inline)
