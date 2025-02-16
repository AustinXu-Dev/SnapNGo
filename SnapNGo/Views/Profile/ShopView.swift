//
//  ShopView.swift
//  SnapNGo
//
//  Created by Austin Xu on 10/02/2025.
//

import SwiftUI

struct ShopView: View {
    
    @EnvironmentObject var AppCoordinator: AppCoordinatorImpl
    @EnvironmentObject var getOneUserVM: GetOneUserViewModel
    @StateObject var getAllItems = GetAllItemsViewModel()
    
    @State var isLoading: Bool = false
    
    var userId: String
    var userPoints: Int
    
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack{
                    Text("Hair Accessories")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(getAllItems.hairItems, id: \._id) { item in
                            ShopInventoryCardView(userId: userId, itemId: item._id, isLoading: $isLoading)
                        }
                    }
                    
                    LineView()
                    
                    Text("Face Accessories")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(getAllItems.faceItems, id: \._id) { item in
                            ShopInventoryCardView(userId: userId, itemId: item._id, isLoading: $isLoading)
                        }
                    }
                }
                .padding(.all, Constants.LayoutPadding.medium)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if isLoading{
                loadingBoxView(message: "Purchasing item")
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ColorConstants.background)
        .navigationBarBackButtonHidden()
        .safeAreaInset(edge: .top, content: {
            Color.clear
                .frame(height: 45)
        })
        .overlay {
            topOverlayView
        }
        .onAppear {
            getAllItems.getAllItems()
        }
        .refreshable {
            getAllItems.getAllItems()
        }
    }
    
    private var topOverlayView: some View{
        ZStack{
            Color.clear
                .frame(height: 120)
                .background(.ultraThinMaterial)
                .blur(radius: 1)
                .ignoresSafeArea(edges: .top)
            HStack{
                HStack{
                    Button {
                        // Go Back
                        AppCoordinator.pop()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                }
                .frame(maxWidth: 110, alignment: .leading)
                Spacer()

                Text("Shop")
                    .fontWeight(.semibold)
                    .heading1()
                    .padding(.bottom, 10)
                Spacer()
                Image("currency")
                    .resizable()
                    .frame(width: 110, height: 50)
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        Text("\(getOneUserVM.totalPoints)")
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .offset(x: 14, y: -3)
                    }
            }
            .offset(y: -30)
            .padding(.horizontal)
        }.frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ShopView(userId: "", userPoints: 100)
}
