//
//  GetQuiz.swift
//  SnapNGo
//
//  Created by Austin Xu on 2567/12/30.
//

import Foundation

class GetQuiz: APIManager{
    typealias ModelType = [QuizGroup]
    
    var locations: [String]
    
    init(locations: [String]){
        self.locations = locations
    }
    
    var methodPath: String{
        let locationQuery = locations.map { "locations=\($0)" }.joined(separator: "&")
        return "/quiz?\(locationQuery)"
    }
}
