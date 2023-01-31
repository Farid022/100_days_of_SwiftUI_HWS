//
//  BucketList_practice.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 12/01/2023.
//

import SwiftUI
import MapKit
import LocalAuthentication
//Topics:
/*
1. Comparable -> used for sorting. As integer can be sorted easily but how about string.
2. Writing data to the documents directory:
3. Switching view states with enums.
4. MapKit.
   1.MKCoordinateRegion()-> A rectangular geographic region that centers around a specific latitude and longitude.
   2.MKCoordinateSpan -> Creates a coordinate span that represents a width and height on a map.
 To add annotations to the map – markers that represent various places of our choosing. it takes three steps:
     1. defining a new data type that contains your location,
     2. creating an array of those containing all your locations.
     3. adding them as annotations in the map. Step three is the important part: we can feed that array of locations into the Map view, as well as providing a function that transforms one location into a visible annotation on the map. SwiftUI provides us with a couple of different annotation types, but the simplest is MapMarker: a simple balloon with a latitude/longitude coordinate attached.
 
 4: Closures. Here is an example.

 Whatever new data type you create to store locations, it must conform to the Identifiable protocol so that SwiftUI can identify each map marker uniquely.
 */

struct User_comp: Identifiable, Comparable {
    let id = UUID()
    let fname: String
    let lname: String
    
    static func <(lhs: User_comp, rhs: User_comp) -> Bool {
        lhs.fname < rhs.fname
    }
}
enum ScreenStates {
    case loadingState, successState, failedState
}
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D //The lati and longi associated with location
}

struct BucketList_practice: View {
    let users = [
        User_comp(fname: "Farid", lname: "Khan"),
        User_comp(fname: "Ali", lname: "Khan"),
        User_comp(fname: "Jammy", lname: "Ko")
    ].sorted()
    
    var screenStates = ScreenStates.loadingState
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]
    
    @State private var isUnLocked = false
    var body: some View {
        NavigationView {
            VStack {
                List(users) { user in
                    Text(user.fname)
                }.frame(height: 200)
                
                //2
                Text("Click to save to document directory")
                    .padding()
                    .background(.green)
                    .onTapGesture {
                        let text = "Testing data Message"
                        let url = getDocumentDirectory().appendingPathComponent("message.txt")
                        
                        do {
                            try text.write(to: url, atomically: true, encoding: .utf8)
                            let input = try String(contentsOf: url)
                            print(input)
                        } catch {
                            print("\(error.localizedDescription)")
                        }
                    }
                
                
                //3
                switch screenStates {
                case .loadingState:
                    LoadingView()
                case .successState:
                    SuccessView()
                case .failedState:
                    FaildedView()
                }
                
                //4
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    //MapMarker(coordinate: location.coordinate) //it is defualt markers.
                    MapAnnotation(coordinate: location.coordinate) { //a custom MapAnnotation
                        NavigationLink {
                            Text(location.name)
                        } label: {
                            Circle()
                                .stroke(.red, lineWidth: 3)
                                .frame(width: 30, height: 30)
                        }

                    }
                }
                .frame(height: 200)
                
                if isUnLocked {
                    Text("Unlocked")
                } else {
                    Text("Locked")
                }
                Spacer()
            }
            .navigationTitle("BucketList")
            .onAppear(perform: authenticate)
        }
    }
    
    func getDocumentDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func authenticate() {
        //To make that happen requires four steps:
        /*
         Create instance of LAContext, which allows us to query biometric status and perform the authentication check.
         Ask that context whether it’s capable of performing biometric authentication – this is important because iPod touch has neither Touch ID nor Face ID.
         If biometrics are possible, then we kick off the actual request for authentication, passing in a closure to run when authentication completes.
         When the user has either been authenticated or not, our completion closure will be called and tell us whether it worked or not, and if not what the error was.
         */
        let context = LAContext() //which allows us to query biometric status and perform the authentication check.
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We want to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { succes, authenticationError in
                // authentication has now completed
                if succes {
                    // authenticated successfully
                    isUnLocked = true
                } else {
                    // there was a problem
                    isUnLocked = false
                }
            }
        }
    }
}

struct LoadingView: View {
    var body: some View{
        Text("Loading view")
    }
}
struct SuccessView: View {
    var body: some View{
        Text("Success view")
    }
}
struct FaildedView: View {
    var body: some View{
        Text("Failed view")
    }
}

//struct BucketList_practice_Previews: PreviewProvider {
//    static var previews: some View {
//        Homeview()
//    }
//}


//closure example.
struct Homeview: View {
    @State private var count = 0
    
    func increase() {
        count += 1
    }
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(1..<5, id: \.self) { item in
                        NavigationLink {
                            DetailView { action in
                                print(action)
                            } increase: { num in
                                increase()
                            }
                        } label: {
                            Text("Item \(item)")
                        }
                    }
                }.frame(height: 250)
                
                Text("Counting: \(count)")
                
                Button("Increase by onew") {
                    count += 1
                }.buttonStyle(.borderedProminent)
                
                Spacer()
                
            }
        }
    }
}


struct DetailView: View {
    var action: (String) -> Void
    var increase: (Int) -> Void
    
    var body: some View {
        VStack {
            Text("I want to handle the action being performed here on the homeView")
            
            Button {
                action("share")
            } label: {
                Label("Share", systemImage: "person")
            }
            
            
            Button {
                action("delete")
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            
            Button {
                action("save")
            } label: {
                Label("Save", systemImage: "house")
            }
            
            Button {
                increase(1)
            } label: {
                Label("Increase by 1", systemImage: "plus")
            }


        }
        .padding()
        .buttonStyle(.borderedProminent)
    }
}





struct View_1: View {
    @State private var count = 0
    
    func increase() {
        count += 1
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    View_2 { item in
                        increase()
                    } action: { item in
                        print(item)
                    }
                } label: {
                    Text("Go to")
                }
                
                Text("\(count)")
            }

        }
    }
}

struct View_2: View {
    var increase: (Int) -> Void
    var action: (String) -> Void
    var body: some View {
        Button {
            increase(1)
        } label: {
            Label("Increase", systemImage: "save")
        }
        .buttonStyle(.borderedProminent)
        
        Button("Save") {
            action("item saved")
        }

    }
}

struct View_1_Previews: PreviewProvider {
    static var previews: some View {
        View_1()
    }
}






























