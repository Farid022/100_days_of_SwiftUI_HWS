//
//  EditView.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 13/01/2023.
//

import SwiftUI
enum LoadingStates {
    case loading, loaded, failed
}
struct EditView: View {
    @Environment(\.dismiss) var dismiss
    //var location: Location2
    //1. Can we use binding -> No, we have optionals, so we want EditView to be bound to a real value rather than an optional value, because otherwise it would get confusing.
    
    //2. we require a function to call where we can pass back whatever new location we want. This means any other SwiftUI can send us some data, and get back some new data to process however we want.
    var onSave: (Location2) -> Void
    //3. That asks for a function that accepts a single location and returns nothing, which is perfect for our usage. We need to accept that in our initializer, like this:
    
    
    @StateObject private var edit_vm: EditView_VM

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $edit_vm.name)
                    TextField("Description", text: $edit_vm.description)
                }
                
                Section("Nearby places...") {
                    switch edit_vm.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(edit_vm.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Failed to the data.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                /*
                 Speaking of which, we need to update that Save button to create a new location with the modified details, and send it back with onSave():
                 */
                Button("Save") {
                    var newLocation = edit_vm.location
                    newLocation.name = edit_vm.name
                    newLocation.description = edit_vm.description
                    newLocation.id = UUID()
                    
                    onSave(newLocation) //call onSave with that newLocation, pass that back to whatever called us to work with.
                    dismiss()
                }
            }
            .task {
                await edit_vm.fetchNearbyPlaces()
            }
        }
    }
    //their initial values should come from what location is being passed in, so the user sees the saved data. The init() creates State structs using the location’s data.
    init(location: Location2, onSave: @escaping (Location2) -> Void ) { //Remember, @escaping means the function is being stashed away for user later on, rather than being called immediately, and it’s needed here because the onSave function will get called only when the user presses Save.
        //self.location = location
        _edit_vm = StateObject(wrappedValue: EditView_VM(location: location))
        self.onSave = onSave
    }
    
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(location: Location2.example) { _ in
//
//        }
//    }
//}
