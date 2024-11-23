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

    var body: some View {
        VStack{
            Text("Hello, Profile!")
            
            Button {
                googleVM.signOutWithGoogle()
            } label: {
                Text("sign out")
            }
        }

    }
}

#Preview {
    ProfileView()
}
