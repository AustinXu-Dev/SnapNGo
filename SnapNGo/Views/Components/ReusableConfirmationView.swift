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
                .aspectRatio(contentMode: .fit)
                .padding(.bottom, 8)
            Text(title)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
            Text(desc)
                .frame(width: 280)
                .multilineTextAlignment(.center)
                .fontWeight(.light)
                .padding(.bottom, 8)
            Button {
                action()
            } label: {
                Text(buttonText)
                    .frame(width: 300)
            }
            .buttonStyle(.borderedProminent)
                        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
    }
}

#Preview{
    ReusableConfirmationView(image: "yay_human_image", title: "Successfuly snap a photo", desc: "Try Retaking Photo. Do not upload from your image folder.", buttonText: "Continue") {
        print("hello")
    }
}
