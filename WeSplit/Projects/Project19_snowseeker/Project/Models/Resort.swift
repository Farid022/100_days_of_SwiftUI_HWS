//
//  Resort.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 01/02/2023.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let allresorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allresorts[0]
    
    //MARK: EXMPLAINATION
    /*
     the map() function lets us transform every item in the array using some code of our choosing, and sends back a new array of all the transformed items:
     let transformAll_to_capital = team.map{ $0.uppercased() }
     */
    var facilityType: [Facility] {
        facilities.map(Facility.init)
    }
}


//The decode func is right down
/*
 extension Bundle {
     func decode<T: Decodable>(_ file: String) -> T {
         guard let url = self.url(forResource: file, withExtension: nil) else {
             fatalError("Failed to locate \(file) in bundle.")
         }

         guard let data = try? Data(contentsOf: url) else {
             fatalError("Failed to load \(file) from bundle.")
         }

         let decoder = JSONDecoder()

         guard let loaded = try? decoder.decode(T.self, from: data) else {
             fatalError("Failed to decode \(file) from bundle.")
         }

         return loaded
     }
 }
 */
