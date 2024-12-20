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
    @Published var school: String = ""
    @Published var errorMessage: String? = nil
    @Published var success: Bool = false
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue
    
    init(name: String = "", email: String = "", password: String = "", school: String = "") {
        self.name = name
        self.email = email
        self.password = password
        self.school = school
        self.errorMessage = errorMessage
    }

    func signUp() {
        let newUser = SignUpSchema(name: name, email: email, password: password, school: school)
        
        let signUpManager = SignUpUseCase()
        
        signUpManager.execute(data: newUser, getMethod: "POST", token: nil) { result in
            DispatchQueue.main.async{
                switch result{
                case .success(_):
                    print("Signup successful")
                    self.success = true
                case .failure(let error):
                    if let urlError = error as? URLError, urlError.code == .badServerResponse {
                        if let responseData = try? JSONDecoder().decode(ServerError.self, from: Data(error.localizedDescription.utf8)) {
                            self.errorMessage = responseData.message
                        } else {
                            self.errorMessage = "An unknown error occurred."
                        }
                    } else {
                        self.errorMessage = error.localizedDescription
                    }
                    print("Failed to sign up: \(self.errorMessage ?? "Unknown error")")
                }
            }
        }
    }
    
    
}
