//
//  LocationManager.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//


import Foundation
import CoreLocation
import SwiftUI
import MapKit
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var savedPlaces: [Place] = [] //   

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @Published var mapPins: [Place] = []
    
    var hasSetInitialLocation = false

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        searchPlaces(query: "Coffee")
    }
    
    func searchPlaces(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = self.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            
            if let error = error {
                    print("Search Error: \(error.localizedDescription)") //
                    return
                }
            guard let response = response else { return }
            
            DispatchQueue.main.async {
                self?.mapPins = response.mapItems.map { item in
                    Place(
                        name: item.name ?? "Unknown",
                        category: item.pointOfInterestCategory?.rawValue ?? "Place",
                        imageName: "mappin.circle.fill",
                        coordinate: item.placemark.coordinate,
                        address: item.placemark.title, //
                        phoneNumber: item.phoneNumber,  //
                        url: item.url                   //
                    )
                }
            }
        }
    }

    func goToPlace(_ place: Place) {
        withAnimation(.spring()) {
            region.center = place.coordinate
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, !hasSetInitialLocation else { return }
        
        DispatchQueue.main.async {
            self.region.center = location.coordinate
            self.hasSetInitialLocation = true
            
            self.searchPlaces(query: "Attractions")
        }
    }
    
}
