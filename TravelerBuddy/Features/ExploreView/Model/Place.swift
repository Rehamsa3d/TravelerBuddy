//
//  Place.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//


import Foundation
import CoreLocation



struct Place: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let imageName: String 
    let coordinate: CLLocationCoordinate2D
        
    var address: String? = nil
    var phoneNumber: String? = nil
    var url: URL? = nil
}
