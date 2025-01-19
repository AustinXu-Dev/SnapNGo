//
//  QuizCardView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/19.
//

import SwiftUI

struct QuizCardView: View {
    
    var quizQuestion: String
    var action:() -> Void

    var body: some View {
        HStack(spacing: 5) {
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
            
            Button {
                action()
            } label: {
                Text("Answer")
                    .font(.footnote)
            }
            .buttonStyle(.borderedProminent)
            .padding(.trailing, 8)

        }
        .frame(maxWidth: .infinity, maxHeight: 90)
        .padding(.horizontal, 5)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    QuizCardView(quizQuestion: "", action: {})
}
