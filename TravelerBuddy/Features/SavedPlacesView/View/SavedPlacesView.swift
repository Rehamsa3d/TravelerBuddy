//
//  SavedPlacesView.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

import Foundation
import SwiftUI
import SwiftData
import MapKit

struct SavedPlacesView: View {
    @Query(sort: \SavedPlace.name) var savedPlaces: [SavedPlace]
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var locationManager: LocationManager
    
    // متغير لحفظ المكان المختار عشان نظهر الـ Sheet
    @State private var selectedPlace: Place?

    var body: some View {
        NavigationStack {
            List {
                ForEach(savedPlaces) { savedItem in
                    PlaceRowView(place: convertToPlace(savedItem))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            // تحويل الـ SavedPlace لـ Place عند الضغط
                            selectedPlace = convertToPlace(savedItem)
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        modelContext.delete(savedPlaces[index])
                    }
                    try? modelContext.save()
                }
            }
            .navigationTitle("Saved Places")
            // إضافة الـ Sheet هنا
            .sheet(item: $selectedPlace) { place in
                PlaceDetailView(place: place)
                    .environmentObject(locationManager)
            }
            .overlay {
                if savedPlaces.isEmpty {
                    ContentUnavailableView("No Favorites", systemImage: "bookmark.slash")
                }
            }
        }
    }

    // دالة مساعدة لتحويل البيانات من النوع المخزن للنوع اللي بتفهمه الـ View
    func convertToPlace(_ saved: SavedPlace) -> Place {
        Place(
            name: saved.name,
            category: saved.category,
            imageName: "mappin.circle.fill",
            coordinate: CLLocationCoordinate2D(latitude: saved.latitude, longitude: saved.longitude),
            address: saved.address
        )
    }
}
