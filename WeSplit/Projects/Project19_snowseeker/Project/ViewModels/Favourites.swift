//
//  Favourites.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 02/02/2023.
//

import Foundation
class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    
    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"
    
    init() {
        // load our saved data
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
            
            //how to decode a set as an array and assigning it to resort.
//            if let decodeed = try? JSONDecoder().decode([String].self, from: data) {
//                self.resorts = .init(decodeed)
//            }
        }
        // still here? Use an empty array
        resorts = []
    }
    
    // returns true if our set contains this resort
    func contains(resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // adds the resort to our set, updates all views, and saves the change
    func add(resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    // removes the resort from our set, updates all views, and saves the change
    func remove(resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    
    func save() {
        // write out our data
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
}

