//
//  TeamTaskView.swift
//  SnapNGo
//
//  Created by Austin Xu on 13/02/2025.
//

import SwiftUI

struct TeamTaskView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var taskSectionVM: TaskSectionViewModel
    @EnvironmentObject var getOneAdminVM: GetOneAdminViewModel

    @StateObject private var getQuizVM: GetQuizViewModel = GetQuizViewModel()
    @State private var lastFetch: Date?
    
    @State private var selectedSegment = 0
    
    var teamData: CreatedTeam
    
    var body: some View {
        ZStack{
            VStack{
                TeamSectionView(team: teamData) {
                    //MARK: Navigation to member list
                    print("team section tapped in team tasks")
                    AppCoordinator.push(.createdTeamMember(named: teamData))
                }
                
                LineView()
                
                HStack{
                    Image("tasks_count_icon")
                    Text("Total ( \(getQuizVM.quizzes.count) ) tasks")
                        .heading2()
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                
                quizSegmentView
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 8)

            if getOneAdminVM.isLoading{
                loadingBoxView(message: "Loading admin")
            }
            if getQuizVM.isLoading{
                loadingBoxView(message: "Loading the quiz")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .navigationBarBackButtonHidden()
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 45)
        })
        .overlay {
            topOverlayView
        }
        .onAppear {
            getQuizVM.teamId = teamData._id
            getQuizVM.quizzesId = teamData.assignedQuizzes
            getQuizVM.snapQuizzesId = teamData.assignedSnapQuizzes
            getQuizVM.fetchQuiz { _ in
                
            }
        }
    }
    
    private var quizSegmentView: some View{
        VStack{
            Picker("Options", selection: $selectedSegment) {
                Text("Snap").tag(0)
                Text("Quiz").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom, Constants.LayoutPadding.medium)
            
            if selectedSegment == 0{
                ScrollView{
                    LazyVStack{
                        ForEach(Array(getQuizVM.snapQuizzes.enumerated()), id: \.element._id) { index, snapQuiz in
                            AdminSnapCardView(snapQuestion: "Snap Question \(index + 1)") {
                                AppCoordinator.push(.adminSnapQuizDetail(named: snapQuiz, questionNo: index+1))
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .refreshable {
                    guard let adminId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                        print("Error here")
                        return
                    }
                    getOneAdminVM.getOneAdmin(adminId: adminId, completion: { _ in
                        
                    })
                    
                    getQuizVM.teamId = teamData._id
                    getQuizVM.quizzesId = teamData.assignedQuizzes
                    getQuizVM.fetchQuiz { _ in
                        
                    }
                }
            } else {
                ScrollView{
                    LazyVStack{
                        ForEach(Array(getQuizVM.quizzes.enumerated()), id: \.element._id) { index, quiz in
                            AdminQuizCardView(quizQuestion: "Question \(index + 1)") {
                                AppCoordinator.push(.adminQuizDetail(named: quiz, questionNo: index+1))
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .refreshable {
                    guard let adminId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                        print("Error here")
                        return
                    }
                    getOneAdminVM.getOneAdmin(adminId: adminId, completion: { _ in
                        
                    })
                    
                    getQuizVM.teamId = teamData._id
                    getQuizVM.quizzesId = teamData.assignedQuizzes
                    getQuizVM.fetchQuiz { _ in
                        
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 100)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
            HStack{
                Button {
                    AppCoordinator.popToRoot()
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text("Team Tasks")
                    .heading1()
                Spacer()
                Button {
                    print("qr")
                    //MARK: show qr code view
                    AppCoordinator.presentSheet(.joinQRCode(named: teamData._id))
                } label: {
                    Image(systemName: "qrcode")
                }
            }
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
    
}

#Preview {
    TasksView()
}
