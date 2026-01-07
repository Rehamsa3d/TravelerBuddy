//
//  PlaceDetailView.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

import Foundation
import SwiftUI
import SwiftData
import MapKit
struct PlaceDetailView: View {
    let place: Place
    @Environment(\.modelContext) private var modelContext // الوصول للداتابيز
    @Query var savedItems: [SavedPlace] // قراءة الأماكن المسيفة حالياً للتأكد

    var isBookmarked: Bool {
        savedItems.contains(where: { $0.name == place.name })
    }
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
                            Button(action: toggleSave) {
                                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                    .foregroundColor(isBookmarked ? .blue : .primary)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(12)
                            }
                    
            }
            .padding(.bottom)
        }
        .padding()
        .presentationDetents([.medium]) // الـ Sheet تطلع لنص الشاشة بس
        .presentationDragIndicator(.visible)
    }
    
    func toggleSave() {
        if isBookmarked {
            // حذف من الداتابيز
            if let itemToDelete = savedItems.first(where: { $0.name == place.name }) {
                modelContext.delete(itemToDelete)
            }
        } else {
            // إضافة للداتابيز
            let newItem = SavedPlace(
                name: place.name,
                category: place.category,
                address: place.address,
                latitude: place.coordinate.latitude,
                longitude: place.coordinate.longitude
            )
            modelContext.insert(newItem)
        }
        
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
