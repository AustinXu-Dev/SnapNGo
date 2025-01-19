//
//  SignInService.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/3.
//

import Foundation
import SwiftUI

class SignInService: ObservableObject{
    
    @Published var email: String
    @Published var password: String
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue
            
    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
    
    func signIn(){
        isLoading = true
        
        let credential = SignInSchema(email: email, password: password)
        
        let signInManager = SignInUseCase()
        
        signInManager.execute(data: credential, getMethod: "POST", token: nil) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    self.isLoading = false
                    // Store the user name in user defaults
                    UserDefaults.standard.set(response.user.name, forKey: Constants.UserDefaultsKeys.username)
                    UserDefaults.standard.set(response.user.id, forKey: Constants.UserDefaultsKeys.userId)
                    if response.user.role == "admin"{
                        self.userAppState = AppState.adminSignedIn.rawValue
                    } else {
                        self.userAppState = AppState.signedIn.rawValue
                    }

                    print(response.message)
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = "Failed to sign in: \(error.localizedDescription)"
                    print(error.localizedDescription)
                }
            }
        }
    }
}
