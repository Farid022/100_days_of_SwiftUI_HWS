//
//  Expenses.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 22/11/2022.
//

import Foundation
class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            //Archiving the Expense item into JSON objects.
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
            //UnArchiving the JSON objects into ExpenseItem
        if let savedItems = UserDefaults.standard.data(forKey: "Items") { // it attempts to read whatever is in “Items” as a Data object, and try?
            if let decodeItems = try? decoder.decode([ExpenseItem].self, from: savedItems) { // it does the actual job of unarchiving the Data object into an array of ExpenseItem objects.
                items = decodeItems // then simply save it in the items array.
                return
            }
        }
        //else return empty array
        items = []
    }
}
