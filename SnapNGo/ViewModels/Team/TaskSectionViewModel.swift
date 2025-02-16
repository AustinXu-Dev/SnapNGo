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
    @Published var totalTasks: Int = 0
    @Published var completedTasks: Int = 0
        
    func getProgress() -> Double{
        return Double(totalTasks / completedTasks)
    }
}
