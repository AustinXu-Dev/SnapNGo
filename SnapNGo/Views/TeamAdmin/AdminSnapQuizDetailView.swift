//
//  AdminSnapQuizDetailView.swift
//  SnapNGo
//
//  Created by Austin Xu on 24/02/2025.
//

import SwiftUI

struct AdminSnapQuizDetailView: View {
    
    var snapQuizData: SnapQuiz
    var questionNo: Int
    var hint: String
    
    @State private var vStackHeight: CGFloat = 0
    @State private var image: UIImage?
        @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: Constants.LayoutPadding.medium){
                    
                    LineView()
                    Spacer()
                        .frame(height: 40)
                    
                    quizQuestionView
                    
                    Text("Snap Quiz Answer")
                        .heading1()

                    Image(snapQuizData.quizName)
                        .resizable()
                        .frame(width: 299, height: 299)
                        .scaledToFill()
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .navigationTitle("Snap Time")
    }
    
    private var quizQuestionView: some View{
        ZStack{
            Image("snap_icon")
                .resizable()
                .frame(width: 80, height: 80)
                .offset(y: -vStackHeight / 2)
                .zIndex(1)
            
            VStack(alignment: .center, spacing: 8){
                Spacer()
                    .frame(height: 40)
                Text("Snap Quiz \(questionNo)")
                    .heading1()
                Text("Capture the image of \(snapQuizData.quizName).")
                    .multilineTextAlignment(.center)
                    .lineLimit(5)
                    .body1()
                Text("hint: It can be found \(hint)")
                    .multilineTextAlignment(.center)
                    .body1()
                    .frame(width: 200)
                Spacer()
                    .frame(height: 20)
            }
            .frame(maxWidth: .infinity, minHeight: 100)

            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            vStackHeight = geometry.size.height
                        }
                        .onChange(of: geometry.size.height) { _, newHeight in
                            vStackHeight = newHeight
                        }
                }.background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                )
            )
        }
        .frame(maxWidth: .infinity)
    }
}
