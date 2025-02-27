//
//  TasksView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct TasksView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var taskSectionVM: TaskSectionViewModel
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @EnvironmentObject var getOneTeamVM: GetOneTeamViewModel

    @StateObject private var getQuizVM: GetQuizViewModel = GetQuizViewModel()
    @State private var lastFetch: Date?
    
    @State private var selectedSegment = 0
    
    var body: some View {
        ZStack{
            ScrollView{
                if getOneTeamVM.isSuccess{
                    taskView
                } else{
                    noTaskView
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if getOneTeamVM.isLoading{
                loadingBoxView(message: "Loading team")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 45)
        })
        .overlay {
            topOverlayView
        }
        .refreshable {
            if let teamId = getOneUserVM.teamId{
                getOneTeamVM.getOneTeam(teamId: teamId) { _ in
                }
            }
        }
    }
    
    private var taskView: some View{
        VStack{
            Spacer()
                .frame(height: 10)
            TaskSectionView()

            LineView()
            
            HStack{
                Image("tasks_count_icon")
                Text("Total ( \(taskSectionVM.getTotalTasks()) ) tasks")
                    .heading2()
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            quizSegmentView
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 8)
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
                        ForEach(Array(getOneUserVM.snapTasks.enumerated()), id: \.element._id) { index, task in
                            SnapCardView(snapQuestion: "Snap Question \(index + 1)", hint: giveHint(for: task.snapQuizDetails.quizName)) {
                                snapQuizButton(for: task, index: index)
                            }
                        }
                    }
                    Spacer()
                        .frame(height: 30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .refreshable {
                    refreshUserData()
                }
            } else {
                ScrollView{
                    LazyVStack{
                        ForEach(Array(getOneUserVM.tasks.enumerated()), id: \.element._id) { index, task in
                            QuizCardView(quizQuestion: "Question \(index + 1)") {
                                quizButton(for: task, index: index)
                            }
                        }
                    }
                    Spacer()
                        .frame(height: 30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .refreshable {
                    refreshUserData()
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func snapQuizButton(for task: SnapTaskQuiz, index: Int) -> some View{
        if task.status.isFinished {
            return AnyView(
                Button {
                    AppCoordinator.push(.snapQuizDetail(named: task.snapQuizDetails, questionNo: index+1, taskId: task._id, hint: giveHint(for: task.snapQuizDetails.quizName)))
                } label: {
                    Image(task.status.isAnswerCorrect ? "quiz_correct_icon" : "quiz_wrong_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .frame(width: 95, height: 95)
            )
        } else {
            return AnyView(
                Button {
                    AppCoordinator.push(.snapQuizDetail(named: task.snapQuizDetails, questionNo: index+1, taskId: task._id, hint: giveHint(for: task.snapQuizDetails.quizName)))
                } label: {
                    Text("Snap")
                        .heading3()
                }
                .buttonStyle(.borderedProminent)
                .frame(width: 80, height: 80)
            )
        }
    }
    
    private func quizButton(for task: Tasks, index: Int) -> some View {
        if task.status.isFinished {
            return AnyView(
                Button {
                    AppCoordinator.push(.quizDetail(taskId: task._id, questionNo: index+1, named: task.quizDetails, status: task.status))
                } label: {
                    Image(task.status.isAnswerCorrect ? "quiz_correct_icon" : "quiz_wrong_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .frame(width: 95, height: 95)
            )
        } else {
            return AnyView(
                Button {
                    AppCoordinator.push(.quizDetail(taskId: task._id, questionNo: index+1, named: task.quizDetails, status: task.status))
                } label: {
                    Text("Answer")
                        .heading3()
                }
                .buttonStyle(.borderedProminent)
                .frame(width: 80, height: 80)
            )
        }
    }

    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 100)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
            HStack{
                Spacer()
                Text("Tasks")
                    .heading1()
                Spacer()
            }
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var noTaskView: some View{
        VStack(alignment: .center){
            Spacer()
                .frame(height: 40)
            Image(Constants.TeamViewConstant.teamHomeImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 8)
            Text(Constants.TeamViewConstant.welcomeMessage)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
                .frame(maxWidth: 300)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Text("Join a team to enjoy the fun!")
                .frame(width: 280)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .fontWeight(.light)
                .padding(.bottom, 8)
            Button {
                AppCoordinator.selectedTabIndex = .team
            } label: {
                Text("Join Team")
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
    }
    
    private func giveHint(for place: String) -> String{
        switch place {
        case "ClockTower":
            return "near Dormitory"
        case "Galileo":
            return "inside MSME Building"
        case "Tram":
            return "around School campus"
        case "CLBuilding":
            return "near CL Plaza"
        case "Chapel":
            return "near the lake"
        case "Salathai":
            return "near the lake"
        default:
            return ""
        }
    }
    
    private func refreshUserData(){
        guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
            print("Error here")
            return
        }
        getOneUserVM.getOneUser(userId: userId)
        
    }
}

#Preview {
    TasksView()
}
