//
//  PlaceDetailView.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

import Foundation
import SwiftUI
import MapKit
struct PlaceDetailView: View {
    let place: Place
        
    @EnvironmentObject var locationManager: LocationManager // الوصول للمدير
    var body: some View {
        VStack(spacing: 20) {
            // الجزء العلوي: أيقونة واسم المكان
            HStack {
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(place.category.replacingOccurrences(of: "MKPOICategory", with: ""))
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "mappin.and.ellipse")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
            }
            .padding(.top)

            Divider()

            // عرض العنوان والتليفون
            VStack(alignment: .leading, spacing: 15) {
                if let address = place.address {
                    InfoRow(icon: "location.fill", text: address)
                }
                
                if let phone = place.phoneNumber {
                    InfoRow(icon: "phone.fill", text: phone)
                }
            }
            
            Spacer()

            // أزرار التحكم
            HStack(spacing: 20) {
                // زرار الاتجاهات (يفتح خرائط آبل الأصلية)
                Button(action: openInMaps) {
                    Label("Directions", systemImage: "arrow.triangle.turn.up.right.diamond.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                // زرار الحفظ (هنبرمجه لاحقاً)
                // زرار الحفظ المطور
                            Button(action: {
                                locationManager.toggleFavorite(place: place)
                            }) {
                                Image(systemName: locationManager.isSaved(place: place) ? "bookmark.fill" : "bookmark")
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .foregroundColor(locationManager.isSaved(place: place) ? .blue : .primary)
                                    .cornerRadius(12)
                            }
                    
            }
            .padding(.bottom)
        }
        .padding()
        .presentationDetents([.medium]) // الـ Sheet تطلع لنص الشاشة بس
        .presentationDragIndicator(.visible)
    }
    
    func openInMaps() {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: place.coordinate))
        mapItem.name = place.name
        mapItem.openInMaps()
    }
}

// Sub-view بسيطة للأيقونة والنص
struct InfoRow: View {
    let icon: String
    let text: String
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            Text(text)
                .font(.body)
        }
    }
}
