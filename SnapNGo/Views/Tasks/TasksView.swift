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
                    .frame(height: 15)
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
            .padding(.horizontal, 16)
            
            
            if getOneTeamVM.isLoading{
                loadingBoxView(message: "Loading team")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
//        .onAppear {
//            if let lastFetch = lastFetch, Date().timeIntervalSince(lastFetch) < 300{
//                print("Using cache data in tasks view.")
//            } else {
//                // Update last fetch time
//                lastFetch = Date()
//            }
//        }
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
                                Button {
                                    // MARK: Navigate to Quiz Detail
                                    AppCoordinator.push(.quizDetail(taskId: task._id, questionNo: index+1, named: task.quizDetails, status: task.status))
                                } label: {
                                    if task.status.isFinished{
                                        showQuizCompletionText(task: task)
                                    } else {
                                        Text("Answer")
                                            .font(.footnote)
                                    }
                                }
                                .buttonStyle(.borderedProminent)

                            }
                        }
                    }
                }
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
    
    private func showQuizCompletionText(task: Tasks) -> some View{
        Image(systemName: task.status.isAnswerCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
            .foregroundStyle(.white)
            .font(.footnote)
    }
}

#Preview {
    TasksView()
}
