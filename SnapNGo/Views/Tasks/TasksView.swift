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
                        QuizCardView(){
                            print("answer")
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
        
    }
}

#Preview {
    TasksView()
}
