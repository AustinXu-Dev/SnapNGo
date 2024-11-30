//
//  HistoryData.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/7.
//

import Foundation

struct HistoryDataResponse: Codable, Hashable {
    let message: String
    let data: [HistoryData]
}

// MARK: - History Data
struct HistoryData: Codable, Hashable {
    let _id: String
    let type: String
    let title: String
    let description: String
    let images: [String]?
    let campuses: [Campus]?
    let chapels: [Chapel]?
    let __v: Int
}

// MARK: - Campus
struct Campus: Codable, Hashable {
    let name: String
    let description: String
    let location: String?
    let images: [String]?
    let link: String
    let _id: String
}

// MARK: - Chapel
struct Chapel: Codable, Hashable {
    let name: String
    let location: String?
    let description: String
    let images: [String]?
    let link: String
    let _id: String
}
