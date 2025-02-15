//
//  DropDownMenuDisclosureGroup.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 17/12/2567 BE.
//

import SwiftUI

struct DropdownMenuDisclosureGroup: View {
    @State private var isExpanded: Bool = false
    @Binding var selectedOption: String
    let options = ["team_image_1", "team_image_2", "team_image_3", "team_image_4", "team_image_5", "team_image_6"]
    let placeholder: String = "Choose Team Image"
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        DisclosureGroup(selectedOption.isEmpty ? placeholder : placeholder, isExpanded: $isExpanded) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(options, id: \.self) { option in
                    Image(option)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                        .onTapGesture {
                            withAnimation {
                                selectedOption = option
                                isExpanded = false
                            }
                        }
                }
            }
        }
        .frame(width: 197)
        .padding(Constants.LayoutPadding.xsmall)
        .background(Color("choose_image_bg"))
        .cornerRadius(8)
    }
}
#Preview {
    DropdownMenuDisclosureGroup(selectedOption: .constant("Image 1"))
}
