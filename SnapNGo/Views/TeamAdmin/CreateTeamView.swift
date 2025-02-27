//
//  CreateTeamView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 17/12/2567 BE.
//

import SwiftUI

struct CreateTeamView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneAdminVM: GetOneAdminViewModel
    @EnvironmentObject var getCreatedTeamsVM: GetAllCreatedTeamsViewModel
    @StateObject var createTeamVM = CreateTeamViewModel()

    let maxSelections = 5
    let locationMapping: [String: String] = Constants.LocationMapping.locationMapping
    let snapLocationMapping: [String: String] = Constants.SnapLocationMapping.snapLocationMapping
    
    @State private var selectedLocations: Set<String> = []
    @State private var selectedSnapLocations: Set<String> = []
    @State private var errorMessage: String? = nil
    
    var body: some View {
        ZStack{
            ScrollView{
                
                DropdownMenuDisclosureGroup(selectedOption: $createTeamVM.teamImageUrl)
                
                Image(createTeamVM.teamImageUrl.isEmpty ? "image_placeholder" : createTeamVM.teamImageUrl)
                    .resizable()
                    .frame(width: 115, height: 115)
                    .scaledToFit()
                    .cornerRadius(8)
                

                Text(Constants.CreateTeamViewConstant.createTeamSubtitle)
                    .body1()
                    .multilineTextAlignment(.center)
                    .frame(width: 370)
                LineView()
                
                VStack(alignment: .leading) {
                    Text(Constants.CreateTeamViewConstant.teamNameTitle)
                        .heading2()
                    TextField("Please enter a team name", text: $createTeamVM.teamName)
                        .body1()
                        .textFieldStyle(.roundedBorder)
                    
                    Text(Constants.CreateTeamViewConstant.chooseLocationsTitle)
                        .heading2()
                    
                    locationSelectionView
                    
                    Text(Constants.CreateTeamViewConstant.chooseSnapLocationsTitle)
                        .heading2()
                    
                    snapLocationSelectionView
                    
                    Text("Max Members")
                        .heading2()
                    TextField("Enter max members", text: $createTeamVM.maxMember)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    //MARK: - Create Team Button Here
                    Button {
                        createTeamButtonAction()
                    } label: {
                        Text(Constants.CreateTeamViewConstant.createButtonText)
                            .heading2()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical, Constants.LayoutPadding.large)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Constants.LayoutPadding.medium)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorConstants.background)
            
            if createTeamVM.isLoading {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView("Creating team...")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
        }
    }
    
    private func toggleSelection(location: String) {
        if selectedLocations.contains(location) {
            selectedLocations.remove(location)
        } else if selectedLocations.count < maxSelections {
            selectedLocations.insert(location)
        }
    }
    
    private func toggleSnapSelection(location: String) {
        if selectedSnapLocations.contains(location) {
            selectedSnapLocations.remove(location)
        } else if selectedSnapLocations.count < maxSelections {
            selectedSnapLocations.insert(location)
        }
    }
    
    private func createTeamButtonAction() {
        errorMessage = nil
        
        guard !createTeamVM.teamName.isEmpty else {
            errorMessage = "Team name cannot be empty."
            return
        }
        
        guard !createTeamVM.teamImageUrl.isEmpty else {
            print("Please select a team image.")
            return
        }
        
        guard let maxMember = Int(createTeamVM.maxMember),
              maxMember > 0, maxMember <= 30 else {
            errorMessage = "Max members must be a number between 1 and 30."
            return
        }
        
        guard selectedLocations.count > 0 && selectedLocations.count <= maxSelections else {
            errorMessage = "Please select at least 1 and no more than \(maxSelections) locations."
            return
        }
        
        guard selectedSnapLocations.count > 0 && selectedSnapLocations.count <= maxSelections else {
            errorMessage = "Please select at least 1 and no more than \(maxSelections) snap locations."
            return
        }
        
        let internalLocations = selectedLocations.compactMap { locationMapping[$0] }
        let internalSnapLocations = selectedSnapLocations.compactMap { snapLocationMapping[$0] }
        
        createTeamVM.adminEmail = getOneAdminVM.adminEmail
        createTeamVM.assignedQuizzes = internalLocations
        createTeamVM.assignedSnapQuizzes = internalSnapLocations
        
        createTeamVM.createTeam { error in
            guard error == nil else {
                print("Error occurred: \(error!.localizedDescription)")
                return
            }
            getOneAdminVM.getOneAdmin(adminId: createTeamVM.adminId) { _ in
                AppCoordinator.push(.joinQRCode(named: createTeamVM.teamIdResponse!))
            }
        }
    }
    
    private var locationSelectionView: some View {
        VStack {
            ForEach(locationMapping.keys.sorted(), id: \.self) { location in
                HStack {
                    Image(systemName: selectedLocations.contains(location) ? "checkmark.square.fill" : "square")
                        .foregroundColor(selectedLocations.contains(location) ? .blue : .gray)
                    
                    Text(location)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    toggleSelection(location: location)
                }
                .padding(.horizontal, Constants.LayoutPadding.medium)
                .padding(.vertical, Constants.LayoutPadding.small)
            }
            .padding(.vertical, Constants.LayoutPadding.small)
        }
        .background(Color.white)
        .cornerRadius(8)
    }
    
    private var snapLocationSelectionView: some View {
        VStack {
            ForEach(snapLocationMapping.keys.sorted(), id: \.self) { location in
                HStack {
                    Image(systemName: selectedSnapLocations.contains(location) ? "checkmark.square.fill" : "square")
                        .foregroundColor(selectedSnapLocations.contains(location) ? .blue : .gray)
                    
                    Text(location)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    toggleSnapSelection(location: location)
                }
                .padding(.horizontal, Constants.LayoutPadding.medium)
                .padding(.vertical, Constants.LayoutPadding.small)
            }
            .padding(.vertical, Constants.LayoutPadding.small)
        }
        .background(Color.white)
        .cornerRadius(8)
    }
}

#Preview {
    CreateTeamView()
}
