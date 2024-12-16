//
//  MultipleSelectionView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 17/12/2567 BE.
//

import SwiftUI

struct MultipleSelectionView: View {
    // List of options
    let items = ["Option 1", "Option 2", "Option 3", "Option 4"]
    
    // State to track selected items
    @State private var selectedItems: Set<String> = []
    
    var body: some View {
        VStack {
            Text("Select Options")
                .font(.headline)
            
            List(items, id: \.self) { item in
                MultipleSelectionRow(item: item, isSelected: selectedItems.contains(item)) {
                    if selectedItems.contains(item) {
                        selectedItems.remove(item)
                    } else {
                        selectedItems.insert(item)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle()) // Optional styling
            
            // Display selected items
            Text("Selected: \(selectedItems.joined(separator: ", "))")
                .padding()
        }
        .padding()
    }
}

struct MultipleSelectionRow: View {
    let item: String
    let isSelected: Bool
    let toggleSelection: () -> Void
    
    var body: some View {
        HStack {
            Text(item)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .contentShape(Rectangle()) // Makes the whole row tappable
        .onTapGesture {
            toggleSelection()
        }
    }
}

#Preview {
    MultipleSelectionView()
}
