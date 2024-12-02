//
//  FacultyData.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 2/12/2567 BE.
//

import Foundation

struct FacultyData: Codable, Hashable{
    let _id, name: String
    let programs: [String]?
    let location, contact: String
    let socialMedia: Social
    let shortDescription: String
    let longDescription: String
    let abbreviation: String
    let imageLogoName: String
    let locationLat: Double
    let locationLong: Double
    let link: String
    let images: [String]?
    let createdAt: String
    let updatedAt: String
}

struct Social: Codable, Hashable{
    let facebook, instagram, email: String
}
