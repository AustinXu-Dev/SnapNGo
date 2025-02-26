//
//  LeaderboardTest.swift
//  SnapNGo
//
//  Created by Austin Xu on 27/02/2025.
//

import SwiftUI

struct LeaderboardTest: View {
    var body: some View {
        ZStack{
            leaderboardTopOverlayView
            ScrollView{
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.accent)
                    .padding(.vertical, 8)
                VStack{
                    HStack{
                        VStack{
                            Spacer()
                            Text("2")
                            Circle()
                                .frame(width: 80, height: 80)
                            Text("1100")
                            Text("Member 1")

                        }
                        .frame(maxHeight: .infinity)
                        Spacer()

                        VStack{
                            Text("1")
                            Circle()
                                .frame(width: 80, height: 80)
                            Text("1100")
                            Text("Member 1")
                            Spacer()
                        }
                        .frame(maxHeight: .infinity)
                        Spacer()

                        VStack{
                            Spacer()
                            Text("3")
                            Circle()
                                .frame(width: 80, height: 80)
                            Text("1100")
                            Text("Member 1")
                        }
                        .frame(maxHeight: .infinity)

                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(Constants.LayoutPadding.large)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 280)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(ColorConstants.background)
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 40)
        })
        .overlay{
            topOverlayView
        }
        
    }
    
    private var leaderboardTopOverlayView: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.white, location: 0.0),
                            .init(color: Color.accentColor, location: 0.7)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(height: 450)
                .clipShape(
                    RoundedCornerShape(radius: 60, corners: [.bottomLeft, .bottomRight])
                )
                .ignoresSafeArea(edges: .top)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .zIndex(-10)
    }

    
    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 100)
                .ignoresSafeArea(edges: .all)
            
            HStack{
                Text("Team 1")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .heading1()
            }
            .frame(maxWidth: .infinity)
            .offset(y: -30)
            .padding(.horizontal)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .zIndex(-3)
    }
}

#Preview {
    LeaderboardTest()
}

struct RoundedCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
