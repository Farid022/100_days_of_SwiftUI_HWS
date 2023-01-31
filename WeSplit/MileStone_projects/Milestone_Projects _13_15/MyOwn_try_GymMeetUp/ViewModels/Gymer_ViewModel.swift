//
//  Gymer_ViewModel.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 17/01/2023.
//

import Foundation
import SwiftUI
import MapKit

@MainActor class Gymer_VM: ObservableObject {
    @Published var isUnlocked = true
    @Published var authError = ""
    @Published private(set) var meetup: [Gymer]
    
    //path for saving the user data to document directory.
    let savePathMeetup = FileManager.documentsDirectory.appendingPathComponent("SavedPersons")
    init() {
            do {
                let gymerData = try Data(contentsOf: savePathMeetup)
                meetup = try JSONDecoder().decode([Gymer].self, from: gymerData)
            } catch {
                meetup = []
            }
        }
    
    //add new gymer
    func addNew_Gymer(name: String, inputUIimage: UIImage?, latitude: Double, longitude: Double) {
        //convert your UIImage to Data by calling its jpegData() method and assign the quality of the image.
        guard let imageData = inputUIimage?.jpegData(compressionQuality: 0.8) else { return }
        
        let newGymer = Gymer(name: name, avatar: imageData)
        meetup.append(newGymer)
        
        //save to user document directory.
        saveMeetup()
    }
    
    //Save the gymers data to its local document directory
    func saveMeetup() {
            do {
                let gymersData = try JSONEncoder().encode(self.meetup)
                try gymersData.write(to: savePathMeetup, options: [.atomic, .completeFileProtection])
                print("saved meetup")
            } catch {
                print("unable to save data")
            }
        }
    
    //update the view when it changes
    func updateView() {
        self.objectWillChange.send()
    }
    
    //delete row
    func deleteRow(at offset: IndexSet) {
        meetup.remove(atOffsets: offset)
        saveMeetup()
        print("Row deleted successfully!")
    }
}
