//
//  UserJoinTeamViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/2.
//

import Foundation

class UserJoinTeamViewModel: ObservableObject{
    
    @Published var userId: String = ""
    
    @Published var joinTeamSuccess: Bool = false
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func joinTeam(teamId: String, userId: String, completion: @escaping (Error?) -> Void){
        isLoading = true
        
        let joinTeamDTO = JoinTeamDTO(userId: userId)
        let joinTeamManager = JoinTeamUseCase(teamId: teamId)
        
        joinTeamManager.execute(data: joinTeamDTO, getMethod: "POST") { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.isLoading = false
                    self.joinTeamSuccess = true
                    print(response.message)
                    completion(nil)
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                    completion(error)
                }
            }
        }
    }
}
