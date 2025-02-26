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
    @Published var snapTasks: [SnapTaskQuiz] = []
    @Published var snapQuizzes: [SnapQuiz] = []
    @Published var inventoryItems: [InventoryItem] = []
    @Published var teamId: String? = nil
    @Published var totalPoints: Int = 0
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var userItems: [ShopItem] = []
    
    func getOneUser(userId: String) {
        print("getOneUser() called with userId: \(userId)")
        isLoading = true
        errorMessage = nil
        let getOneUser = GetOneUser(userId: userId)
        
        print(getOneUser.methodPath)
        getOneUser.execute(getMethod: "GET") { result in
            print(result)
            DispatchQueue.main.async {
                switch result {
                case .success(let userData):
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
                    self.snapTasks = userData.snapTaskQuiz!
                    self.snapQuizzes = userData.snapTaskQuiz!.map({ quiz in
                        quiz.snapQuizDetails
                    })
                    self.inventoryItems = userData.inventory ?? []
                    self.totalPoints = userData.totalPoints
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = "Failed to get user detail by id: \(error.localizedDescription)"
                    print("Failed to get user detail by id: \(error.localizedDescription)")
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
    
    func getRowCount() -> Int{
        let count = self.inventoryItems.count
        if count == 1 || count == 2{
            return 1
        } else {
            return 2
        }
    }
    
    func getHairItemId() -> String? {
        if let equippedHairItemID = self.inventoryItems.first(where: { inventoryItem in
            inventoryItem.isEquipped && inventoryItem.itemInfo.category == "Hair"
        })?.itemId {
            return equippedHairItemID
        }
        return nil
    }
    
    func getHairItemName() -> String? {
        if let equippedHairItemName = self.inventoryItems.first(where: { inventoryItem in
            inventoryItem.isEquipped && inventoryItem.itemInfo.category == "Hair"
        })?.itemInfo.name {
            return equippedHairItemName.lowercased()
        }
        return nil
    }

    func getFaceItemId() -> String? {
        if let equippedFaceItemID = self.inventoryItems.first(where: { inventoryItem in
            inventoryItem.isEquipped && inventoryItem.itemInfo.category == "Face"
        })?.itemId {
            return equippedFaceItemID
        }
        return nil
    }
    
    func getFaceItemName() -> String? {
        if let equippedFaceItemName = self.inventoryItems.first(where: { inventoryItem in
            inventoryItem.isEquipped && inventoryItem.itemInfo.category == "Face"
        })?.itemInfo.name {
            return equippedFaceItemName.lowercased()
        }
        return nil
    }


    
    func reset() {
        userData = nil
        userId = ""
        userGender = ""
        tasks = []
        quizzes = []
        snapTasks = []
        snapQuizzes = []
        inventoryItems = []
        teamId = nil
        totalPoints = 0
        isLoading = false
        errorMessage = nil
        userItems = []
    }
}
