//
//  InventoryCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 09/02/2025.
//

import SwiftUI

struct InventoryCardView: View {
    let number: Int

    var body: some View {
        VStack(spacing: 0){
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.accent)
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .padding(Constants.LayoutPadding.small)
            }
            Text("Card \(number)")
                .font(.body)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 124)
        .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
    }
}
