//
//  SignUpUseCase.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation

class SignUpUseCase: APIManager{
    typealias ModelType = SignUpResponse
    
    var methodPath: String{
        return "/auth/register"
    }
}
