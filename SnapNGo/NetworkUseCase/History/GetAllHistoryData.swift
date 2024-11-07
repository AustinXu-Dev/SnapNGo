//
//  GetAllHistoryData.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/7.
//

import Foundation

class GetAllHistoryData : APIManager{
    typealias ModelType = HistoryDataResponse
    var methodPath: String{
        return "/history"
    }
}
