//
//  QuizDetailView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import SwiftUI

struct QuizDetailView: View {
    
    var quizData: Quiz
    @State private var vStackHeight: CGFloat = 0
    @State private var selectedOption: Int? = nil // Tracks the selected option
    @State private var showResult: Bool = false // Show the feedback
    
    @StateObject private var quizCompletionVM = QuizCompletionViewModel()
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: Constants.LayoutPadding.small){
                    LineView()
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
                    
                    optionsView
                    
                    if let selectedOption = selectedOption{
                        Text(selectedOption == quizData.answer ? "Yay! You answered it correctly!" : "Opps! You answered it wrong!")
                    }
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
                Text("Question1")
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
                selectedOption = index
                showResult = true
            }) {
                Text(quizData.options[index])
                    .foregroundColor(.blue)
                    .heading2()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(borderColor(for: index), lineWidth: 3)
                    )
            }
            .disabled(showResult) // Disable the button after an option is selected
        }
    }
    private func borderColor(for index: Int) -> Color {
        if showResult {
            if index == quizData.answer {
                return .green // Highlight correct answer
            } else if index == selectedOption {
                return .red // Highlight wrong answer
            }
        }
        return Color.clear // Default color for unselected options
    }
}

#Preview {
    TabView{
        QuizDetailView(quizData: Quiz(question: "", options: [], answer: 1, rewardPoints: 10, _id: ""))
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
    }
}
