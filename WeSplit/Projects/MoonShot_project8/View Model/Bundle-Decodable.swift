//
//  Bundle-Decodable.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 25/11/2022.
//

import Foundation
/*
 Create another new Swift file, this time called Bundle-Decodable.swift. This will mostly use code you’ve seen before, but there’s one small difference: previously we used String(contentsOf:) to load files into a string, but because Codable uses Data we are instead going to use Data(contentsOf:). It works in just the same way as String(contentsOf:): give it a file URL to load, and it either returns its contents or throws an error.
 */
extension Bundle {
    //T is a placeholder for whatever type we ask for(i.e: [String: Astronuat] and [Mission], so if we say “decode our dictionary of astronauts,” then T becomes [String: Astronaut].
    func decode<T: Codable>(_ file: String) -> T {
        //find url for the file_resource in our Stored bundle.
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to find: \(file) in the bundle")
        }
        
        //once we have a file in the bundle, then load some data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load: \(file) in the bundle")
        }
        
        //then decode the data into a string astronuat dictionary.
        let decoder = JSONDecoder()
        //it tells the swift whenever you find a date, it will be in this format.
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "y-MM-dd"
        //dateFormater.timeZone// you can customise the time as well
        decoder.dateDecodingStrategy = .formatted(dateFormater)
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else { //it requires that T confirm to codable-decodable and encodable
            //we found and load the file but it is not actually a string Astronuat
            fatalError("Failed to decode: \(file) from the bundle")
        }
        
        return loadedData
    }
}
