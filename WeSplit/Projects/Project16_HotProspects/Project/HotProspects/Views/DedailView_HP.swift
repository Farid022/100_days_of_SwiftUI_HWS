//
//  DedailView_HP.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 03/02/2023.
//

import SwiftUI


struct DedailView_HP: View {
    @State var prospect: Prospect
    
    var body: some View {
        NavigationView {
            List {
                Text("Name is: \(prospect.name)")
                Text("Email is: \(prospect.emailaddress)")
            }
        }
    }
}

//struct DedailView_HP_Previews: PreviewProvider {
//    static var previews: some View {
//        DedailView_HP()
//    }
//}
