//
//  ExploreView.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

import Foundation
import SwiftUI
import MapKit

import SwiftUI
import MapKit

struct ExploreView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        // استخدام $ لعمل Binding مع الـ region اللي في الـ View Model
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
            .ignoresSafeArea(edges: .top)
    }
}
