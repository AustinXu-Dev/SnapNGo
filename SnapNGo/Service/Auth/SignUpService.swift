//
//  SignUpService.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 23/11/2567 BE.
//

import Foundation
import SwiftUI

class SignUpService: ObservableObject{
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue
    
    init(name: String = "", email: String = "", password: String = "") {
        self.name = name
        self.email = email
        self.password = password
        self.errorMessage = errorMessage
    }

    func signUp() {
        let newUser = SignUpSchema(name: name, email: email, password: password)
        
        let signUpManager = SignUpUseCase()
        print("In Sign Up Service: Name=\(name), Email=\(email), Password=\(password)")
        
        signUpManager.execute(data: newUser, getMethod: "POST", token: nil) { result in
            DispatchQueue.main.async{
                switch result{
                case .success(_):
                    print("Signup successful")
                    self.userAppState = AppState.signedIn.rawValue
                case .failure(let error):
                    self.errorMessage = "Failed to sign up: \(error.localizedDescription)"
                    print("Failed to sign up: \(error.localizedDescription)")
                }
            }
        }
    }
}
