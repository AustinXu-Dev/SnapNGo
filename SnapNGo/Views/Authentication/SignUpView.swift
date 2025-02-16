//
//  SignUpView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/7.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var appCoordinator: AppCoordinatorImpl

    @State var name: String = ""
    @State var gender: String = "Male"
    @State var email: String = ""
    @State var school: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State private var showWarning: Bool = false
    @State private var showAlert: Bool = false
    
    @ObservedObject var googleVM = GoogleAuthViewModel()
    @StateObject var signUpVM = SignUpService()
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack{
            
            ScrollView{
                VStack(alignment: .center, spacing: 5){
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    nameField
                        .padding(.top, 10)
                    
                    emailField
                        .padding(.top, 10)
                    
                    genderField
                        .padding(.top, 10)
                    
                    schoolField
                        .padding(.top, 10)
                    
                    passwordField
                        .padding(.top, 10)
                    
                    confirmPasswordField
                        .padding(.top, 10)
                    
                    Button{
                        // Sign up
                        signUpButtonAction()
                    } label: {
                        Text(Constants.AuthenticationViewConstant.signUpText)
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
                    
                    HStack{
                        Text(Constants.AuthenticationViewConstant.haveAccountText)
                            .font(.system(size: 12))
                        Button {
                            print("Go back to sign in page.")
                            appCoordinator.pop()
                        } label: {
                            Text(Constants.AuthenticationViewConstant.signInText)
                                .font(.system(size: 12))
                                .underline()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 8)
                
                if signUpVM.isLoading{
                    loadingBoxView(message: "Signing up")
                }

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorConstants.background)
            .onTapGesture {
                isFocused = false
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Sign Up Error"),
                    message: Text(signUpVM.errorMessage ?? "An unknown error occurred."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $signUpVM.success) {
                Alert(
                    title: Text("Register Successful"),
                    message: Text("Please Sign in again!"),
                    dismissButton: .default(Text("OK")){
                        appCoordinator.pop()
                    }
                )
            }
        }
    }
    
    private var emailField: some View{
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.AuthenticationViewConstant.emailTitle)
                .font(.headline)
                .padding(.horizontal, 0)
            
            TextField(Constants.AuthenticationViewConstant.emailPlaceholder, text: $email)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
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
    
    private var nameField: some View{
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.AuthenticationViewConstant.nameTitle)
                .font(.headline)
                .padding(.horizontal, 0)
            
            TextField(Constants.AuthenticationViewConstant.namePlaceholder, text: $name)
                .keyboardType(.default)
                .autocorrectionDisabled()
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
    
    private var genderField: some View{
        VStack(alignment: .leading, spacing: 4) {
            Text("Gender")
                .font(.headline)
            
            Picker("Select Gender", selection: $gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 361, height: 41.49)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(ColorConstants.textfield_stroke_color, lineWidth: 1)
            )
        }
    }
    
    private var schoolField: some View{
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.AuthenticationViewConstant.schoolTitle)
                .font(.headline)
                .padding(.horizontal, 0)
            
            TextField(Constants.AuthenticationViewConstant.schoolPlaceholder, text: $school)
                .keyboardType(.default)
                .autocapitalization(.none)
                .autocorrectionDisabled()
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
    
    private var passwordField: some View{
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.AuthenticationViewConstant.passwordTitle)
                .font(.headline)
                .padding(.horizontal, 0)
            
            SecureField(Constants.AuthenticationViewConstant.passwordPlaceholder, text: $password)
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
                .onChange(of: password) { _, _ in
                    validatePasswords()
                }
        }
    }
    
    private var confirmPasswordField: some View{
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.AuthenticationViewConstant.confirmPasswordTitle)
                .font(.headline)
                .padding(.horizontal, 0)
            
            SecureField(Constants.AuthenticationViewConstant.confirmPasswordPlaceholder, text: $confirmPassword)
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
                .onChange(of: confirmPassword) { _, _ in
                    validatePasswords()
                }
            if showWarning {
                Text("Passwords do not match!")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
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
    
    // MARK: - Validation
    private func validatePasswords() {
        showWarning = !password.isEmpty && !confirmPassword.isEmpty && password != confirmPassword
    }
    
    private func signUpButtonAction() -> Void{
        print("in signup button action")
        signUpVM.name = name
        signUpVM.gender = gender.lowercased()
        signUpVM.email = email
        signUpVM.password = confirmPassword
        signUpVM.school = school
        print(signUpVM.name, signUpVM.email, signUpVM.school, signUpVM.password)
        signUpVM.signUp()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if signUpVM.errorMessage != nil {
                showAlert = true
            }
        }
        
    }
}

#Preview {
    SignUpView()
}
