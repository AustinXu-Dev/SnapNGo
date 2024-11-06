//
//  AboutUsLongCardView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 6/11/2567 BE.
//

import SwiftUI

struct AboutUsLongCardView: View {
    
    var image: String // Image URL or name
    var title: String
    var description: String
    var action:() -> Void
    
    var body: some View {
        HStack(spacing: 5) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 116, height: 136)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 5)
                Text(description)
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .lineLimit(5)
                Spacer()
                Button {
                    action()
                } label: {
                    Text("Explore More")
                        .font(.footnote)
                }.buttonStyle(.borderedProminent)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.leading, 5)
        }
        .frame(width: 370, height: 130)
        .padding(.horizontal, 5)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
    }
}

//#Preview {
//    AboutUsLongCardView()
//}
