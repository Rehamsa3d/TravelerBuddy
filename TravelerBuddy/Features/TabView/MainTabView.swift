//
//  MainTabView.swift
//  TravelerBuddy
//
//  Created by Reham on 01/01/2026.
//
import SwiftUI
struct MainTabView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground.withAlphaComponent(0.8)
    }
    var body: some View {
        TabView {
            NavigationStack {
                ExploreView()
            }
            .tabItem {
                Label("Explore", systemImage: "map.fill")
            }
            
            NavigationStack {
                SavedPlacesView()
            }
            .tabItem {
                Label("Saved", systemImage: "bookmark.fill")
            }
        }
        .tint(.blue)
    }
}
