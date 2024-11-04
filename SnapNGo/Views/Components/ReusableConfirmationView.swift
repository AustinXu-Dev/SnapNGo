//
//  ReusableConfirmationView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/4.
//

import Foundation
import SwiftUI

struct ReusableConfirmationView: View{
    var image: String
    var title: String
    var desc: String
    var buttonText: String
    var action: () -> Void
    var body: some View {
        VStack(alignment: .center){
            Image(image)
                .resizable()
                .frame(width: 300, height: 200)
                .aspectRatio(contentMode: .fit)
            Text(title)
                .fontWeight(.semibold)
            Text(desc)
            Button {
                action()
            } label: {
                Text(buttonText)
            }

            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview{
    ReusableConfirmationView(image: "oops_image", title: "Successfuly snap a photo", desc: "click contrinue", buttonText: "Continue") {
        print("hello")
    }
}
