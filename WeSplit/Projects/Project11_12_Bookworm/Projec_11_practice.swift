//
//  Projec_11_practice.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 14/12/2022.
//

import SwiftUI
import CoreData

//Topics: Binding, TextEditor, CoreData->Desktop->swiftUI apps->CoreDataConcept
/*
 Here’s a quick recap of all the new things we covered in the last three projects:
 Building custom Codable conformance
 Sending and receiving data using URLSession
 The disabled() modifier for views
 Building custom UI components using @Bindable
 Adding multiple buttons to an alert
 How Swift’s Hashable protocol is used in SwiftUI
 Using the @FetchRequest property wrapper to query Core Data
 Sorting Core Data results using SortDescriptor
 Creating custom NSManagedObject subclasses
 Filtering data using NSPredicate
 Creating relationships between Core Data entities
 */
struct Projec_11_practice: View {
    //Biding
    @State var state = false
    @State var title = "Click Me!"
    
    //TextEditor
    @AppStorage("myId") var notes = ""
    
    var body: some View {
        VStack {
            MyToggle(state: $state, title: $title)
            Text(state.description)
                
            Spacer()
            
            //TextEditor
            Text("TextEditor is down")
            TextEditor(text: $notes)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
            Spacer()
        }
    }
}
struct MyToggle: View {
    @Binding var state: Bool
    @Binding var title: String
    
    //What if we have @states, then the view view not changes.
//    @State var state: Bool
//    @State var title: String
    var body: some View {
        Button(title) {
            state.toggle()
        }.buttonStyle(.borderedProminent)
    }
}


struct Projec_11_practice_Previews: PreviewProvider {
    let onOf: Bool
    static var previews: some View {
        Projec_11_practice()
    }
}


