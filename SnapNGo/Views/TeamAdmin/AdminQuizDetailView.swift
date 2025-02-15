//
//  AdminQuizDetailView.swift
//  SnapNGo
//
//  Created by Austin Xu on 13/02/2025.
//

import SwiftUI

struct AdminQuizDetailView: View {
    
    var quizData: Quiz
    var questionNo: Int

    @State private var vStackHeight: CGFloat = 0
    @State private var showResult: Bool = false
        
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: Constants.LayoutPadding.small){
                    LineView()
                    Spacer()
                        .frame(height: 40)
                    quizQuestionView
                    
                    optionsView
                    
                }
                .padding(.horizontal, 16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .navigationTitle("Quiz Time")
        .onAppear{
            print(quizData)
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
                Text("Question \(questionNo)")
                    .heading1()
                Text(quizData.question)
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
    
    private var optionsView: some View{
        ForEach(0..<quizData.options.count, id: \.self) { index in
            Button(action: {
                
            }) {
                Text(quizData.options[index])
                    .foregroundColor(.accent)
                    .heading2()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding()
                    .background(borderColor(for: index))
                    .cornerRadius(12)
            }
            .disabled(showResult) // Disable the button after an option is selected
        }
    }
    
    private func borderColor(for index: Int) -> Color {
        if index == quizData.answer {
            return Color("quiz_correct_bg") // Highlight correct answer
        } else {
            return Color.white // Default color for unselected options
        }
    }
    
}
