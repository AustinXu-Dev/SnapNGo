//
//  CreateTeamViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/12/17.
//

import Foundation

class CreateTeamViewModel: ObservableObject{
    @Published var teamIdResponse: String?
    
    @Published var teamName: String = ""
    @Published var adminEmail: String = ""
    @Published var teamImageUrl: String = ""
    @Published var totalTasks: Int = 0
    @Published var maxMember: String = ""
    @Published var assignedQuizzes: [String] = []
    
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func createTeam(completion: @escaping (Error?) -> Void) {
        isLoading = true
        
        let createTeamBody = CreateTeamDTO(teamName: teamName, adminEmail: adminEmail, teamImageUrl: teamImageUrl, maxMember: Int(maxMember) ?? 10, assignedQuizzes: assignedQuizzes)
        
        let createTeamManager = CreateTeamUseCase()
        
        createTeamManager.execute(data: createTeamBody, getMethod: "POST") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.isLoading = false
                    self.teamIdResponse = response.team._id
                    print(response.team)
                    completion(nil)
                case .failure(let failure):
                    self.isLoading = false
                    self.errorMessage = failure.localizedDescription
                    print("error here?")
                    print(failure.localizedDescription)
                    completion(failure)
                }
            }
        }
    }
}
