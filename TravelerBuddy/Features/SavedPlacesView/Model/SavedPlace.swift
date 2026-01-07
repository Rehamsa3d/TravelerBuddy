import Foundation
import SwiftData

@Model
class SavedPlace {
    @Attribute(.unique) var name: String // عشان المكان ميتسيفش مرتين بنفس الاسم
    var category: String
    var address: String?
    var latitude: Double
    var longitude: Double
    
    init(name: String, category: String, address: String?, latitude: Double, longitude: Double) {
        self.name = name
        self.category = category
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
}