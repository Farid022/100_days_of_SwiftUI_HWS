//
//  Location.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 13/01/2023.
//

import Foundation
import MapKit

struct Location2: Identifiable, Equatable, Codable {
    //The problem here is that we told SwiftUI that two places were identical if their IDs were identical, and that isn’t true any more – when we update a marker so it has a different name, SwiftUI will compare the old marker and new one, see that their IDs are the same, and therefore not bother to change the map. ->  let id: UUID
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location2(id: UUID(), name: "New location", description: "Goes here", latitude: 33, longitude: 22)
    
    //if two locations have the same identifier then it means they are the same locations
    
    static func ==(lhs: Location2, rhs: Location2) -> Bool {
        lhs.id == rhs.id
    }
}
