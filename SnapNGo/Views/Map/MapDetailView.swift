//
//  MapDetailView.swift
//  SnapNGo
//
//  Created by Phyu Thandar Khin on 15/11/2567 BE.
//

import SwiftUI
import MapKit
import Foundation
import CoreLocation

struct MapDetailView: View {
    
    @State private var selection: UUID?
    @State private var showSheet = false
    @State private var startLocation: String = "VMES"
    @State private var endLocation: String = "MS"

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 13.611779526627688, longitude: 100.83789503816988),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var route: MKPolyline?
    
    var body: some View {
        Map(selection: $selection){
            ForEach(sampleSchoolLocations, id: \.id){ location in
                Marker(location.name, coordinate: location.coordinates)
            }
            
            if let route {
                MapPolyline(route)
                    .stroke(Color.blue, lineWidth: 5    )
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    if let selection {
                        if let item = sampleSchoolLocations.first(where: { $0.id == selection }) {
                            Text(item.abbreviation)
                            Text(item.name)
                        }
                    }
                    if selection == nil{
                        Button {
                            showSheet = true
                        } label: {
                            Text("Show Directions")
                        }
                    }
                }
                Spacer()
            }
            .background(.thinMaterial)
        })
        .onChange(of: selection) {
            guard let selection else { return }
            guard let item = sampleSchoolLocations.first(where: { $0.id == selection }) else { return }
            print(item.coordinates)
        }
        .mapStyle(.standard)
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 20) {
                HStack{
                    Text(Constants.MapViewConstant.startLocation)
                        .font(.headline)
                    Spacer()
                    Picker("", selection: $startLocation) {
                        ForEach(sampleSchoolLocations) { location in
                            Text(location.abbreviation).tag(location.abbreviation)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
                HStack{
                    Text(Constants.MapViewConstant.endLocation)
                        .font(.headline)
                    Spacer()
                    Picker("", selection: $endLocation) {
                        ForEach(sampleSchoolLocations) { location in
                            Text(location.abbreviation).tag(location.abbreviation)
                        }
                    }
                    .pickerStyle(.menu)
                    .labelsHidden()
                }
                Button(Constants.MapViewConstant.showMeButtonText) {
                    calculateRoute()
                    showSheet = false
                }
                .padding(.top, 10)
            }
            .padding()
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .presentationCornerRadius(20)
        }

    }
    
    private func calculateRoute() {
        guard let start = sampleSchoolLocations.first(where: { $0.abbreviation == startLocation }),
              let end = sampleSchoolLocations.first(where: { $0.abbreviation == endLocation }) else {
            return
        }
        
        route = nil

        let startPlacemark = MKPlacemark(coordinate: start.coordinates)
        let endPlacemark = MKPlacemark(coordinate: end.coordinates)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPlacemark)
        request.destination = MKMapItem(placemark: endPlacemark)
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error = error {
                print("Error calculating directions: \(error.localizedDescription)")
                return
            }

            guard let route = response?.routes.first else { return }
            self.route = route.polyline
        }
    }
}

#Preview {
    MapDetailView()
}

struct SchoolLocation: Identifiable {
    let id = UUID()
    let abbreviation: String
    let name: String
    let coordinates: CLLocationCoordinate2D
}

let sampleSchoolLocations: [SchoolLocation] = [
    SchoolLocation(
        abbreviation: "MS",
        name: "Louis Nobiron School of Music",
        coordinates: CLLocationCoordinate2D(latitude: 13.612264, longitude: 100.837577)
    ),
    SchoolLocation(
        abbreviation: "MSME",
        name: "Martin de Tours School of Management and Economics",
        coordinates: CLLocationCoordinate2D(latitude: 13.612958, longitude: 100.836499)
    ),
    SchoolLocation(
        abbreviation: "ARTS",
        name: "Theodore Maria School of Arts",
        coordinates: CLLocationCoordinate2D(latitude: 13.611520, longitude: 100.837211)
    ),
    SchoolLocation(
        abbreviation: "LAW",
        name: "Thomas Aquinas School of Law",
        coordinates: CLLocationCoordinate2D(latitude: 13.611869, longitude: 100.837477)
    ),
    SchoolLocation(
        abbreviation: "CA",
        name: "Albert Laurence School of Communication Arts",
        coordinates: CLLocationCoordinate2D(latitude: 13.612227, longitude: 100.835039)
    ),
    SchoolLocation(
        abbreviation: "AR",
        name: "Montfort del Rosario School of Architecture and Design",
        coordinates: CLLocationCoordinate2D(latitude: 13.612125, longitude: 100.835519)
    ),
    SchoolLocation(
        abbreviation: "BS",
        name: "Theophane Venard School of Biotechnology",
        coordinates: CLLocationCoordinate2D(latitude: 13.612766, longitude: 100.840549)
    ),
    SchoolLocation(
        abbreviation: "NS",
        name: "Bernadette de Lourdes School of Nursing Science",
        coordinates: CLLocationCoordinate2D(latitude: 13.612219, longitude: 100.838038)
    ),
    SchoolLocation(
        abbreviation: "VMES",
        name: "Vincent Mary School of Engineering, Science and Technology",
        coordinates: CLLocationCoordinate2D(latitude: 13.613145, longitude: 100.835811)
    )
]
