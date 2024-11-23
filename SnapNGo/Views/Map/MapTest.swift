//
//  MapTest.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 17/11/2567 BE.
//

import SwiftUI

struct MapTest: View {
    @State private var isMapFullScreen = false // State to toggle map size

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Map view
                Image("sample") // Replace with your map or map view
                    .resizable()
                    .scaledToFill()
                    .frame(height: isMapFullScreen ? UIScreen.main.bounds.height : UIScreen.main.bounds.height / 2)
                    .animation(.easeInOut(duration: 0.5), value: isMapFullScreen)
                    .ignoresSafeArea()

                Spacer()
            }

            // Card view at the bottom
            if !isMapFullScreen {
                VStack {
                    Text("Where do you want to go?")
                        .font(.headline)
                        .padding()

                    // Dropdowns or other interactive elements
                    VStack {
                        HStack {
                            Text("Your Location")
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)

                        HStack {
                            Text("CL Building")
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // "Show me the way" button
                    Button(action: {
                        // Toggle the map to full screen
                        withAnimation {
                            isMapFullScreen = true
                        }
                    }) {
                        Text("Show me the way")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                .transition(.move(edge: .bottom)) // Smooth slide-in effect
            }
        }
    }
}
#Preview {
    MapTest()
}
