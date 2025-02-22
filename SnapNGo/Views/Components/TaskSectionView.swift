//
//  TaskSectionView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2568/1/19.
//

import SwiftUI

struct TaskSectionView: View {
    
    @EnvironmentObject var taskSectionVM: TaskSectionViewModel
    
    var body: some View {
        HStack {
            Image(taskSectionVM.teamImage.isEmpty ? "team_image_1" : taskSectionVM.teamImage)
                .resizable()
                .frame(width: 110, height: 110)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.all, 4)
            VStack(alignment: .leading) {
                Text(taskSectionVM.teamName)
                    .font(.headline)
                    .foregroundColor(.accent)
                Text("\(taskSectionVM.getTotalTasks())")
                    .font(.subheadline)
                ProgressView(value: Float(taskSectionVM.getCompletedTasks()), total: Float(taskSectionVM.getTotalTasks()))
                    .progressViewStyle(LinearProgressViewStyle(tint: .accent))
                Text("\(Constants.MyTasks.progressLabel) \(taskSectionVM.getCompletedTasks())/\(taskSectionVM.getTotalTasks())")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 10)
            .background(Color.white)
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
        .frame(maxWidth: .infinity, maxHeight: 125)
    }
}

#Preview {
    TaskSectionView()
}

