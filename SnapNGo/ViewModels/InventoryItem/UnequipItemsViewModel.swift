//
//  UnequipItemsViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 25/02/2025.
//

import Foundation

class UnequipItemsViewModel: ObservableObject{
    @Published var isSuccess: Bool = false
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func unequipItems(userId: String){
        isLoading = true
        
        let unequipItemDTO = UnequipItemsDTO(userId: userId)
        let unequipItemManager = UnequipItemsUseCase()
        print(userId)
        
        unequipItemManager.execute(data: unequipItemDTO, getMethod: "POST") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.isSuccess = true
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                    print("In unequip item vm: \(error.localizedDescription)")
                }
            }
        }
    }
}
