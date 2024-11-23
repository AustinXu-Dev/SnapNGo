//
//  GetAllUsersViewModel.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation

class GetAllUsersViewModel: ObservableObject {
    
    @Published var userData: [User]? = nil
    @Published var errorMessage: String? = nil
    
    func getAllUsers() {
        errorMessage = nil
        let getAllUsers = GetAllUsers()
        getAllUsers.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userData):
                    print("Get all users ", userData)
                    self.userData = userData
                case .failure(let error):
                    self.errorMessage = "Failed to get user detail by id: \(error.localizedDescription)"
                }
            }
        }
    }
}
