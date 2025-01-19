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
            Image("sample")
                .resizable()
                .frame(width: 125, height: 125) // Set specific dimensions
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text(Constants.MyTasks.title)
                    .font(.headline)
                    .foregroundColor(.accent)
                Text("\(taskSectionVM.completedTasks)")
                    .font(.subheadline)
                ProgressView(value: Float(taskSectionVM.completedTasks), total: Float(taskSectionVM.totalTasks))
                    .progressViewStyle(LinearProgressViewStyle(tint: .accent))
                Text("\(Constants.MyTasks.progressLabel) \(taskSectionVM.completedTasks)/\(taskSectionVM.totalTasks)")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 10)
            .background(Color.white)
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(.white))
        .frame(minWidth: 300, minHeight: 125)
    }
}

#Preview {
    TaskSectionView()
}

