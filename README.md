//
//  README.MD
//  TravelerBuddy
//
//  Created by Reham on 08/01/2026.




🚀 Traveler Buddy - iOS Travel Explorer

Traveler Buddy is a sophisticated iOS application built with SwiftUI, designed to help users explore their
surroundings, find points of interest (POIs) using real-time data, and manage their favorite travel spots
locally.


✨ Features
* Real-time Map Exploration: Interactive map interface with user location tracking and intuitive navigation.

* Apple Local Search API: Fetches real-world data including addresses, phone numbers, and categories directly from Apple's map servers.

* Dynamic Bottom Sheet: A modern, draggable UI component for browsing search results without losing map context.

* Place Details Card: Comprehensive view for selected locations featuring one-tap directions via Apple Maps and contact information.

* Persistence with SwiftData: Robust favorite system that stores data locally on the device using iOS 17's latest persistence framework.

* Smart State Management: Seamless data flow between the Map, List, and Detail views using the MVVM pattern.

                                                                
🛠 Tech Stack
                                                                
* Framework: SwiftUI

                                                                
* Architecture: MVVM (Model-View-ViewModel)

* Navigation & Maps: MapKit & Apple Local Search

* Database: SwiftData (iOS 17+)
                                                                
* Reactive Programming: Combine (Observable Objects & Published Properties)
                                                                

TravelerBuddy/
├── Models/
│   ├── Place.swift          # Data structure for API results
│   └── SavedPlace.swift     # SwiftData Schema for persistence
├── ViewModels/
│   └── LocationManager.swift # Logic for GPS, Search, and Map interactions
├── Views/
│   ├── Explore/             # Main Search and Map interface
│   ├── Saved/               # Favorites management screen
│   ├── Details/             # Interactive Place Detail Card
│   └── Components/          # Reusable UI elements (Rows, Annotations)
└── App/
└── TravelerBuddyApp.swift # Application lifecycle and Data Container

                                                                
🚀 Getting Started
Prerequisites

* Xcode 15.0 or later

* iOS 17.0+ Target

* Active Internet Connection (for Map data)

Installation

Clone the repository:
                                                                    
git clone https://github.com/Rehamsa3d/FlowerMarket-SwiftUI-MVVM-.git
                                                                
Open the project: Open TravelerBuddy.xcodeproj in Xcode.

Run the app: Select a Simulator or a physical device and press Cmd + R.

📝 Roadmap
[x] Integrate Apple Local Search API.

[x] Implement SwiftData for offline favorites.

[ ] Add real photos for places using Unsplash API.

[ ] Implement user reviews and ratings.

[ ] Add support for multiple languages (Localization).


🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.
