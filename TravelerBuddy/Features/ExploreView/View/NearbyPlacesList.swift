//
//  NearbyPlacesList.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

//import SwiftUI
//
//struct NearbyPlacesList: View {
//    @ObservedObject var locationManager: LocationManager
//    
//    var body: some View {
//        VStack {
//            Capsule()
//                .frame(width: 40, height: 6)
//                .foregroundColor(.gray.opacity(0.5))
//                .padding(.top, 10)
//            
//            Text("Nearby Places")
//                .font(.title3)
//                .fontWeight(.bold)
//                .padding(.top, 5)
//            
//            List(mockPlaces) { place in
//                PlaceRowView(place: place)
//                    .listRowBackground(Color.clear)
//                    .contentShape(Rectangle())
//                    .onTapGesture {
//                        locationManager.goToPlace(place)
//                    }
//            }
//            .listStyle(.plain)
//        }
//        .background(Color(.secondarySystemBackground))
//        .cornerRadius(25)
//    }
//}
