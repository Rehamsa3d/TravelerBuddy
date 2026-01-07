//
//  AppRootView.swift
//  TravelerBuddy
//
//  Created by Reham on 29/12/2025.
//

import Foundation
import SwiftUI

struct AppRootView: View {
    
    
    @EnvironmentObject var appState: AppStateManager
    
    var body: some View {
        Group {
            switch appState.currentState {
            case .splash:
                SplashView()
            case .main:
                MainTabView()
            }
        }
    }
}
