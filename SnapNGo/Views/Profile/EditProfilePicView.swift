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
    @StateObject var unequipItemVM = UnequipItemsViewModel()
    
    @State private var selectedFaceID: String? = nil
    @State private var selectedHairID: String? = nil
    @State private var selectedFaceName: String? = nil
    @State private var selectedHairName: String? = nil
    @State private var alertTitle = ""

    @State var profileImage: String
    @State private var showEquipAlert = false
    @State private var showUnequipAlert = false
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
                        
                    if getOneUserVM.inventoryItems.isEmpty {
                        Text("You currently have no items in inventory.")
                            .body1()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, Constants.LayoutPadding.small)
                    } else {
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
                            doneButtonAction()
                        } label: {
                            Text("Done")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.vertical, Constants.LayoutPadding.medium)
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Constants.LayoutPadding.medium)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if equipItemVM.isLoading{
                loadingBoxView(message: "Equipping Item...")
            }
            if unequipItemVM.isLoading{
                loadingBoxView(message: "Unequipping Item...")
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
        .alert("Are you sure you want to unequip item(s)?", isPresented: $showUnequipAlert) {
            Button("Cancel", role: .cancel) {}
            Button("OK") {
                unequipItemVM.unequipItems(userId: getOneUserVM.userId)
            }
        }
        .alert(alertTitle, isPresented: $showSuccessAlert) {
            Button("OK") {
                userDataAPICall()
                AppCoordinator.pop()
            }
        }
        .onReceive(unequipItemVM.$isSuccess, perform: { output in
            if output{
                alertTitle = "Unequip Items Successfully!"
                showSuccessAlert = true
            }
        })
        .onReceive(equipItemVM.$isSuccess) { output in
            if output{
                alertTitle = "Item Equipped Successfully!"
                showSuccessAlert = true
            }
        }
        .onAppear {
            selectedFaceID = getOneUserVM.getFaceItemId()
            selectedHairID = getOneUserVM.getHairItemId()
            selectedFaceName = getOneUserVM.getFaceItemName()
            selectedHairName = getOneUserVM.getHairItemName()

        }
    }

    private func onTapItem(category: String, itemId: String, itemName: String) {
        print(itemName, "tapped") // Debugging line to see which item is tapped

        switch category {
        case "Face":
            if selectedFaceID == itemId {
                // Deselect the item if already selected
                selectedFaceID = nil
                selectedFaceName = nil
            } else {
                // Select the new item and maintain hair selection
                selectedFaceID = itemId
                selectedFaceName = itemName
            }
        case "Hair":
            if selectedHairID == itemId {
                // Deselect the item if already selected
                selectedHairID = nil
                selectedHairName = nil
            } else {
                // Select the new item and maintain face selection
                selectedHairID = itemId
                selectedHairName = itemName
            }
        default:
            break
        }

        // Update the profileImage based on the selected items
        DispatchQueue.main.async {
            // Ensure profileImage is updated correctly
            profileImage = getOneUserVM.userGender.lowercased() +
                (selectedHairName.map { "_\($0)" } ?? "") +
                (selectedFaceName.map { "_\($0)" } ?? "")
        }

        print("Updated profileImage: \(profileImage)") // Debugging line to check the updated profileImage
    }

    
    private func userDataAPICall(){
        guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
            print("Error here")
            return
        }
        getOneUserVM.getOneUser(userId: userId)
    }
    
    private func doneButtonAction(){
        if selectedFaceID == nil && selectedHairID == nil {
            showUnequipAlert = true
        } else {
            showEquipAlert = true
        }
    }
}
