//
//  GetAllCreatedTeamsViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/1.
//

import Foundation

class GetAllCreatedTeamsViewModel: ObservableObject{
    @Published var teamsData: [CreatedTeam] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func getAllCreatedTeams(adminEmail: String){
        isLoading = true
        errorMessage = nil
        
        let getCreatedTeamsUseCase = GetCreatedTeamsUseCase(adminEmail: adminEmail)
        
        getCreatedTeamsUseCase.execute(getMethod: "GET") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.teamsData = response.teams
                    print(self.teamsData)
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error in get all created teams \(error.localizedDescription)")
                    self.isLoading = false
                }
            }
        }
    }
}
