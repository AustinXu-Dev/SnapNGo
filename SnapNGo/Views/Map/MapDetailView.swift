//
//  MapDetailView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 15/11/2567 BE.
//

import SwiftUI
import MapKit

struct MapDetailView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.611779526627688, longitude: 100.83789503816988),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @State private var isShowingDirections = false

    var body: some View {
        ZStack(alignment: .top) {
            // Map View
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
            
            // Floating Box View
            VStack {
                if !isShowingDirections {
                    Spacer()
                }
                
                VStack(spacing: 16) {
                    Text("Where do you want to go?")
                        .font(.headline)
                        .padding(.top, 8)
                    
                    // Location selection
                    HStack {
                        Image(systemName: "location.circle")
                        Text("Your Location")
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    HStack {
                        Image(systemName: "mappin.circle")
                        Text("CL Building")
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // Show me the way Button
                    Button(action: {
                        withAnimation {
                            isShowingDirections.toggle()
                        }
                    }) {
                        Text("Show me the way")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(white: 0.95))
                .cornerRadius(15)
                .padding(.horizontal, 16)
                .offset(y: isShowingDirections ? 0 : -200)
                .animation(.easeInOut, value: isShowingDirections)
                
                if isShowingDirections {
                    Spacer()
                }
            }
            .padding(.bottom, isShowingDirections ? 0 : 100)
        }
    }
}

#Preview {
    MapDetailView()
}
