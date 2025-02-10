//
//  GetAllItemsViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 10/02/2025.
//

import Foundation

class GetAllItemsViewModel: ObservableObject{
    
    
    @Published var hairItems: [ShopItem] = []
    @Published var faceItems: [ShopItem] = []
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    func getAllItems(){
        isLoading = true
        
        let getAllItems = GetAllItemsUseCase()
        
        getAllItems.execute(getMethod: "GET") { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.hairItems = response.filter{ $0.category == "Hair"}
                    self.faceItems = response.filter{ $0.category == "Face"}
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error in get all items in shop: ", error.localizedDescription)
                }
            }
        }
    }
}
