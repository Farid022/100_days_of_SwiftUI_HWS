//
//  Location_fetcher.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 17/01/2023.
//

import Foundation
import CoreLocation

//here’s a class that fetches the user’s location:
class LocationFetcher2: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
