//
//  BB_ViewModel.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 01/01/2023.
//

import Foundation
class Get_Users: ObservableObject {
    @Published var users = [User_model]()
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("There was an error while loading the URL")
            return
        }

        do {
            //here the decode method comes from Decode-URLSession.swift and has dataType, url, dateDecodingStrategy
            async let userItems = try await URLSession.shared.decode([User_model].self, from: url, dateDecodingStrategy: .iso8601)
            self.users = try await userItems
        } catch {
            print("Failed to fetch data!")
        }
    }    
}
