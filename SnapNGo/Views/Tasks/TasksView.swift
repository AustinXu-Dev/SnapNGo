//
//  TasksView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct TasksView: View {
    
    // For production
    @EnvironmentObject var taskSectionVM: TaskSectionViewModel
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @EnvironmentObject var getOneTeamVM: GetOneTeamViewModel

    @StateObject private var getQuizVM: GetQuizViewModel = GetQuizViewModel()
    @State private var lastFetch: Date?
    // For Preview
//    @StateObject var taskSectionVM: TaskSectionViewModel = TaskSectionViewModel()
    
    @State private var selectedSegment = 0
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    TaskSectionView()
                        .environmentObject(taskSectionVM)
                    LineView()
                    
                    HStack{
                        Image("tasks_icon")
                        Text("Total ( \(taskSectionVM.totalTasks) ) tasks")
                            .heading2()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack{
                        Picker("Options", selection: $selectedSegment) {
                            Text("Snap").tag(0)
                            Text("Quiz").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom, Constants.LayoutPadding.medium)
                        
                        if selectedSegment == 0{
                            LazyVStack{
                                ForEach(getQuizVM.quizzes, id: \._id){ quiz in
                                    QuizCardView(quizQuestion: quiz.question){
                                        print("answer")
                                    }
                                }
                            }
                        } else {
                            SnapCardView {
                                print("snap")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(.horizontal, 16)
            }
            
            if getOneTeamVM.isLoading{
                loadingBoxView(message: "Loading team")
            }
            if getOneUserVM.isLoading{
                loadingBoxView(message: "Fetching user")
            }
            if getQuizVM.isLoading{
                loadingBoxView(message: "Loading tasks")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
//        .onAppear{
//            if let lastFetch = lastFetch, Date().timeIntervalSince(lastFetch) < 300{
//                print("using cache data")
//            } else {
//                lastFetch = Date()
//                if getOneTeamVM.teamData == nil{
//                    if let teamId = getOneUserVM.teamId{
//                        getOneTeamVM.getOneTeam(teamId: teamId) { _ in
//                            getQuizVM.teamId = teamId
//                            getQuizVM.quizzesId = getOneTeamVM.quizIds
//                            getQuizVM.fetchQuiz { error in
//                                guard error == nil else {
//                                    print("Error occurred in tasks view: \(error!.localizedDescription)")
//                                    return
//                                }
//                            }
//                        }
//                    } else {
//                        //TODO: - No Team Found Screen
//                    }
//                } else {
//                    getQuizVM.teamId = getOneTeamVM.teamId
//                    getQuizVM.quizzesId = getOneTeamVM.quizIds
//                    
//                    getQuizVM.fetchQuiz { error in
//                        guard error == nil else {
//                            print("Error occurred in tasks view: \(error!.localizedDescription)")
//                            return
//                        }
//                    }
//                }
//            }
//        }
        .onAppear {
            guard Date().timeIntervalSince(lastFetch ?? Date.distantPast) >= 300 else {
                print("Using cached data.")
                return
            }
            
            // Update last fetch time
            lastFetch = Date()
            
            // If team data is missing, fetch team and related quizzes
            guard let teamId = getOneUserVM.teamId else {
                print("No Team Found.")
                // TODO: Show "No Team Found" UI
                return
            }
            
            if getOneTeamVM.teamData == nil {
                getOneTeamVM.getOneTeam(teamId: teamId) { _ in
                    updateQuizData(for: teamId)
                }
            } else {
                updateQuizData(for: teamId)
            }
        }

        // Helper to Update Quiz Data
       

    }
    
    private func updateQuizData(for teamId: String) {
        getQuizVM.teamId = teamId
        getQuizVM.quizzesId = getOneTeamVM.quizIds
        getQuizVM.fetchQuiz { error in
            if let error = error {
                print("Error occurred in tasks view: \(error.localizedDescription)")
            } else {
                print("Quizzes fetched successfully.")
            }
        }
    }
}

#Preview {
    TasksView()
}
