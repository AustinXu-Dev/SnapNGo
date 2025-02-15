//
//  EquipItemViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 15/02/2025.
//

import Foundation

class EquipItemViewModel: ObservableObject{
    @Published var isSuccess: Bool = false
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func equipItem(userId: String, itemIds: [String]){
        isLoading = true
        
        let equipItemDTO = EquipItemDTO(userId: userId, itemIds: itemIds)
        let equipItemManager = EquipItemUseCase()
        
        equipItemManager.execute(data: equipItemDTO, getMethod: "POST") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.isSuccess = true
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                    print("In equip item vm: \(error.localizedDescription)")
                }
            }
        }
    }
}
