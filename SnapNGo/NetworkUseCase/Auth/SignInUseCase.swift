//
//  SignInUseCase.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/3.
//

import Foundation

class SignInUseCase: APIManager{
    typealias ModelType = SignInResponse
    
    var methodPath: String{
        return "/auth/login"
    }
}
