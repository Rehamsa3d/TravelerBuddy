//
//  LocationManager.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//


import Foundation
import CoreLocation
import MapKit
import Combine // مهم جداً عشان ObservableObject

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // الـ Manager المسؤول عن الـ GPS
    private let manager = CLLocationManager()
    
    // الإحداثيات اللي الـ View هترقبها
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.0444, longitude: 31.2357), // القاهرة كبداية
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization() // طلب إذن الموقع
        manager.startUpdatingLocation() // بدء تحديث الموقع
    }
    
    // الدالة اللي بتشتغل لما الموقع يتغير
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // تحديث الـ region على الـ Main Thread
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
    
    // معالجة أخطاء الموقع (اختياري بس احترافي للـ Portfolio)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error locating user: \(error.localizedDescription)")
    }
}
