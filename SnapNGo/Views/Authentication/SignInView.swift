//
//  SignInView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/7.
//

import SwiftUI

struct SignInView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @ObservedObject var googleVM = GoogleAuthViewModel()
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue

    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 5){
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            emailField
            .padding(.top, 10)


            passwordField
            .padding(.top, 10)
            
            Button{
                // Sign in
            } label: {
                Text(Constants.AuthenticationViewConstant.signInText)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .frame(height: 36)
                    .background(Color.accentColor)
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 8)
            .padding(.top, 16)
            
            lineDivider
            .padding(.vertical, 20)
            
            Button {
                googleVM.signInWithGoogle(presenting: Application_utility.rootViewController) { error, isNewUser in
                    
                }
            } label: {
                Image("continue_with_google")
            }
            
            Button {
                userAppState = AppState.signedIn.rawValue
            } label: {
                Text("change")
            }

            HStack{
                Text(Constants.AuthenticationViewConstant.noAccountText)
                    .font(.system(size: 12))
                Button {
                    print("Go to sign up page")
                } label: {
                    Text(Constants.AuthenticationViewConstant.signUpText)
                        .font(.system(size: 12))
                        .underline()
                }

            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 8)
        .background(ColorConstants.background)
        .onTapGesture {
            isFocused = false
        }
    }
    
    // MARK: - Email
    private var emailField: some View{
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.AuthenticationViewConstant.emailTitle)
                .font(.headline)
                .padding(.horizontal, 0)
            
            TextField(Constants.AuthenticationViewConstant.emailPlaceholder, text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .frame(width: 361, height: 41.49)
                .background(Color.white)
                .cornerRadius(8)
                .focused($isFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(ColorConstants.textfield_stroke_color, lineWidth: 1)
                )
        }
    }
    
    //MARK: - Password
    private var passwordField: some View{
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.AuthenticationViewConstant.passwordTitle)
                .font(.headline)
                .padding(.horizontal, 0)
            
            TextField(Constants.AuthenticationViewConstant.passwordPlaceholder, text: $password)
                .autocapitalization(.none)
                .padding()
                .frame(width: 361, height: 41.49)
                .background(Color.white)
                .cornerRadius(8)
                .focused($isFocused)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(ColorConstants.textfield_stroke_color, lineWidth: 1)
                )
        }

    }
    
    private var lineDivider: some View{
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.accentColor)
            
            Text("or")
                .foregroundColor(Color.accentColor)
                .padding(.horizontal, 8)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.accentColor)
        }
        .frame(width: 361)
    }
}

#Preview {
    SignInView()
}
