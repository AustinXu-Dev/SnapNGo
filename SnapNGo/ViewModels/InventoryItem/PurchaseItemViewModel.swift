//
//  PurchaseItemViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 10/02/2025.
//

import Foundation

class PurchaseItemViewModel: ObservableObject{
    
    @Published var isSuccess: Bool = false
    @Published var purchaseFailed: Bool = false
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func purchaseItem(userId: String, itemId: String, quantity: Int, completion: @escaping () -> Void){
        isLoading = true
        
        let purchaseItemDTO = PurchaseItemDTO(userId: userId, itemId: itemId, quantity: quantity)
        let purchaseItemManager = PurchaseItemUseCase()
        
        purchaseItemManager.execute(data: purchaseItemDTO, getMethod: "POST") { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(_):
                    self.isSuccess = true
                    completion()
                case .failure(let failure):
                    self.purchaseFailed = true
                    self.errorMessage = failure.localizedDescription
                    print("Error in purchase item: \(failure.localizedDescription)")
                    completion()
                }
            }
        }
    }
}
