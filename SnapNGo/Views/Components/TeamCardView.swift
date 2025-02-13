//
//  TeamCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 12/02/2025.
//

import Foundation
import SwiftUI

struct TeamCardView: View{
    let image: String
    let teamName: String
    let membersCount: Int
    var action: () -> Void
    
    var body: some View{
        HStack{
            Image(image)
                .resizable()
                .frame(width: 66, height: 66)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.all, 5)
            VStack(alignment: .leading){
                Text(teamName)
                    .font(.headline)
                    .lineLimit(2)
                Text("^[\(membersCount) member](inflect: true)")
                    .fontWeight(.light)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 72)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
        )
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .onTapGesture {
            action()
        }
    }
}
