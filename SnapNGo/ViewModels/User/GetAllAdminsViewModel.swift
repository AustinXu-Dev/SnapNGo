//
//  GetAllAdminsViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/31.
//

import Foundation

class GetAllAdminsViewModel: ObservableObject{
    @Published var adminData: [Admin] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func getAllAdmins() {
        isLoading = true
        errorMessage = nil
        let getAllAdmin = GetAllAdmins()
        getAllAdmin.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let adminData):
                    print("Get all admin ", adminData)
                    self.adminData = adminData
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = "Failed to get all admin: \(error.localizedDescription)"
                }
            }
        }
    }
}
