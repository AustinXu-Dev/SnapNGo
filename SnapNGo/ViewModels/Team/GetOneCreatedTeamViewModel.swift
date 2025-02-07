//
//  GetOneCreatedTeamViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/5.
//

import Foundation

class GetOneCreatedTeamViewModel: ObservableObject{
    @Published var teamsData: CreatedOneTeam? = nil
    @Published var membersData: [TeamMember] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func getOneCreatedTeam(teamId: String, adminEmail: String, completion: @escaping (Error?) -> Void){
        isLoading = true
        errorMessage = nil
        let oneTeamManager = GetOneCreatedTeamUseCase(teamId: teamId, email: adminEmail)
        
        oneTeamManager.execute(getMethod: "GET") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.teamsData = response.team
                    self.membersData = response.team.members.filter { $0.role == "user"}
                    print(teamId)
                    print(adminEmail)
                    print(response.team.members.filter { $0.role == "user"})
                    self.isLoading = false
                    completion(nil)
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    print("Error in get one created team vm: \(error.localizedDescription)")
                    completion(error)
                }
            }
        }
    }
}
