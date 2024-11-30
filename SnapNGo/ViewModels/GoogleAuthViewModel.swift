//
//  GoogleAuthViewModel.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/3.
//

import Foundation
import GoogleSignIn
import Firebase
import FirebaseAuth
import SwiftUI
import Combine

class GoogleAuthViewModel: ObservableObject{
    @Published var errorMessage = ""
    @Published var uid = ""
    @Published var email = ""
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue

    var signInService = SignInService()
    var signUpService = SignUpService()
    var getAllUsersVM = GetAllUsersViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    func signInWithGoogle(presenting: UIViewController, completion: @escaping (Error?, Bool) -> Void) {
        
        guard let clientID = FirebaseManager.shared.firebaseApp?.options.clientID else {
            self.errorMessage = "Missing Firebase Client ID"
            DispatchQueue.main.async {
                completion(NSError(domain: "GoogleAuthError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing Firebase client ID."]), false)
            }
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
            if let error = error {
                self.errorMessage = "Failed to Sign In with instance: \(error)"
                DispatchQueue.main.async {
                    completion(error, false)
                }
                return
            }
            
            guard let user = user?.user, let idToken = user.idToken else {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
                return
            }
            
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            FirebaseManager.shared.auth.signIn(with: credential) { authResult, error in
                if let error = error {
                    self.errorMessage = "Failed to Sign In with credentials: \(error)"
                    DispatchQueue.main.async {
                        completion(error, false)
                    }
                    return
                }
                
                guard let authResult = authResult else {
                    self.errorMessage = "Authentication result is nil: \(String(describing: error))"
                    DispatchQueue.main.async {
                        completion(NSError(domain: "FirebaseAuthError", code: -1, userInfo: nil), false)
                    }
                    return
                }
                
                // For sign up
                self.signUpService.name = authResult.user.displayName ?? "No name"
                self.signUpService.email = authResult.user.email ?? ""
                self.signUpService.password = authResult.user.uid
                self.signUpService.school = ""
                
                // For sign in
                self.signInService.email = authResult.user.email ?? ""
                self.signInService.password = authResult.user.uid
                
                // Get the user details
                self.email = authResult.user.email ?? ""
                self.uid = authResult.user.uid
                
                self.getAllUsersVM.getAllUsers()
                
                let isNewInFirebase = authResult.additionalUserInfo?.isNewUser ?? false
                if isNewInFirebase{
                    print("New user in firebase")
                    print("In view model",self.signUpService.name, self.signUpService.email, self.signUpService.password)
                    self.signUpService.signUp()
                    completion(nil, true)
                } else {
                    self.signInService.signIn()
                    print("User app state is \(self.userAppState)")
                    completion(nil, false)
//                    self.getAllUsersVM.$userData
//                        .sink { [weak self] userData in
//                            guard let self = self, let users = userData else { return }
//                            self.checkIfUserExists(in: users, result: authResult, completion: completion)
//                        }
//                        .store(in: &self.cancellables)
                }
                
            }
        }
    }
    
    private func checkIfUserExists(in users: [User], result: AuthDataResult, completion: @escaping (Error?, Bool) -> Void) {
        var isUserExisting = false
        
        // Loop through users to check if any user's email matches the result user email
        for user in users {
            if user.email == result.user.email {
                isUserExisting = true
                DispatchQueue.main.async {
                    print("Not new user")
                    self.signInService.signIn()
                    print("Arayy User app state is \(self.userAppState)")
                    completion(nil, false) // Returning false for existing user
                }
                break
            }
        }
        
        // If no existing user was found, handle as a new user
        if !isUserExisting {
            DispatchQueue.main.async {
                print("New User But not yet stored in backend")
                print("In view model",self.signUpService.name, self.signUpService.email, self.signUpService.password)
                self.signUpService.signUp()
                self.userAppState = AppState.signedIn.rawValue
                print("No user existing User app state is \(self.userAppState)")
                completion(nil, true) // Returning true for new user
            }
        }
    }

    // Google Sign Out Function
    func signOutWithGoogle() {
        do {
            try FirebaseManager.shared.auth.signOut()
            TokenManager.share.deleteToken()
            KeychainManager.shared.keychain.delete("appUserId")
            DispatchQueue.main.async {
              //MARK: -UserDefaults.standard.set(false, forKey: "appState")
              self.userAppState = AppState.notSignedIn.rawValue
              print("User app state is \(self.userAppState)")
            }
        } catch let signOutError as NSError {
            self.errorMessage = "Failed to sign out with error: \(signOutError)"
        }
    }
}
