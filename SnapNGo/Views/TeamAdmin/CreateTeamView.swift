//
//  CreateTeamView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 17/12/2567 BE.
//

import SwiftUI

struct CreateTeamView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    
    let maxSelections = 5
    let locationMapping: [String: String] = Constants.LocationMapping.locationMapping
    
    @State private var selectedLocations: Set<String> = []
    @State private var errorMessage: String? = nil
    @StateObject var createTeamVM = CreateTeamViewModel()
    
    var body: some View {
        ZStack{
            ScrollView{
                
                Image(Constants.CreateTeamViewConstant.createTeamImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                Text(Constants.CreateTeamViewConstant.createTeamSubtitle)
                    .body1()
                    .multilineTextAlignment(.center)
                    .frame(width: 370)
                LineView()
                
                VStack(alignment: .leading) {
                    Text(Constants.CreateTeamViewConstant.teamNameTitle)
                        .heading2()
                    TextField("Pleae enter a team name", text: $createTeamVM.teamName)
                        .body1()
                        .textFieldStyle(.roundedBorder)
                    
                    Text(Constants.CreateTeamViewConstant.teamImageTitle)
                        .heading2()
                    DropdownMenuDisclosureGroup(selectedOption: $createTeamVM.teamImageUrl)
                    
                    Text(Constants.CreateTeamViewConstant.chooseLocationsTitle)
                        .heading2()
                    
                    VStack{
                        ForEach(locationMapping.keys.sorted(), id: \.self) { location in
                            HStack {
                                Image(systemName: selectedLocations.contains(location) ? "largecircle.fill.circle" : "circle")
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
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    
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
            // Remove if already selected
            selectedLocations.remove(location)
        } else if selectedLocations.count < maxSelections {
            // Add if not selected and under limit
            selectedLocations.insert(location)
        }
    }
    
    private func createTeamButtonAction() {
        errorMessage = nil
        
        // Validation
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
        // Convert the selected display names their internal names
        let internalLocations = selectedLocations.compactMap{ locationMapping[$0]}
        
        guard let userName = UserDefaults.standard.string(forKey: "userName") else {
            print("No user name found.")
            return
        }
        
        createTeamVM.adminUsername = userName
        createTeamVM.assignedQuizzes = internalLocations
        
        createTeamVM.createTeam { error in
            guard error == nil else {
                print("Error occurred: \(error!.localizedDescription)")
                return
            }
            
            AppCoordinator.push(.joinQRCode(named: createTeamVM.teamIdResponse!))
        }
    }
    
}

#Preview {
    CreateTeamView()
}
