//
//  HomeView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var taskSectionVM: TaskSectionViewModel
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @EnvironmentObject var getOneTeamVM: GetOneTeamViewModel
    
    @StateObject var getHistoryVM: GetHistoryDataViewModel = GetHistoryDataViewModel()
    @StateObject var getFacultyVM: GetFacultyDataViewModel = GetFacultyDataViewModel()
    
    @State private var selectedSegment = 0
    
    let aboutUsItems = [
        ("sample", "History & Background", "Founded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.", "history"),
        ("sample", "Chapel", "asdfFounded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.", "chapel"),
        ("sample", "Campus", "asdfFounded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.", "campus"),
        ("sample", "Faculty", "asdfFounded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.", "faculty"),
    ]
    
    var body: some View {
        ScrollView {
            VStack{
                if getOneUserVM.teamId == nil{
                    noTeamView
                } else {
                    TaskSectionView()
                        .onTapGesture {
                            AppCoordinator.selectedTabIndex = .team
                        }
                }
                
                LineView()
                
                mapSectionView
                
                LineView()
                
                aboutUsSectionView
            }
            .padding(.horizontal, Constants.LayoutPadding.small)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 70)
        })
        .overlay {
            topOverlayView
        }
        .onAppear {
            if getHistoryVM.history.isEmpty{
                getHistoryVM.fetchHistory()
            }
            if getFacultyVM.faculties.isEmpty{
                getFacultyVM.fetchFaculties()
            }
        }
        .refreshable {
            guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                print("Error here")
                return
            }
            print(userId)
            getOneUserVM.getOneUser(userId: userId)
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
                    .foregroundColor(.accent)
                Text("\(taskSectionVM.getCompletedTasks())")
                    .font(.subheadline)
                ProgressView(value: Float(taskSectionVM.getCompletedTasks()), total: Float(taskSectionVM.getTotalTasks()))
                    .progressViewStyle(LinearProgressViewStyle(tint: .accent))
                Text("\(Constants.MyTasks.progressLabel) \(taskSectionVM.getCompletedTasks())/\(taskSectionVM.getTotalTasks())")
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
    
    //MARK: - Top Overlay View
    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 120)
                .background(.ultraThinMaterial)
                .blur(radius: 1)
                .ignoresSafeArea(edges: .top)
            HStack{
                HStack{
                    Image(getOneUserVM.getProfileImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 43, height: 43)
                    Text(getOneUserVM.userData?.name ?? "User")
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
                        Text("\(getOneUserVM.totalPoints)")
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .offset(x: 14, y: -3)
                    }
            }
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
    
    //MARK: - Map Section
    private var mapSectionView: some View{
        ZStack{
            VStack(alignment: .leading){
                Text(Constants.HomeView.mapTitle)
                    .fontWeight(.semibold)
                
                Image("abac_map")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            }
            .frame(maxWidth: .infinity, minHeight: 125)
            
            Button {
                // Navigation push to map
                AppCoordinator.push(.mapView)
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
                    ForEach(getHistoryVM.history, id: \._id) { item in
                        AboutUsLongCardView(image: item.images?.first, title: item.title, description: item.description) {
                            switch item.type{
                            case "history":
                                AppCoordinator.push(.historyDetail(named: item))
                            case "chapel":
                                AppCoordinator.push(.chapelDetail(named: item))
                            case "campus":
                                AppCoordinator.push(.campusDetail(named: item))
                            default:
                                AppCoordinator.popToRoot()
                            }
                        }
                    }
                }
            } else {
                LazyVStack(spacing: 8){
                    ForEach(getFacultyVM.faculties, id: \.self) { faculty in
                        AboutUsLongCardView(image: faculty.images?.first, title: faculty.abbreviation, description: faculty.shortDescription) {
                            AppCoordinator.push(.facultyDetail(named: faculty))
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    
    
    // MARK: - Scan QR code function
    func scanQRCode(){
        AppCoordinator.selectedTabIndex = .team
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
