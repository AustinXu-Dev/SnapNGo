//
//  LeaveTeamViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/2/6.
//

import Foundation

class LeaveTeamViewModel: ObservableObject{
    
    @Published var isSuccess: Bool? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func leaveTeam(userId: String, teamId: String){
        isLoading = true
        
        let leaveTeamDTO = LeaveTeamDTO(userId: userId, teamId: teamId)
        let leaveTeamManager = LeaveTeamUseCase()
        
        leaveTeamManager.execute(data: leaveTeamDTO, getMethod: "POST") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.isLoading = false
                    self.isSuccess = true
                    print(response)
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                }
            }
        }
    }
}
