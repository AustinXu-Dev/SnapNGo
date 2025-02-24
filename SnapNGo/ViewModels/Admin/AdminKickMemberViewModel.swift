//
//  AdminKickMemberViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 24/02/2025.
//

import Foundation

class AdminKickMemberViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func kickMember(adminEmail: String, teamId: String, userId: String, completion: @escaping (String?) -> Void) {
        isLoading = true
        
        let kickTeamUseCase = KickTeamUseCase(adminEmail: adminEmail, teamId: teamId, userId: userId)
        
        kickTeamUseCase.execute(getMethod: "DELETE") { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let success):
                    completion(success.message)
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    print("Error in kick team: ",failure.localizedDescription)
                    completion(nil)
                }
            }
        }
        
        
    }
}
