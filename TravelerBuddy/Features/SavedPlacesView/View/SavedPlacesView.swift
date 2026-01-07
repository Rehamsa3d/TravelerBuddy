//
//  SavedPlacesView.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

import Foundation
import SwiftUI
struct SavedPlacesView: View {
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        NavigationStack {
            Group {
                if locationManager.savedPlaces.isEmpty {
                    ContentUnavailableView("No Saved Places",
                                           systemImage: "bookmark.slash",
                                           description: Text("Your favorite spots will appear here."))
                } else {
                    List(locationManager.savedPlaces) { place in
                        PlaceRowView(place: place)
                            .swipeActions {
                                Button(role: .destructive) {
                                    locationManager.toggleFavorite(place: place)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .navigationTitle("Saved Places")
        }
    }
}
