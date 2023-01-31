//
//  Location_View.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 17/01/2023.
//

import Foundation
import MapKit
import UIKit
import SwiftUI

struct Location_View: View {
    let locationFetcher = LocationFetcher2()

    var body: some View {
        VStack {
            Button("Start Tracking Location") {
                self.locationFetcher.start()
            }

            Button("Read Location") {
                if let location = self.locationFetcher.lastKnownLocation {
                    print("Your location is \(location.longitude)")
                } else {
                    print("Your location is unknown")
                }
            }
        }
    }
}

//struct Location_View_Previews: PreviewProvider {
//    static var previews: some View {
//        Location_View()
//    }
//}
