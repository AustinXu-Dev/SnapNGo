//
//  GetOneUserViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/3.
//

import Foundation

class GetOneUserViewModel: ObservableObject {
    
    @Published var userData: User? = nil
    @Published var userId: String = ""
    @Published var userGender: String = ""
    @Published var tasks: [Tasks] = []
    @Published var quizzes: [Quiz] = []
    @Published var inventoryItems: [InventoryItem] = []
    @Published var teamId: String? = nil
    @Published var totalPoints: Int = 0
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var userItems: [ShopItem] = []
    
    func getOneUser(userId: String) {
        isLoading = true
        errorMessage = nil
        let getOneUser = GetOneUser(userId: userId)
        getOneUser.execute(getMethod: "GET", token: nil) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let userData):
                    print("Get one user ", userData)
                    self.userData = userData
                    self.userId = userData._id
                    self.userGender = userData.gender
                    if !userData.teamIds.isEmpty{
                        self.teamId = userData.teamIds[0]
                    }
                    self.tasks = userData.tasks!
                    self.quizzes = userData.tasks!.map({ quiz in
                        quiz.quizDetails
                    })
                    self.inventoryItems = userData.inventory ?? []
                    self.totalPoints = userData.totalPoints
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = "Failed to get user detail by id: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func getProfileImage() -> String{
        let hairItems = inventoryItems
                .filter { $0.isEquipped && $0.itemInfo.category == "Hair" }
                .map { $0.itemInfo.name }

            let faceItems = inventoryItems
                .filter { $0.isEquipped && $0.itemInfo.category == "Face" }
                .map { $0.itemInfo.name }
        
        var itemsArray: [String] = []
                
        if userGender == "male" {
            itemsArray.append("male")
        } else {
            itemsArray.append("female")
        }
        
        itemsArray.append(contentsOf: hairItems) // Add hair items
        itemsArray.append(contentsOf: faceItems) // Add face items

        let result = itemsArray.joined(separator: "_").lowercased()
        
        return result
    }
    
    
}
