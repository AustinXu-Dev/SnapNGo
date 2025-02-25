//
//  GetOneAdminViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/31.
//

import Foundation

class GetOneAdminViewModel: ObservableObject{
    
    @Published var adminData: Admin? = nil
    @Published var adminId: String = ""
    @Published var adminEmail: String = ""
    @Published var createdTeamIds: [String] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func getOneAdmin(adminId: String, completion: @escaping (Error?) -> Void) {
        isLoading = true
        errorMessage = nil
        let getOneAdmin = GetOneAdmin(adminId: adminId)
        getOneAdmin.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let adminData):
                    print("Get one admin ", adminData)
                    self.adminData = adminData
                    self.adminId = adminData._id
                    self.adminEmail = adminData.email
                    self.createdTeamIds = adminData.teamIds
                    self.isLoading = false
                    completion(nil)
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = "Failed to get admin detail by id: \(error.localizedDescription)"
                    completion(error)
                }
            }
        }
    }
    
    func reset() {
        adminData = nil
        adminId = ""
        adminEmail = ""
        createdTeamIds = []
        isLoading = false
        errorMessage = nil
    }

}
