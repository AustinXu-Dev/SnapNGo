//
//  QuizDetailView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import SwiftUI

struct QuizDetailView: View {
    
    @State private var vStackHeight: CGFloat = 0
    
    @StateObject private var quizCompletionVM = QuizCompletionViewModel()
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: Constants.LayoutPadding.small){
                    Spacer()
                        .frame(height: 40)
                    quizQuestionView
                    
                    Text("Choose Wisely!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .heading2()
                    //TODO: - Fix Light Font
                    Text("You will not get score if you select incorrect answers")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .body2()
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 45)
        })
        .overlay {
            topOverlayView
        }
    }
    
    
    //MARK: - Components
    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 100)
                .ignoresSafeArea(edges: .top)
            HStack{
                Spacer()
                Text("Quiz Time")
                    .heading1()
                Spacer()
            }
            .offset(y: -30)
            .padding(.horizontal)
            LineView()
        }.frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var quizQuestionView: some View{
        ZStack{
            Image("quiz_question_icon")
                .resizable()
                .frame(width: 80, height: 80)
                .offset(y: -vStackHeight / 2)
                .zIndex(1)
            
            VStack(alignment: .center, spacing: 8){
                Spacer()
                    .frame(height: 40)
                Text("Question1")
                    .heading1()
                Text("Lorem ipsum asdfjlsfjkdfd kjdlkjfldj fldjfldj fldjfdl fjdl f jdl kfj dlfjdlfjdlf jdldfjkd")
                    .multilineTextAlignment(.center)
                    .lineLimit(5)
                    .body1()
                Text("Lorem ipsum asdfjlsfjkdfd kjdlkjfldj fldjfldj fldjfdl fjdl f jdl kfj dlfjdlfjdlf jdldfjkd")
                    .multilineTextAlignment(.center)
                    .lineLimit(5)
                    .body1()
                Text("hint: Answer can be found in \"About Us\" section.")
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

#Preview {
    TabView{
        QuizDetailView()
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
    }
}
