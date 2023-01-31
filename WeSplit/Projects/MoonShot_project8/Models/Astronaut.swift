//
//  Austonaut.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 25/11/2022.
//

import Foundation
struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
/*
 Next we want to convert astronauts.json into a dictionary of Astronaut instances, which means we need to use Bundle to find the path to the file, load that into an instance of Data, and pass it through a JSONDecoder. Previously we put this into a method on ContentView, but here I’d like to show you a better way: we’re going to write an extension on Bundle to do it all in one centralized place.
 */
