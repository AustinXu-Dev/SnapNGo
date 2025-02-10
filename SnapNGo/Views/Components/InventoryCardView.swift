//
//  InventoryCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import SwiftUI

struct InventoryCardView: View {
    let itemId: String
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @StateObject private var viewModel = GetOneItemViewModel()

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
            } else {
                Text("Failed to load item")
                    .foregroundColor(.red)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 124)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 5))
        .onAppear {
            viewModel.getOneItem(itemId: itemId){ item in
                getOneUserVM.userItems.append(item!)
            }
        }
        .onTapGesture {
            print("Equip: \(itemId)")
        }
    }
}
