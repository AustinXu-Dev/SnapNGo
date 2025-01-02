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
                }
            case .failure(let error):
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
