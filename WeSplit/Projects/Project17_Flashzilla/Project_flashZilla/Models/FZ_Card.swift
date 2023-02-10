//
//  FZ_Card.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 24/01/2023.
//

import Foundation
struct FZ_Card: Codable, Hashable, Identifiable {
    var id = UUID()
    let prompt: String
    let answer: String

    static let example = FZ_Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
