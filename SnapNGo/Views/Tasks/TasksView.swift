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
            VStack{
                Spacer()
                    .frame(height: 10)
                TaskSectionView()
                    .environmentObject(taskSectionVM)
                LineView()
                
                HStack{
                    Image("tasks_count_icon")
                    Text("Total ( \(taskSectionVM.totalTasks) ) tasks")
                        .heading2()
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                
                quizSegmentView
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 8)
            
            
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
                        ForEach(Array(getOneUserVM.tasks.enumerated()), id: \.element._id) { index, task in
                            QuizCardView(quizQuestion: "Question \(index + 1)") {
                                quizButton(for: task, index: index)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .refreshable {
                    guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                        print("Error here")
                        return
                    }
                    getOneUserVM.getOneUser(userId: userId)
                }
            } else {
                SnapCardView {
                    print("snap")
                }
            }
        }
        .frame(maxWidth: .infinity)
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
}

#Preview {
    TasksView()
}
