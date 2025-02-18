//
//  QuizCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/19.
//

import SwiftUI

struct QuizCardView<ButtonContent: View>: View {
    
    var quizQuestion: String
    var buttonContent: () -> ButtonContent
    
    var body: some View {
        HStack() {
            Image("quiz_icon")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .padding(.horizontal, 8)
            VStack(alignment: .leading) {
                Text(quizQuestion)
                    .font(.headline)
                    .padding(.bottom, 5)
                Text("hint: Answer can be found in \"About Us\" section.")
                    .font(.system(size: 12))
                    .foregroundColor(.black)
                    .lineLimit(5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.leading, 5)
            
            buttonContent()
        }
        .frame(maxWidth: .infinity, maxHeight: 90)
        .padding(.horizontal, 5)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct AdminQuizCardView: View {
    
    var quizQuestion: String
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Image("quiz_icon")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .padding(.horizontal, 8)
            VStack(alignment: .leading) {
                Text(quizQuestion)
                    .font(.headline)
                    .padding(.bottom, 5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(.leading, 5)

            Image(systemName: "chevron.right")
                .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: 90)
        .padding(.horizontal, 5)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
        .onTapGesture {
            action()
        }
    }
}


#Preview {
    QuizCardView(quizQuestion: "What is SnapNGo?") {
        
        Button {
            print("Answer tapped")
        } label: {
            Image("quiz_correct_icon")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
        .frame(width: 95, height: 95)
    }
    QuizCardView(quizQuestion: "What is SnapNGo?") {
        Button {
            print("Answer tapped")
        } label: {
            Text("Answer")
                .font(.footnote)
        }
        .buttonStyle(.borderedProminent)
        .frame(width: 95, height: 80)

    }
}
