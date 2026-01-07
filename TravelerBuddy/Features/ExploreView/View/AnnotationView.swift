//
//  AnnotationView.swift
//  TravelerBuddy
//
//  Created by Reham on 07/01/2026.
//


import SwiftUI

struct AnnotationView: View {
    let place: Place
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 3)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .frame(width: 5, height: 5)
                .foregroundColor(.red)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}
