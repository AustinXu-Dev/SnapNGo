//
//  EditProfilePicView.swift
//  SnapNGo
//
//  Created by Austin Xu on 17/02/2025.
//

import SwiftUI



struct EditProfilePicView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @StateObject var equipItemVM = EquipItemViewModel()
    
    @State private var selectedFaceID: String? = nil
    @State private var selectedHairID: String? = nil
    @State private var selectedFaceName: String? = nil
    @State private var selectedHairName: String? = nil

    @State var profileImage: String
    @State private var showEquipAlert = false
    @State private var showSuccessAlert = false
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack{
            ScrollView{
                // Profile
                VStack{
                    ZStack{
                        Circle()
                            .foregroundStyle(.shopCardBackground)
                        Image(profileImage)
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 220)
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                
                LineView()
                
                // Inventory
                VStack(alignment: .leading) {
                    Text("Inventory")
                        .heading2()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(getOneUserVM.inventoryItems, id: \.self) { item in
                            //MARK: - Showing the inventory items
                            let isSelected = (item.itemInfo.category == "Face" && selectedFaceID == item.itemId) ||
                            (item.itemInfo.category == "Hair" && selectedHairID == item.itemId)
                            
                            InventoryCardView(itemName: item.itemInfo.name)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    onTapItem(category: item.itemInfo.category, itemId: item.itemId, itemName: item.itemInfo.name.lowercased())
                                }
                        }
                    }
                    
                    Button {
                        showEquipAlert = true
                    } label: {
                        Text("Done")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical, Constants.LayoutPadding.medium)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Constants.LayoutPadding.medium)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if equipItemVM.isLoading{
                loadingBoxView(message: "Equipping Item...")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .alert("Are you sure you want to equip item(s)?", isPresented: $showEquipAlert) {
            Button("Cancel", role: .cancel) {}
            Button("OK") {
                let selectedIDs = [selectedHairID, selectedFaceID].compactMap { $0 }
                equipItemVM.equipItem(userId: getOneUserVM.userId, itemIds: selectedIDs)
            }
        }
        .alert("Item Equipped Successfully!", isPresented: $showSuccessAlert) {
            Button("OK") {
                userDataAPICall()
                AppCoordinator.pop()
            }
        }
        .onReceive(equipItemVM.$isSuccess) { output in
            if output{
                showSuccessAlert = true
            }
        }
    }
    
    private func onTapItem(category: String, itemId: String, itemName: String){
        switch category{
        case "Face":
            selectedFaceID = (selectedFaceID == itemId) ? nil : itemId
            selectedFaceName = (selectedFaceName == itemName) ? nil : itemName
        case "Hair":
            selectedHairID = (selectedHairID == itemId) ? nil : itemId
            selectedHairName = (selectedHairName == itemName) ? nil : itemName
        default:
            break
        }

        DispatchQueue.main.async {
            profileImage = getOneUserVM.userGender.lowercased() + (selectedHairName.map { "_\($0)" } ?? "") + (selectedFaceName.map { "_\($0)" } ?? "")
        }

    }
    
    private func userDataAPICall(){
        guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
            print("Error here")
            return
        }
        getOneUserVM.getOneUser(userId: userId)
    }
}
