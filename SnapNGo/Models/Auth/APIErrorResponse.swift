//
//  ServerError.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 30/11/2567 BE.
//

import Foundation

struct APIErrorResponse: Codable, Error{
    let message: String
}
