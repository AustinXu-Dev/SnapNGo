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
    let options = ["Image 1", "Image 2", "Image 3"]
    
    var body: some View {
        DisclosureGroup(selectedOption, isExpanded: $isExpanded) {
            VStack {
                ForEach(options, id: \.self) { option in
                    Text(option)
                        .body1()
                        .padding()
                        .onTapGesture {
                            selectedOption = option
                            isExpanded = false
                        }
                }
            }
        }
        .tint(Color.gray.opacity(0.5))
        .padding(Constants.LayoutPadding.small)
        .background(Color.white)
        .cornerRadius(8)
    }
}
#Preview {
    DropdownMenuDisclosureGroup(selectedOption: .constant("Image 1"))
}
