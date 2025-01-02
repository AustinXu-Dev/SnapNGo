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
    let locations = ["msme", "ca", "vmes"]
    
    @State private var selectedLocations: Set<String> = []
    @StateObject var createTeamVM = CreateTeamViewModel()
    @StateObject var quizVM = GetQuizViewModel()
    
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
                        ForEach(locations, id: \.self) { location in
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
        quizVM.fetchQuiz(locations: Array(selectedLocations)) { error in
            guard error == nil else {
                print("Error occurred: \(error!.localizedDescription)")
                return
            }
            
            // Check if the team already exists
            if createTeamVM.teamIdResponse != nil {
                // Team already created, navigate to the QR view
                let joinLink = "https://snap-n-go.vercel.app/api/team/join?teamId=\(createTeamVM.teamIdResponse!)"
                AppCoordinator.push(.joinQRCode(named: joinLink))
                return
            }

            guard let userName = UserDefaults.standard.string(forKey: "userName") else {
                print("No user name found.")
                return
            }
            
            createTeamVM.adminUsername = userName
            createTeamVM.assignedQuizzes = quizVM.quizzesId
            
            createTeamVM.createTeam { error in
                guard error == nil else {
                    print("Error occurred: \(error!.localizedDescription)")
                    return
                }
                
                let joinLink = "https://snap-n-go.vercel.app/api/team/join?teamId=\(createTeamVM.teamIdResponse!)"
                AppCoordinator.push(.joinQRCode(named: joinLink))
            }
        }
    }

}

#Preview {
    CreateTeamView()
}
