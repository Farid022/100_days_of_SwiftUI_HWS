//
//  UnderstandMap.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 18/01/2023.
//

import SwiftUI
import MapKit

//defining a new data type that contains your location,
struct MyLoc: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    
    //creating an array of those containing all your locations.
    let myLocations = [
        MyLoc(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417)),
        
        MyLoc(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]

    var body: some View {
        //adding them as annotations in the map.
        Map(coordinateRegion: $mapRegion, annotationItems: myLocations) { loc in
            //MapMarker(coordinate: loc.coordinate)
            MapAnnotation(coordinate: loc.coordinate) { 
                NavigationLink {
                    Text(loc.name)
                } label: {
                    Circle()
                        .stroke(.red, lineWidth: 2)
                        .frame(width: 30, height: 30)
                }

            }
        }
    }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
