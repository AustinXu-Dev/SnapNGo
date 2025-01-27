//
//  ProfileView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue
    @ObservedObject var googleVM = GoogleAuthViewModel()
    @State var showAlert: Bool = false

    var body: some View {
        VStack{
            Text("Hello, Profile!")
            
            Button {
                showAlert = true
            } label: {
                Text("sign out")
            }
        }
        .alert("Are you sure you want to sign out?", isPresented: $showAlert) {
            Button("Cancel", role: .destructive) {}
            Button("Ok", role: .cancel) {
                googleVM.signOutWithGoogle()
                
                // Delete username and userId fro UserDefaults
                UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.username)
                UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.userId)
            }
        }


    }
}

#Preview {
    ProfileView()
}
