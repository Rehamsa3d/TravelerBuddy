//
//  PlaceRowView.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//

import SwiftUI

struct PlaceRowView: View {
    let place: Place
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: place.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(10)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(place.name)
                    .font(.headline)
                // بدلاً من Text(place.category)
                Text(place.category.replacingOccurrences(of: "MKPOICategory", with: ""))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 5)
    }
}
