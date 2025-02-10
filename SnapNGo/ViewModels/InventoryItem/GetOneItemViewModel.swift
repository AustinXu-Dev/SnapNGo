//
//  GetOneItemViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 10/02/2025.
//

import Foundation

class GetOneItemViewModel: ObservableObject{
    
    @Published var item: ShopItem? = nil
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func getOneItem(itemId: String, completion: @escaping (ShopItem?) -> Void){
        if item != nil { return }
        isLoading = true
        
        let getItemByIdUseCase = GetItemByIdUseCase(itemId: itemId)
        
        getItemByIdUseCase.execute(getMethod: "GET") { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.item = response
                    completion(response)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error in get one item: ", error.localizedDescription)
                    completion(nil)
                }
            }
        }
    }
}
