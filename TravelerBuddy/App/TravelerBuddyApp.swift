//
//  TravelerBuddyApp.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

import SwiftUI

@main
struct TravelerBuddyApp: App {
    
    @StateObject private var appState = AppStateManager()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(appState)
                .preferredColorScheme(.dark) // السطر ده بيجبر التطبيق كله يبقى Dark Mode
        }
    }
}
