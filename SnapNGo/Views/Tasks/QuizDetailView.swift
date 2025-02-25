//
//  QuizDetailView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/20.
//

import SwiftUI

struct QuizDetailView: View {
    
    var taskId: String
    var questionNo: Int
    var quizData: Quiz
    var statusData: StatusModel
    @State private var vStackHeight: CGFloat = 0
    @State private var selectedOption: Int? = nil
    @State private var showResult: Bool = false
    
    @StateObject private var quizCompletionVM = QuizCompletionViewModel()
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: Constants.LayoutPadding.small){
                    LineView()
                    Spacer()
                        .frame(height: 40)
                    quizQuestionView
                        .padding(.bottom, Constants.LayoutPadding.small)
                    Text("Choose Wisely!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .heading2()
                    //TODO: - Fix Light Font
                    Text("You will not get score if you select incorrect answers")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .body2()
                        .padding(.bottom, Constants.LayoutPadding.medium)

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
            if let answer = statusData.userAnswerNumber{
                selectedOption = answer
                showResult = true
            } else {
                selectedOption = nil
            }
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
                selectedOption = index
                showResult = true
                
                //MARK: - Submit Answer to API
                submitAnswer(selectedAnswer: index)
                
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
        if showResult {
            if index == quizData.answer {
                return Color("quiz_correct_bg") // Highlight correct answer
            } else if index == selectedOption {
                return Color("quiz_wrong_bg") // Highlight wrong answer
            }
        }
        return Color.white // Default color for unselected options
    }
    
    private func submitAnswer(selectedAnswer: Int){
        guard let userId = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.userId) else {
            print("Error here")
            return
        }
        
        quizCompletionVM.checkQuizAnswer(forUserId: userId, forTaskId: taskId, withAnswer: selectedAnswer) { error in
            if error != nil{
                print(error?.localizedDescription as Any)
            }
        }
        self.getOneUserVM.userData = quizCompletionVM.userData

    }
}

#Preview {
    TabView{
        QuizDetailView(taskId: "", questionNo: 1, quizData: Quiz(question: "", options: [], answer: 1, rewardPoints: 10, _id: ""), statusData: StatusModel(type: "", isFinished: false, isAnswerCorrect: false, userAnswerNumber: 1))
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
    }
}
