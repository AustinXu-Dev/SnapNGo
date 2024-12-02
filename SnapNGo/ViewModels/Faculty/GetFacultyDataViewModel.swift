//
//  GetFacultyDataViewModel.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 2/12/2567 BE.
//

import Foundation

class GetFacultyDataViewModel: ObservableObject{
    @Published var faculties: [FacultyData] = []
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    private let getAllFaculty = GetAllFacultyData()
    
    func fetchFaculties(){
        isLoading = true
        getAllFaculty.execute { [weak self] result in
            switch result{
            case.success(let response):
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.faculties = response
                    print(self?.faculties ?? "No faculty data found")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
