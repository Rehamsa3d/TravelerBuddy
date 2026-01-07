//
//  AppState.swift
//  FlowerMarket(SwiftUI-MVVM)
//
//  Created by Reham on 29/12/2025.
//

import Foundation
import Combine


import SwiftUI

enum AppState {
    case splash
    case main
    // case login
}

class AppStateManager: ObservableObject {
    @Published var currentState: AppState = .splash
    
    func switchState(to newState: AppState) {
        withAnimation(.easeInOut) {
            currentState = newState
        }
    }
}

