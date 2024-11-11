//
//  TeamMemberView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 12/11/2567 BE.
//

import SwiftUI

struct TeamMemberView: View {
    @State var image: String = "Image"
    @State var memberName: String = "John Doe"
    @State var points: Int = 2
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack{
                    Image(Constants.TeamViewConstant.participantIcon)
                    Text("20 Team members")
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, Constants.LayoutPadding.medium)
            
            MemberCardView(image: image, memberName: memberName, points: points)
            MemberCardView(image: image, memberName: memberName, points: points)
            MemberCardView(image: image, memberName: memberName, points: points)
            MemberCardView(image: image, memberName: memberName, points: points)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .navigationTitle("Team")
    }
}

struct MemberCardView: View{
    let image: String
    let memberName: String
    let points: Int
    
    var body: some View{
        HStack(){
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 66, height: 66)
                .foregroundStyle(.blue)
                .padding(Constants.LayoutPadding.xsmall)
            VStack(alignment: .leading){
                Text("Member name")
                    .font(.headline)
                    .lineLimit(2)
                Text("Member")
                    .fontWeight(.light)
            }
            Spacer()
            VStack{
                Text("1200 pts")
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
        .padding(.horizontal, Constants.LayoutPadding.medium)
    }
}

#Preview {
    NavigationStack{
        TeamMemberView()
    }
}
