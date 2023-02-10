//
//  ExpenseItem.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 22/11/2022.
//

import Foundation
//UUID-> universal Unique id. It generates unique ids, have very small amount of chance of dublication.
struct ExpenseItem: Identifiable, Codable { // "This type can be identified uniquely.” This protocol has a property called id which is must. Adding the Identifiable protocol does not need to add id in the forech loop.
    var id: UUID = UUID() // use let if we dont want to change the id using codable.
    let name: String
    let type: String
    let amount: Double
    let countryCode: String
}
