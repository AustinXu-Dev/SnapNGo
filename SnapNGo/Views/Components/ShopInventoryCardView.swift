//
//  ShopInventoryCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 10/02/2025.
//

import Foundation
import SwiftUI

struct ShopInventoryCardView: View {
    
    let userId: String
    let itemId: String
    @Binding var isLoading: Bool
    
    @StateObject private var viewModel = GetOneItemViewModel()
    @StateObject var purchaseItemVM = PurchaseItemViewModel()
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    
    @State private var showConfirmationAlert = false
    @State private var showResultAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(Color.shopCardBackground)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .padding(Constants.LayoutPadding.small)
                if viewModel.isLoading {
                    ProgressView()
                } else if let item = viewModel.item{
                    Image(item.name.lowercased())
                        .resizable()
                        .frame(height: 100)
                        .scaledToFit()
                }
            }
            if viewModel.isLoading {
                ProgressView()
            } else if let item = viewModel.item {
                Text(item.name)
                    .font(.body)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Text("\(item.price) pts")
                    .font(.body)
                    .foregroundColor(Color.shopItemPrice)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else {
                Text("Failed to load item")
                    .foregroundColor(.red)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 134)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 5))
        .onAppear {
            viewModel.getOneItem(itemId: itemId){ _ in }
        }
        .onTapGesture {
            showConfirmationAlert = true
        }
        .alert("Confirm Purchase", isPresented: $showConfirmationAlert) {
            Button("Cancel", role: .cancel) {} // ❌ Cancel button
            Button("Confirm") { // ✅ Confirm purchase
                isLoading = true
                purchaseItemVM.purchaseItem(userId: userId, itemId: itemId, quantity: 1){
                }
            }
        } message: {
            Text("Are you sure you want to purchase this item?")
        }
        .onReceive(purchaseItemVM.$isSuccess) { success in
            if success {
                getOneUserVM.getOneUser(userId: userId)
                alertMessage = "Purchase successful!"
                isLoading = false
                showResultAlert = true
                
            }
        }
        .onReceive(purchaseItemVM.$purchaseFailed) { failed in
            if failed {
                alertMessage = "Purchase failed. Please try again."
                isLoading = false
                showResultAlert = true
            }
        }
        .alert("Purchase Status", isPresented: $showResultAlert) {
            Button("OK", role: .cancel) {} // ✅ OK button to dismiss
        } message: {
            Text(alertMessage)
        }
    }
}
