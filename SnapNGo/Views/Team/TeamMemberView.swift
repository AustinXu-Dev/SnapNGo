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
            
//            MemberCardView(image: image, memberName: memberName, points: points)
//            MemberCardView(image: image, memberName: memberName, points: points)
//            MemberCardView(image: image, memberName: memberName, points: points)
//            MemberCardView(image: image, memberName: memberName, points: points)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .navigationTitle("Team")
    }
}

#Preview {
    NavigationStack{
        TeamMemberView()
    }
}
