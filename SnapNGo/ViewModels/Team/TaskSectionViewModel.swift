//
//  TasksSectionViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/19.
//

import Foundation

class TaskSectionViewModel: ObservableObject {
    @Published var totalTasks: Int = 0
    @Published var completedTasks: Int = 0
    
    init() {
        fetchTasks()
    }
    
    func fetchTasks() {
        // Mocked data
        self.totalTasks = 20
        self.completedTasks = 10
    }
    
    func getProgress() -> Double{
        return Double(totalTasks / completedTasks)
    }
}
