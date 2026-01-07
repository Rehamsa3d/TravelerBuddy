//
//  TravelerBuddyApp.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

import SwiftUI
import SwiftData

@main
struct TravelerBuddyApp: App {
    
    @StateObject private var appState = AppStateManager()
    @StateObject private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(appState)
                .environmentObject(locationManager)
            
                .modelContainer(for: SavedPlace.self) //
                .preferredColorScheme(.dark) //
        }
    }
}
