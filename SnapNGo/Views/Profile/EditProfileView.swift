//
//  EditProfileView.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var gender: String
    @State private var school = ""
    @State private var showAlert = false
    @State private var showSuccess = false
    
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @StateObject var updateUserVM: UpdateUserViewModel = UpdateUserViewModel()
    
    var userData: User
    
    init(userData: User) {
        self.userData = userData
        _gender = State(initialValue: userData.gender.lowercased())
    }

    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                    .frame(height: 50)
                VStack{
                    HStack{
                        Text("Full Name")
                            .frame(minWidth: 100, alignment: .leading)
                        TextField(userData.name, text: $name)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                    }
                    HStack{
                        Text("Email")
                            .frame(minWidth: 100, alignment: .leading)
                        TextField(userData.email, text: $email)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                    }
                    HStack{
                        Text("Gender")
                            .frame(minWidth: 100, alignment: .leading)
                        Picker("Select Gender", selection: $gender) {
                            Text("Male").tag("male")
                            Text("Female").tag("female")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(maxWidth: .infinity, maxHeight: 41.49)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(ColorConstants.textfield_stroke_color, lineWidth: 1)
                        )
                    }
                    
                    HStack{
                        Text("School")
                            .frame(minWidth: 100, alignment: .leading)
                        TextField(userData.school, text: $school)
                            .textFieldStyle(.roundedBorder)
                            .textInputAutocapitalization(.never)
                    }
                    
                    
                    Button {
                        showAlert = true
                    } label: {
                        Text("Done")
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                .padding(.horizontal, Constants.LayoutPadding.medium)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            if updateUserVM.isLoading {
                loadingBoxView(message: "Updating user...")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.background)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Update Profile"),
                message: Text("Are you sure you want to update your profile?"),
                primaryButton: .default(Text("OK"), action: {
                    doneAction()
                }),
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
        .alert("Profile Updated Successfully!", isPresented: $showSuccess) {
            Button("OK") {
                getOneUserVM.getOneUser(userId: userData._id)
                AppCoordinator.pop()
            }
        }
    }
    
    
    private func doneAction(){
        let updatedName = name.isEmpty ? userData.name : name
        let updatedEmail = email.isEmpty ? userData.email : email
        let updatedGender = gender.isEmpty ? userData.gender : gender.lowercased()
        let updatedSchool = school.isEmpty ? userData.school : school
        
        updateUserVM.updateUser(name: updatedName, email: updatedEmail, school: updatedSchool, gender: updatedGender, userId: getOneUserVM.userId) { user in
            showSuccess = true
            getOneUserVM.userData = user
        }
    }
}
