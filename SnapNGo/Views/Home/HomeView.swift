//
//  HomeView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @StateObject var getHistoryVM: GetHistoryDataViewModel = GetHistoryDataViewModel()
    
    @State private var selectedSegment = 0
    
    let aboutUsItems = [
        ("sample", "History & Background", "Founded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity."),
        ("sample", "Campus Life", "asdfFounded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity."),
    ]
    
    var body: some View {
        ScrollView {
            VStack{
                taskSectionView
                
                LineView()
                
                mapSectionView
                
                LineView()
                
                aboutUsSectionView
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 70)
        })
        .overlay {
            ZStack{
                Color.clear
                    .frame(height: 120)
                    .background(.ultraThinMaterial)
                    .blur(radius: 1)
                    .ignoresSafeArea(edges: .top)
                HStack{
                    HStack{
                        Image("profile")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Jane Doe")
                            .fontWeight(.semibold)
                            .heading1()
                    }
                    .padding(.bottom, 10)
                    Spacer()
                    Image("currency")
                        .resizable()
                        .frame(width: 110, height: 50)
                        .aspectRatio(contentMode: .fill)
                        .overlay {
                            Text("1000")
                                .font(.footnote)
                                .foregroundStyle(.white)
                                .offset(x: 14, y: -3)
                        }
                        .padding(.bottom, 10)
                }
                .offset(y: -30)
                .padding(.horizontal)
            }.frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            if getHistoryVM.history.isEmpty{
                getHistoryVM.fetchHistory()
            }
        }
    }
    
    //MARK: - Task Section
    private var taskSectionView: some View{
        HStack {
            Image("sample")
                .resizable()
                .frame(width: 125, height: 125) // Set specific dimensions
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text(Constants.MyTasks.title)
                    .font(.headline)
                    .foregroundColor(.yellow)
                Text("15 Tasks")
                    .font(.subheadline)
                ProgressView(value: 10, total: 15)
                    .progressViewStyle(LinearProgressViewStyle(tint: .yellow))
                Text("\(Constants.MyTasks.progressLabel) 10/15")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 10)
            .background(Color.white)
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
        .frame(minWidth: 300, minHeight: 125)

    }
    
    //MARK: - No team View
    private var noTeamView: some View{
        HStack{
            VStack(alignment: .leading){
                Text(Constants.MyTasks.teamEmptyTitle)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.accentColor)
                Text(Constants.MyTasks.teamEmptyDesc)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
            }
            .padding(.vertical, Constants.LayoutPadding.medium)
            .padding(.leading, Constants.LayoutPadding.medium)
            Spacer(minLength: 20)
                
            Button(action: scanQRCode) {
                Text(Constants.MyTasks.scanButtonText)
            }
            .buttonStyle(.borderedProminent)
            .padding(.vertical, Constants.LayoutPadding.medium)
            .padding(.trailing, Constants.LayoutPadding.medium)

        }
        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
        .frame(minWidth: 300, minHeight: 68)
    }
    
    //MARK: - Map Section
    private var mapSectionView: some View{
        ZStack{
            VStack(alignment: .leading){
                Text(Constants.HomeView.mapTitle)
                    .fontWeight(.semibold)
                
                Image("sample")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            }
            .frame(maxWidth: .infinity, minHeight: 125)
            
            Button {
                // Navigation push to map
                print("tap!")
            } label: {
                Text(Constants.HomeView.mapNavigateButtonText)
                    .body1()
            }
            .buttonStyle(.borderedProminent)
            .offset(y: 130)

        }
        
    }
    
    //MARK: - About Us Section
    private var aboutUsSectionView: some View{
        VStack(alignment: .leading){
            Picker("Options", selection: $selectedSegment) {
                Text("About Us").tag(0)
                Text("Faculties").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, Constants.LayoutPadding.medium)
            
            if selectedSegment == 0 {
                LazyVStack(spacing: 8){
                    ForEach(aboutUsItems, id: \.1) { item in
                        AboutUsLongCardView(image: item.0, title: item.1, description: item.2) {
                            print("hello")
                        }
                    }
                }
            } else {
                LazyVStack(spacing: 8){
                    ForEach(aboutUsItems, id: \.1) { item in
                        AboutUsLongCardView(image: item.0, title: item.1, description: item.2) {
                            print("hello")
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    
    
    // MARK: - Scan QR code function
    func scanQRCode(){
        
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
