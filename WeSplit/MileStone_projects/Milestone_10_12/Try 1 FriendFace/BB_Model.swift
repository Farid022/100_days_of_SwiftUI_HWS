//
//  BB_Model.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 01/01/2023.
//
//try this url to fetch data. https://www.fishwatch.gov/api/species
import Foundation
//Create the model carefully.
//Create Decode-URLSession.swift file which any type data, url and dateDecodingStrategy
//Create observable class and fetchData.
//Create view and display them.
struct User_model: Codable, Hashable {
     let id: UUID
     let isActive: Bool
     let name: String
     let age: Int
     let company: String
     let email: String
     let address: String
     let about: String
     let registered: Date
     let tags: [String]
     let friends: [Friend]
    
    struct Friend: Codable, Hashable {
        var id: String
        var name: String
    }
}


