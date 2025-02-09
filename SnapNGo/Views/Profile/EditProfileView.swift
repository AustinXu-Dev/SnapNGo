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
    @State private var school = ""
    @State private var showAlert = false
    
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @StateObject var updateUserVM: UpdateUserViewModel = UpdateUserViewModel()
    
    var userData: User
    
    var body: some View {
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
    }
    
    
    private func doneAction(){
        let updatedName = name.isEmpty ? userData.name : name
        let updatedEmail = email.isEmpty ? userData.email : email
        let updatedSchool = school.isEmpty ? userData.school : school
        
        updateUserVM.updateUser(name: updatedName, email: updatedEmail, school: updatedSchool, userId: getOneUserVM.userId) { user in
           getOneUserVM.userData = user
           AppCoordinator.pop()
        }
    }
}
