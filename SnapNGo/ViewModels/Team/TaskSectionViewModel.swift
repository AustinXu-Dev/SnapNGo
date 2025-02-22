//
//  TasksSectionViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/19.
//

import Foundation

class TaskSectionViewModel: ObservableObject {
    @Published var teamName: String = ""
    @Published var teamImage: String = ""
    @Published var quizTasks: Int = 0
    @Published var snapTasks: Int = 0
    @Published var completedQuizTasks: Int = 0
    @Published var completedSnapTasks: Int = 0
    
    func getCompletedTasks() -> Int {
        return completedQuizTasks + completedSnapTasks
    }
    
    func getTotalTasks() -> Int {
        return quizTasks + snapTasks
    }
        
    func getProgress() -> Double{
        return Double(getTotalTasks() / getCompletedTasks())
    }
}
