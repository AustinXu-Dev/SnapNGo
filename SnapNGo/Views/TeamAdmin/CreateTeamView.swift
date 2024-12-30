//
//  CreateTeamView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 17/12/2567 BE.
//

import SwiftUI

struct CreateTeamView: View {
    
    let maxSelections = 5
    
    let locations = ["bba", "ca", "vmes"]
    
    @State private var selectedLocations: Set<String> = []
    @StateObject var createTeamVM = CreateTeamViewModel()
    @StateObject var quizVM = GetQuizViewModel()
    
    var body: some View {
        ScrollView{
            
            Image(Constants.CreateTeamViewConstant.createTeamImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity, height: 200)
            Text(Constants.CreateTeamViewConstant.createTeamSubtitle)
                .body1()
                .multilineTextAlignment(.center)
                .frame(width: 370)
            LineView()
            
            VStack(alignment: .leading) {
                Text(Constants.CreateTeamViewConstant.teamImageTitle)
                    .heading2()
                DropdownMenuDisclosureGroup()
                
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
                    print(selectedLocations)
                    quizVM.fetchQuiz(locations: Array(selectedLocations))
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
}

#Preview {
    CreateTeamView()
}
