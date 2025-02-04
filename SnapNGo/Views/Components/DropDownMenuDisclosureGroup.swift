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
    let options = ["team_image_1", "team_image_2", "team_image_3", "team_image_4"]
    let placeholder: String = "Please select an option"
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        DisclosureGroup(selectedOption.isEmpty ? placeholder : selectedOption, isExpanded: $isExpanded) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(options, id: \.self) { option in
                    Image(option)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedOption = option
                            isExpanded = false
                        }
                }
            }
            .padding()
            
        }
        .padding(Constants.LayoutPadding.small)
        .background(Color.white)
        .cornerRadius(8)
    }
}
#Preview {
    DropdownMenuDisclosureGroup(selectedOption: .constant("Image 1"))
}
