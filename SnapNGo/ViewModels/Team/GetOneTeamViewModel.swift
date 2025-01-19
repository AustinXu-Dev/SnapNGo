//
//  GetOneTeamViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/3.
//

import Foundation

class GetOneTeamViewModel: ObservableObject {
    
    @Published var teamData: OneTeamModel? = nil
    @Published var teamId: String = ""
    @Published var teamName: String = ""
    @Published var members: [OneMemberModel] = []
    @Published var quizIds: [String] = []
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isSuccess: Bool = false
    
    func getOneTeam(teamId: String) {
        isLoading = true
        errorMessage = nil
        let getOneTeam = GetOneTeamUseCase(teamId: teamId)
        getOneTeam.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.isLoading = false
                    print("Get one team: ", response.team)
                    self.teamData = response.team
                    self.teamId = response.team._id
                    self.members = response.team.members?.filter({ member in
                        member.role == "user"
                    }) ?? []
                    self.teamName = response.team.teamName
                    self.quizIds = response.team.assignedQuizzes ?? []
                    
                    self.isSuccess = true
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = "Failed to get all teams: \(error.localizedDescription)"
                }
            }
        }
    }

}
