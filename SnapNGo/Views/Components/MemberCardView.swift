//
//  MemberCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/19.
//

import SwiftUI

struct MemberCardView: View{
    let image: String
    let memberName: String
    let points: Int
    
    var body: some View{
        HStack{
//            RoundedRectangle(cornerRadius: 5)
//                .frame(width: 66, height: 66)
//                .foregroundStyle(.blue)
            
            Image(image)
                .resizable()
                .frame(width: 66, height: 66)
                .scaledToFit()
                .cornerRadius(5)
                .padding(Constants.LayoutPadding.xsmall)
            VStack(alignment: .leading){
                Text(memberName)
                    .font(.headline)
                    .lineLimit(2)
                Text("Member")
                    .fontWeight(.light)
            }
            Spacer()
            VStack{
                Text("\(points) pts")
                    .foregroundStyle(Color.accentColor)
                Spacer()
            }
            .padding(.trailing, Constants.LayoutPadding.small)
            .padding(.top, Constants.LayoutPadding.small)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 74)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.white)
        )
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

//#Preview {
//    MemberCardView()
//}
