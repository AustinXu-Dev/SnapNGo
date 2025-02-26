//
//  UpdateUserViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import Foundation

class UpdateUserViewModel: ObservableObject{
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func updateUser(name: String, email: String, school: String, gender: String,userId: String, completion: @escaping (User?) -> Void){
        isLoading = true
        
        let updateUserDTO = UpdateUserDTO(name: name, email: email, gender: gender, school: school)
        let updateUserManager = UpdateUser(userId: userId)
        
        updateUserManager.execute(data: updateUserDTO, getMethod: "PATCH") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.isLoading = false
                    completion(response)
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                    print("Error in update user: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }
}
