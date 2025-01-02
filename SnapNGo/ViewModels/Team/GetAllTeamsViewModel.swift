//
//  GetAllTeamsViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/3.
//

import Foundation

class GetAllTeamsViewModel: ObservableObject {
    
    @Published var teamData: [AllTeamsModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func getAllTeams() {
        isLoading = true
        errorMessage = nil
        let getAllTeams = GetAllTeamsUseCase()
        getAllTeams.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.isLoading = false
                    print("Get all teams ", response.teams)
                    self.teamData = response.teams
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = "Failed to get all teams: \(error.localizedDescription)"
                }
            }
        }
    }
}
