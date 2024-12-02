//
//  GetAllFacultyData.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 2/12/2567 BE.
//

import Foundation

class GetAllFacultyData: APIManager{
    typealias ModelType = [FacultyData]
    var methodPath: String{
        return "/faculty"
    }
}
