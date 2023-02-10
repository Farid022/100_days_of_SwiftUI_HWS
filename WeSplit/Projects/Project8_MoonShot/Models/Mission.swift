//
//  Mission.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 25/11/2022.
//

import Foundation
struct Mission: Codable, Identifiable {
    //it is a nested struct, it does not effect the struct.
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    let id: Int
    let crew: [CrewRole]
    let description: String
    let launchDate: Date? //swift will think, oh it is a date and then it will use the dateFomater strategy

    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formatedLunchedDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var myOwnFormatedDate: String {
        launchDate?.formatted(date: .numeric, time: .omitted) ?? "N/A"
    }
}


