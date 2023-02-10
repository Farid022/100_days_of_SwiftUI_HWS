//
//  Practice_part.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 31/01/2023.
//

import SwiftUI
//Topics:
/*
 1. Working with two side by side views in SwiftUI.
 2. Using alert() and sheet() with optionals.
 3. Using groups as transparent layout containers.
 4. Making a SwiftUI view searchable.
 */
struct Practice_part: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                Text("From primery to New View")
            } label: {
                Text("Primery View")
            }
            .navigationTitle("Primery")
            
            Text("Secondary View")
            
            Text("Tertairy View")
        }
    }
}

//Using alert() and sheet() with optionals.
struct User_SA: Identifiable {
    var id = "022"
    var name = "Farid"
}
struct Sheet_Alert_Optional: View {
    @State private var isUser_available: User_SA? = nil//As soon as the sheet is dismissed, SwiftUI sets isUser_available back to nil.
    @State private var isShowingSheet: Bool = false
    
    @State var txt = "Nothing"
    var body: some View {
        Button("Tap Me!") {
            isUser_available = User_SA()
            isShowingSheet = true
        }
        .buttonStyle(.borderedProminent)
//        .sheet(item: $isUser_available) { user in
//            Text(user.name)
//        }
//        .sheet(isPresented: $isShowingSheet) {
//            Text(isUser_available?.name ?? "N/A")
//        }
        .alert("Welcome to Jemmy tech", isPresented: $isShowingSheet, presenting: isUser_available) { user in
            Button(user.id) { }//
            //Although you need to pass both the Boolean and optional Identifiable value at the same time. This allows you to show the alert when needed, but also benefit from the same optional unwrapping behavior we have with sheets:
        }
        
    }
}


//Using groups as transparent layout containers.
struct MyViews: View {
    var body: some View {
        Group {
            Text("Item 1")
            Text("Item 2")
            Text("item 3")
        }
        .font(.title)
    }
}

struct TransparentView: View {
    @State private var isLayoutvertically = false
    
    //Apple provides a very simple solution called size classes, which is a thoroughly vague way of telling us how much space we have for our views.
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
//        Group {
//            if isLayoutvertically {
//                VStack {
//                    MyViews()
//                }
//            } else {
//                HStack {
//                    MyViews()
//                }
//            }
//        }
//        .onTapGesture {
//            isLayoutvertically.toggle()
//        }
        
        
        if sizeClass == .compact {
            VStack(content: MyViews.init)
        } else {
            HStack(content: MyViews.init)
        }
    }
}

//Making a SwiftUI view searchable
struct SearchableView: View {
    @State private var searchText = ""
    let names = ["Jemmy", "khan", "Ali", "Luna", "Sad"]
    var body: some View {
        NavigationView {
//            Text(searchText)
//                .searchable(text: $searchText, prompt: "Looking for...")
//                .navigationTitle("Searchable")
            List(filteredNames, id: \.self) { name in
                HStack {
                    Text("Name 1: ")
                    Text(name)
                }
            }
            .searchable(text: $searchText, prompt: "Looking for...")
            .navigationTitle("Searching")
        }
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return names
        } else {
            //return names.filter { $0.contains(searchText) }
            return names.filter { $0.localizedCaseInsensitiveContains(searchText)} //solve lowercase issues.
        }
    }
}

struct Practice_part_Previews: PreviewProvider {
    static var previews: some View {
        TransparentView()
    }
}
