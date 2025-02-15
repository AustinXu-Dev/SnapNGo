//
//  ProfileView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @AppStorage("appState") private var userAppState: String = AppState.notSignedIn.rawValue
    @ObservedObject var googleVM = GoogleAuthViewModel()
    @StateObject var equipItemVM = EquipItemViewModel()
    
    @State var showAlert: Bool = false
    @State private var showAll = false
    @State private var selectedFaceID: String? = nil
    @State private var selectedHairID: String? = nil
    
    let items = Array(1...10)
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        
        ZStack{
            ScrollView{
                VStack{
                    profilePic
                    
                    LineView()
                    
                    profileDetail
                    
                    LineView()
                    
                    inventorySection
                    
                    LineView()
                    
                    editProfile
                    
                    
                    Button {
                        showAlert = true
                    } label: {
                        Text("Log out")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, Constants.LayoutPadding.large)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, Constants.LayoutPadding.medium)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            if equipItemVM.isLoading{
                loadingBoxView(message: "Equipping item(s)")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 45)
        })
        .overlay {
            topOverlayView
        }
        .refreshable {
            userDataAPICall()
        }
        .alert("Are you sure you want to sign out?", isPresented: $showAlert) {
            Button("Cancel", role: .destructive) {}
            Button("Ok", role: .cancel) {
                googleVM.signOutWithGoogle()
                
                // Delete username and userId fro UserDefaults
                UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.username)
                UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKeys.userId)
                AppCoordinator.selectedTabIndex = .home
            }
        }
        .onAppear {
            print(getOneUserVM.getProfileImage())
        }
        .onReceive(equipItemVM.$isSuccess) { output in
            if output{
                guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
                    print("Error here")
                    return
                }
                getOneUserVM.getOneUser(userId: userId)
            }
        }
    }
    
    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 100)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
            HStack{
                Button {
                    print("hello")
                } label: {
                    Image(systemName: "calendar.badge.plus")
                        .opacity(0)
                }
                Spacer()
                Text("Profile")
                    .heading1()
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
                Button {
                    //MARK: Navigate to shop
                    AppCoordinator.push(.shopView(userId: getOneUserVM.userId, userPoints: getOneUserVM.totalPoints))
                } label: {
                    Image("basket_icon")
                }
            }
            .frame(maxWidth: .infinity)
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var profilePic: some View{
        VStack{
            ZStack{
                Circle()
                    .foregroundStyle(.shopCardBackground)
                Image(getOneUserVM.getProfileImage())
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity, maxHeight: 220)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
    }
    
    private var profileDetail: some View{
        VStack(alignment: .leading) {
            Text(getOneUserVM.userData?.name ?? "John Doe")
                .heading1()
            //            Text(getOneUserVM.teamId ?? "")
            //                .body1()
            //                .foregroundStyle(.accent)
            HStack{
                Image("tabler_school")
                Text(getOneUserVM.userData?.school ?? "Assumption University of Thailand")
                    .body1()
            }
            HStack{
                Image("profile_email_icon")
                Text(getOneUserVM.userData?.email ?? "uXXXXXX@au.edu")
                    .body1()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var editProfile: some View{
        HStack{
            Text("Edit User Profile")
                .body1()
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            if let userData = getOneUserVM.userData{
                AppCoordinator.push(.editProfile(named: userData))
            } else {
                userDataAPICall()
            }
        }
    }
    
    private var inventorySection: some View{
        VStack(alignment: .leading) {
            HStack{
                Text("Inventory")
                    .heading2()
                
                Spacer()
                
                Button {
                    let selectedIDs = [selectedHairID, selectedFaceID].compactMap { $0 }
                    equipItemVM.equipItem(userId: getOneUserVM.userId, itemIds: selectedIDs)
                } label: {
                    Text("Equip")
                }


            }
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(showAll ? getOneUserVM.inventoryItems : Array(getOneUserVM.inventoryItems.prefix(4)), id: \.self) { item in
                    //MARK: - Showing the inventory items
                    let isSelected = (item.itemInfo.category == "Face" && selectedFaceID == item.itemId) ||
                    (item.itemInfo.category == "Hair" && selectedHairID == item.itemId)
                    
                    InventoryCardView(itemName: item.itemInfo.name)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            onTapItem(category: item.itemInfo.category, itemId: item.itemId)
                        }
                }
            }
            
            if getOneUserVM.inventoryItems.count > 4 {
                showAllButton
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func onTapItem(category: String, itemId: String){
        switch category{
        case "Face":
            selectedFaceID = (selectedFaceID == itemId) ? nil : itemId
        case "Hair":
            selectedHairID = (selectedHairID == itemId) ? nil : itemId
        default:
            break
        }
    }
    
    private var showAllButton: some View{
        Button(action: {
            withAnimation {
                showAll.toggle()
            }
        }) {
            Text(showAll ? "See Less" : "See More")
                .font(.headline)
                .foregroundColor(.blue)
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

#Preview {
    ProfileView()
}
