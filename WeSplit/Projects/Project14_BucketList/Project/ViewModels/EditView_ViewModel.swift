//
//  EditView_ViewModel.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 16/01/2023.
//

import Foundation
extension EditView {
    @MainActor class EditView_VM: ObservableObject {
        @Published var loadingState = LoadingStates.loading
        
        @Published var pages = [Page]()
        var location: Location2

        @Published var name: String
        @Published var description: String
        
        init(location: Location2) {
//their initial values should come from what location is being passed in, so the user sees the saved data. The init() creates State structs using the location’s data.
            self.location = location
// _name, which allows us to create an instance of the property wrapper not the data inside the wrappe used beore for _fetchrquest in previous project.
            _name = Published(initialValue: location.name)
            _description = Published(initialValue: location.description)
        }
        
        
        //The init can also be written as.
//        init(location: Location2) {
//            name = location.name
//            description = location.description
//            self.location = location
//        }
        
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                // we got some data back!
                let items = try JSONDecoder().decode(Result2.self, from: data)
                
                // success – convert the array values to our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
                
            } catch {
                print("Failed to load the data.")
            }

        }
    }
    
    enum LoadingStates {
        case loading, loaded, failed
    }
}
