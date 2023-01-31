//
//  ContentView-ViewModel.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 15/01/2023.
//

import Foundation
import MapKit
import LocalAuthentication

//MVVM: Its job is to separate the logic from layout/view.
extension BucketList_project {
   @MainActor class ViewModel: ObservableObject { //@MainActor -> we’re telling Swift every part of this class should run on the main actor, so it’s safe to update the UI, no matter where it’s used.
       @Published var mapRegion = MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 33, longitude: 0),
           span: MKCoordinateSpan(latitudeDelta: 23, longitudeDelta: 34))
       
       @Published private(set) var locations: [Location2] //to store all the places the user wants to visit. private(set) means you can read the locations but not allowed to write locations
       @Published var selectedPlace: Location2?
       @Published var isUnlocked: Bool = false
       
       //add a new property to our ViewModel to store the location we’re saving to:
       let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
       
       
       //create a new initializer and a new save() method that makes sure our data is saved automatically.
       init() {
           do {
               let data = try Data(contentsOf: savePath)
               locations = try JSONDecoder().decode([Location2].self, from: data)
           } catch {
               locations = []
           }
       }
       
       func addLocation() {
           let newLocation = Location2(
            id: UUID(), name: "NewLocation",
            description: "My house",
            latitude: mapRegion.center.latitude,
            longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
       }
       
       func updateLocation(newlocation: Location2) {
           guard let selectedPlace = selectedPlace else { return }
            
           if let index =  locations.firstIndex(of: selectedPlace) { //find the current location index.
               locations[index] = newlocation
               save()
           }
       }
       
       func save() {
           do {
               //we can ask iOS to ensure the file is written with encryption so that it can only be read once the user has unlocked their device. write a data to disk.
               let data = try JSONEncoder().encode(locations)
               try data.write(to: savePath, options: [.atomic, .completeFileProtection])
           } catch {
               print("Unable to save data.")
           }
       }
        
       
       @Published var title: String = ""
       @Published var message: String = ""
       @Published var showAlert: Bool = false
       
       func authenticate() {
           let context = LAContext()
           var error: NSError?
           
           if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
               let reason = "We want to Unlock your Map"
               
               context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, auth_error in
                   if success {
                       //self.isUnlocked = true
                       //The solution here is to make sure we change the isUnlocked property on the main actor. This can be done by starting a new task, then calling await MainActor.run() inside there, like this: It means “start a new background task, then immediately use that background task to queue up some work on the main actor.”
//                       Task {
//                           await MainActor.run {
//                               self.isUnlocked = true
//                           }
//                       }
                       Task { @MainActor in //we can tell Swift that our task’s code needs to run directly on the main actor.
                           self.isUnlocked = true
                           self.showAlert = true
                       }
                   } else {
                       Task { @MainActor in
                           self.isUnlocked = false
                           self.showAlert = true
                           self.title = "Authentication Error!"
                           self.message = "\(String(describing: auth_error))"
                       }
                   }
               }
           } else {
               //No biamatric
               
           }
       }
    }
}

