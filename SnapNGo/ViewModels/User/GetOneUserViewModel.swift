//
//  GetOneUserViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/3.
//

import Foundation

class GetOneUserViewModel: ObservableObject {
    
    @Published var userData: User? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func getOneUser(userId: String) {
        isLoading = true
        errorMessage = nil
        let getOneUser = GetOneUser(userId: userId)
        getOneUser.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userData):
                    self.isLoading = false
                    print("Get all users ", userData)
                    self.userData = userData
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = "Failed to get user detail by id: \(error.localizedDescription)"
                }
            }
        }
    }
}
