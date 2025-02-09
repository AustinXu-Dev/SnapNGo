//
//  AdminHomeView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/1.
//

import SwiftUI

struct AdminHomeView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var taskSectionVM: TaskSectionViewModel
    @EnvironmentObject var getOneAdminVM: GetOneAdminViewModel
    @EnvironmentObject var getCreatedTeamsVM: GetAllCreatedTeamsViewModel
    
    @StateObject var getHistoryVM: GetHistoryDataViewModel = GetHistoryDataViewModel()
    @StateObject var getFacultyVM: GetFacultyDataViewModel = GetFacultyDataViewModel()
    
    @State private var selectedSegment = 0
    @State private var showAllTeams = false
    
    let aboutUsItems = [
        ("sample", "History & Background", "Founded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.", "history"),
        ("sample", "Chapel", "asdfFounded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.", "chapel"),
        ("sample", "Campus", "asdfFounded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.", "campus"),
        ("sample", "Faculty", "asdfFounded in 1969, Assumption University is a leading Thai institution, known for its Catholic heritage, academic excellence, and global diversity.", "faculty"),
    ]
    
    var body: some View {
        ScrollView {
            VStack{
                
                if getOneAdminVM.createdTeamIds.isEmpty {
                    noTeamView
                } else {
                    ForEach(showAllTeams ? getCreatedTeamsVM.teamsData : Array(getCreatedTeamsVM.teamsData.prefix(2)), id: \._id) { team in
                        TeamSectionView(team: team) {
                            print("team section tapped")
                        }
                    }
                    
                    if getCreatedTeamsVM.teamsData.count > 2 {
                        Button(action: {
                            showAllTeams.toggle()
                        }) {
                            HStack{
                                Text(showAllTeams ? "See Less" : "See More")
                                    .heading3()
                                    .foregroundColor(.blue)
                                    .padding(.top, 5)
                                Image(systemName: showAllTeams ? "chevron.up" : "chevron.down")
                                    .font(.body)
                                    .foregroundColor(.blue)
                                
                            }
                        }
                    }
                }
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
            guard let adminId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                print("Error here")
                return
            }
            getOneAdminVM.getOneAdmin(adminId: adminId){_ in}
        }
        .navigationBarBackButtonHidden()
    }
    
    //MARK: - No team View
    private var noTeamView: some View{
        HStack{
            VStack(alignment: .leading){
                Text("Your Team is Empty.")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.accentColor)
                Text("Form the team and let them enjoy")
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
            }
            .padding(.vertical, Constants.LayoutPadding.medium)
            .padding(.leading, Constants.LayoutPadding.medium)
            Spacer(minLength: 20)
                
            Button(action: createTeam) {
                Text("Create")
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
                    Image("profile")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text(getOneAdminVM.adminData?.name ?? "Admin")
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
    
    
    
    // MARK: - Create Team function
    func createTeam(){
        
    }
}

#Preview {
    AdminHomeView()
}
