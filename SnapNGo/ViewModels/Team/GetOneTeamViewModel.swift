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
    @Published var teamImage: String = ""
    @Published var members: [OneMemberModel] = []
    @Published var leaderboardMembers: [LeaderboardMember] = []
    @Published var quizIds: [String] = []
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isSuccess: Bool = false
    
    func getOneTeam(teamId: String, completion: @escaping (Error?) -> Void) {
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
                    self.teamImage = response.team.teamImageUrl
                    self.quizIds = response.team.assignedQuizzes ?? []
                    
                    self.isSuccess = true
                    completion(nil)
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = "Failed to get all teams: \(error.localizedDescription)"
                    completion(error)
                }
            }
        }
    }
    
    func getLeaderboard(teamId: String, completion: @escaping (Error?) -> Void) {
        isLoading = true
        errorMessage = nil
        let getLeaderboard = GetLeaderboardUseCase(teamId: teamId)
        getLeaderboard.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let success):
                    self.leaderboardMembers = success.leaderboard.members
                    completion(nil)
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    print("In get leaderboard: ", failure.localizedDescription)
                    completion(failure)
                }
            }
        }
    }

    func reset() {
        teamData = nil
        teamId = ""
        teamName = ""
        teamImage = ""
        members = []
        leaderboardMembers = []
        quizIds = []
        isLoading = false
        errorMessage = nil
        isSuccess = false
    }

}
