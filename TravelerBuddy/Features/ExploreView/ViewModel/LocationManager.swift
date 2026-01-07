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
    @Published var savedPlaces: [Place] = [] // قائمة الأماكن المحفوظة
    // إحداثيات الخريطة التي تظهر للمستخدم
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // قائمة الأماكن الحقيقية التي تظهر كـ Pins
    @Published var mapPins: [Place] = []
    
    var hasSetInitialLocation = false

    // داخل LocationManager
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        // جربي تبحثي عن حاجة مشهورة جداً فوراً
        searchPlaces(query: "Coffee")
    }
    
    // دالة البحث عن أماكن حقيقية
    func searchPlaces(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = self.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            
            if let error = error {
                    print("Search Error: \(error.localizedDescription)") // شوفي هيطبع إيه هنا
                    return
                }
            guard let response = response else { return }
            
            DispatchQueue.main.async {
                // داخل LocationManager -> searchPlaces
                self?.mapPins = response.mapItems.map { item in
                    Place(
                        name: item.name ?? "Unknown",
                        category: item.pointOfInterestCategory?.rawValue ?? "Place",
                        imageName: "mappin.circle.fill",
                        coordinate: item.placemark.coordinate,
                        address: item.placemark.title, // سحب العنوان
                        phoneNumber: item.phoneNumber,  // سحب التليفون
                        url: item.url                   // سحب الموقع الإلكتروني
                    )
                }
            }
        }
    }

    // دالة للذهاب لمكان محدد عند الضغط عليه في القائمة
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
            // بمجرد تحديد موقع المستخدم، ابحث عن معالم سياحية قريبة تلقائياً
            self.searchPlaces(query: "Attractions")
        }
    }
    
    
    // دالة للإضافة أو الحذف من المفضلة (Toggle)
        func toggleFavorite(place: Place) {
            if let index = savedPlaces.firstIndex(where: { $0.name == place.name }) {
                savedPlaces.remove(at: index) // حذف لو موجود
            } else {
                savedPlaces.append(place) // إضافة لو مش موجود
            }
        }
        
        // دالة للتأكد هل المكان محفوظ أم لا
        func isSaved(place: Place) -> Bool {
            savedPlaces.contains(where: { $0.name == place.name })
        }
    
}
