//
//  InventoryCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import SwiftUI

struct InventoryCardView: View {
    let itemId: String
    @StateObject private var viewModel = GetOneItemViewModel()

    var body: some View {
        VStack(spacing: 0){
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.accent)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .padding(Constants.LayoutPadding.small)
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
        .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
        .onAppear {
            viewModel.getOneItem(itemId: itemId)
        }
        .onTapGesture {
            print("Equip: \(itemId)")
        }
    }
}
