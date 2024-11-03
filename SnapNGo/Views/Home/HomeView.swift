//
//  HomeView.swift
//  SnapNGo
//
//  Created by Austin Xu on 2024/11/1.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack{
                taskSectionView
                
                LineView()
                
                VStack(alignment: .leading){
                    Text("Map")
                        .fontWeight(.semibold)

                    Image("sample")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 150)
                }
                .frame(maxWidth: .infinity, minHeight: 125)
                
                LineView()
                
                VStack(alignment: .leading){
                    HStack {
                        Text("About Us")
                            .fontWeight(.semibold)
                        Spacer()
                        Button {
                            //
                        } label: {
                            Text("View All")
                                .underline()
                                .fontWeight(.semibold)
                        }

                    }

                    Image("sample")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 150)
                }
                .frame(maxWidth: .infinity, minHeight: 125)

            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)

        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack{
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 10)
                    Spacer()
                    Text("Jane Doe")
                }
                .frame(maxWidth: 200)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Image("currency")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Text("1000")
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .offset(x: 14, y: -3)
                    }
            }
        }
        
    }
    
    //MARK: - Task Section View
    private var taskSectionView: some View{
        HStack {
            Image("sample")
                .resizable()
                .frame(width: 125, height: 125) // Set specific dimensions
                .scaledToFill()
                .clipShape(RoundedRectangle(cornerRadius: 10))
            VStack(alignment: .leading) {
                Text(Constants.MyTasks.title)
                    .font(.headline)
                    .foregroundColor(.yellow)
                Text("15 Tasks")
                    .font(.subheadline)
                ProgressView(value: 10, total: 15)
                    .progressViewStyle(LinearProgressViewStyle(tint: .yellow))
                Text("\(Constants.MyTasks.progressLabel) 10/15")
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
    NavigationStack{
        HomeView()
    }
}
