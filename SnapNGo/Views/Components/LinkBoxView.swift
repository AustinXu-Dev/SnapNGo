//
//  LinkBoxView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 13/11/2567 BE.
//

import SwiftUI

struct LinkBoxView: View {
    var text: String
    var url: String
    var body: some View {
        VStack{
            Text(text)
                .body2()
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
                .padding(Constants.LayoutPadding.medium)
            Link(url, destination: URL(string: url)!)
                .heading3()
        }
        .frame(minWidth: 370, minHeight: 44)
        .background(RoundedRectangle(cornerRadius: 8).fill(.white))
    }
}

#Preview {
    LinkBoxView(text: "Check out our school website for detailed infos :", url: "https://www.au.edu/about-au")
}
