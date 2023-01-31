//
//  HomeView_BB.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 01/01/2023.
//

import SwiftUI

struct HomeView_BB: View {
    @StateObject var users = Get_Users()
    var body: some View {
        NavigationView {
            List {
                Text("No Data")
                ForEach(users.users, id: \.id) { user in
                    Text("\(user.registered.formatted())")
                }
            }.task {
                await users.loadData()
            }
            .navigationTitle("FriendFace")
        }
    }
}

struct HomeView_BB_Previews: PreviewProvider {
    static var previews: some View {
        HomeView_BB()
    }
}
