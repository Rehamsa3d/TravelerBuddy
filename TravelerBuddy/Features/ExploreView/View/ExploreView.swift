//
//  ExploreView.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

import Foundation
import SwiftUI
import MapKit
struct ExploreView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @State private var searchText = ""
    @State private var offset: CGFloat = 600
    @State private var selectedPlace: Place?
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                MapViewContainer(locationManager: locationManager, selectedPlace: $selectedPlace)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search for places...", text: $searchText, onCommit: {
                            locationManager.searchPlaces(query: searchText)
                        }).padding(.horizontal, 10)
                        .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color(.systemBackground).opacity(0.9))
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding()
                    
                    Spacer()
                }
                
                VStack(spacing: 0) {
                    Capsule()
                        .frame(width: 40, height: 6)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.top, 10)
                    
                    Text("Found \(locationManager.mapPins.count) Places")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 5)

                    List(locationManager.mapPins) { place in
                        PlaceRowView(place: place)
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                locationManager.goToPlace(place)
                                withAnimation { offset = proxy.size.height - 200 }
                            }
                    }
                    .listStyle(.plain)
                }
                .frame(height: proxy.size.height)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(25)
                .offset(y: offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newOffset = offset + value.translation.height
                            if newOffset > 100 && newOffset < proxy.size.height - 100 {
                                offset = newOffset
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                if offset < proxy.size.height / 2 {
                                    offset = 150
                                } else {
                                    offset = proxy.size.height - 200
                                }
                            }
                        }
                )
              
            }  .sheet(item: $selectedPlace) { place in
                PlaceDetailView(place: place)
                    .environmentObject(locationManager)
            }
        }
    }
}

struct MapViewContainer: View {
    @ObservedObject var locationManager: LocationManager
    @Binding var selectedPlace: Place? // mapping to ExploreView

    var body: some View {
        Map(coordinateRegion: $locationManager.region,
            showsUserLocation: true,
            annotationItems: locationManager.mapPins) { place in
            
            MapAnnotation(coordinate: place.coordinate) {
                AnnotationView(place: place)
                    .onTapGesture {
                        self.selectedPlace = place
                    }
            }
        }
    }
}
