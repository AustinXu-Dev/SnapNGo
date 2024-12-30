//
//  CreateTeamViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/12/17.
//

import Foundation

class CreateTeamViewModel: ObservableObject{
    @Published var teamName: String = ""
    @Published var adminUsername: String = ""
    @Published var teamImageUrl: String = ""
    @Published var totalTasks: Int = 0
    @Published var maxMember: String = ""
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func createTeam() {
        isLoading = true
        
        let createTeamBody = CreateTeamDTO(teamName: teamName, adminUsername: adminUsername, teamImageUrl: teamImageUrl, totalTasks: totalTasks, maxMember: Int(maxMember) ?? 0, assignedQuizzes: [])
        
        let createTeamManager = CreateTeamUseCase()
        
        createTeamManager.execute(data: createTeamBody, getMethod: "POST") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    self.isLoading = false
                    print(success.teams)
                case .failure(let failure):
                    self.isLoading = false
                    self.errorMessage = failure.localizedDescription
                    print(failure.localizedDescription)
                }
            }
        }
    }
}
