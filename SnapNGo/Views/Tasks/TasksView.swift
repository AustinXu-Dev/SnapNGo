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
    // For Preview
//    @StateObject var taskSectionVM: TaskSectionViewModel = TaskSectionViewModel()
    
    @State private var selectedSegment = 0
    
    var body: some View {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .onAppear{
            if getOneTeamVM.teamData != nil{
                if let teamId = getOneUserVM.teamId{
                    //TODO: - Add loading while fetching team data
                    getOneTeamVM.getOneTeam(teamId: teamId)
                    
                    getQuizVM.teamId = teamId
                    getQuizVM.quizzesId = getOneTeamVM.quizIds
                    getQuizVM.fetchQuiz { error in
                        guard error == nil else {
                            print("Error occurred in tasks view: \(error!.localizedDescription)")
                            return
                        }
                    }
                }
            } else {
                getQuizVM.teamId = getOneTeamVM.teamId
                getQuizVM.quizzesId = getOneTeamVM.quizIds
                
                getQuizVM.fetchQuiz { error in
                    guard error == nil else {
                        print("Error occurred in tasks view: \(error!.localizedDescription)")
                        return
                    }
                }
            }
        }
        
    }
}

#Preview {
    TasksView()
}
