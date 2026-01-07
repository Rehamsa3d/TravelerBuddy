//
//  SplashView.swift
//  TravelerBuddy
//
//  Created by Reham on 29/12/2025.
//

import Foundation
import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appState: AppStateManager // الوصول لمدير الحالة
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        VStack {
            Image(systemName: "globe.americas.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            Text("Traveler Buddy")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .scaleEffect(size)
        .opacity(opacity)
        .onAppear {
            // Animation اللوجو
            withAnimation(.easeIn(duration: 1.2)) {
                self.size = 0.9
                self.opacity = 1.0
            }
            
            // الانتقال بعد ثانيتين
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                appState.switchState(to: .main)
            }
        }
    }
}
