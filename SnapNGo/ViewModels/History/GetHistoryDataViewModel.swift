//
//  GetHistoryDataViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/7.
//

import Foundation

class GetHistoryDataViewModel: ObservableObject{
    @Published var history : [HistoryData] = []
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    private let getAllHistory = GetAllHistoryData()
    
    func fetchHistory(){
        isLoading = true
        getAllHistory.execute { [weak self] result in
            switch result{
            case.success(let response):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.history = response.data
                    print(self?.history ?? "No history data found")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
