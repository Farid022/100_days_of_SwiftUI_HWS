//
//  Practice_parts.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 18/01/2023.
//

import SwiftUI
import UserNotifications
import SamplePackage
//Topics:
/*
 1. Intro: You’ve seen how @State is used to work with state that is local to a single view, and how @ObservedObject lets us pass one object from view to view so we can share it. Well, @EnvironmentObject takes that one step further: we can place an object into the environment so that any child view can automatically have access to it.
 2. EnvironmentObject and Tabview.
 3. Manually publishing ObservableObject changes.
 4. Understanding Swift’s Result type
 5. Context manue. tap and show multiple buttons.
 6. SwipeAction.
 7. Local Notification.
 8. Swift Package Managment. SPM.  https://github.com/twostraws/SamplePackage
 */

@MainActor class Provider: ObservableObject {
    @Published var title = "Cosntant Title"
    @Published var outputs = ""
    
    //Manually publishing ObservableObject changes
    //@Published var value = 0 //we want to observer changes in the struct. what if we make it var instead of Published.
    
    var value = 0 { //gives us same result with some addional features.
        willSet {
            objectWillChange.send() //This lets us send the change notification whenever we want, rather than relying on @Published to do it automatically.  Except this time we have the opportunity to add extra functionality inside that willSet observer. Perhaps you want to log something, perhaps you want to call another method, or perhaps you want to clamp the integer inside value so it never goes outside of a range – it’s all under our control now.
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1            }
        }
    }
    
    init() async {
        await fetchReadings()
    }
    
    //Result: It allows us to encapsulate either a successful value or some kind of error type, all in a single piece of data.
    /*
     1. That code works just fine, but it doesn’t give us a lot of flexibility – what if we want to stash the work away somewhere and do something else while it’s running? What if we want to read its result at some point in the future, perhaps handling any errors somewhere else entirely? Or what if we just want to cancel the work because it’s no longer needed?
     2.  The advantage of Result is that it lets us store the whole success or failure of some work in a single value, pass that around wherever we need, and read the error only when we’re ready.
     */
    
    func fetchReadings() async {
        do {
            guard let url = URL(string: "https://hws.dev/readings.json") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Double].self, from: data)
            outputs = "Found \(decoded.count) readings"
        } catch {
            print("Error")
        }
    }
    
    
    
    func fectch_Readings_R() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(decoded.count) readings"
        }
        
        let result = await fetchTask.result
        
        switch result {
        case .success(let str):
            outputs = str
        case .failure(let error):
            outputs = "\(error)"
        }
    }
    
    
    
    
    //Well, we can get all that by using Result, and it’s actually available through an API you’ve met previously: Task.
    func fetchReadings_R() async {
        //explain:
        /*
         We’ve used Task before to launch pieces of work, but here we’ve given the Task object the name of fetchTask – that’s what gives us the extra flexibility to pass it around, or cancel it if needed. And notice how our Task closure returns a value now? That value gets stored in our Task instance so that we can read it in the future when we’re ready.
         */
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(decoded.count) readings"
        }
        
        let result = await fetchTask.result  //the result or error from a throwing task after it completes
        
        fetchTask.cancel() //it indicate that the task should stope runing.
        //way 1
        do {
            outputs = try result.get() //get the success value as throwing.
        } catch {
            print("Failed to download: \(error.localizedDescription)")
        }
        
        //way 2.
        switch result {
        case .success(let str):
            outputs = str
        case .failure(let error):
            outputs = "\(error)"
        }
    }
    
    
    
    
    
    
    
//    func goGrabSomething() async throws -> MyJsonModel? {
//        var model: MyJsonModel? = nil
//        let ourl = URL(string: "https://mydomain.com/api/v1/getsomejsondata")
//        if let url = ourl {
//            let reg = URLRequest(url: url)
//            let (data, _) = try await URLSession.shared.data(for: req)
//            model = try JSONDecoder ().decode (MyJsonModel.self, from: data)
//        }
//        return model
//    }
    
}

struct Edit_View: View {
    @EnvironmentObject var provider: Provider
    var body: some View {
        TextField("Enter", text: $provider.title)
            .padding()
            .textFieldStyle(.plain)
            .background(.gray)
            .padding()
            .cornerRadius(10)
    }
}

struct DisplayView: View {
    @EnvironmentObject var provider: Provider
        //That @EnvironmentObject property wrapper will automatically look for a User instance in the environment, and place whatever it finds into the user property. If it can’t find a User in the environment your code will just crash, so please be careful.
    var body: some View {
        Text(provider.title)
    }
}

struct Practice_parts: View {
    //1
    //We can now bring those two views together in one place, and send in a User instance for them to work with:
    @StateObject private var provider = Provider()
    
    //2. Tabviews
    @State private var selectedTab = "One" //letting the user switch views by tapping on their tab item,
    //Tip: It’s common to want to use NavigationView and TabView at the same time, but you should be careful: TabView should be the parent view, with the tabs inside it having a NavigationView as necessary, rather than the other way around.
    
    //5. Context manue
    @State private var backGround: Color = .red
    
    
    //8. SPM -> SamplePackage
    //For example, we could simulate a simple lottery by making a range of numbers from 1 through 60, picking 7 of them, converting them to strings, then joining them into a single string.
    let possiblesNubers = Array(1...60)
    //A coputed property which return string. It picks seven numbers from there and makes them into a single string.
    var results: String {
        //select seven random numbers from our range
        let selectedNumbers = possiblesNubers.random(7).sorted() //random(pickedNumbers by samplePackage.
        
        //convert that array of integers into strings. map() method that lets us convert an array of one type into an array of another type by applying a function to each element.
        let strings = selectedNumbers.map(String.init) //stringify them
        
        //join them all together with commas in between
        return strings.joined(separator: ", ")
    }
    
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                NavigationView {
                    VStack {
                        DisplayView()
                        Edit_View()
                        NavigationLink {
                            //For situations just like this one, SwiftUI gives us the interpolation() modifier that lets us control how pixel blending is applied.
                            Image("example")
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: .infinity)
                                .background(.black)
                                .ignoresSafeArea()
                                
                        } label: {
                            Text("jump")
                                .font(.title2).bold()
                                .padding()
                                .background(.green)
                                .cornerRadius(10)
                        }
                        
                        //Manually publishing ObservableObject changes
                        Text("Value is \(provider.value)")
                        
                        //Result.
                        Text("fetched: \(provider.outputs)")
                        
                        //Context menue.
                        Text("Change Color")
                            .padding()
                            .background(backGround)
                            .cornerRadius(10)
                            .contextMenu {
                                Button("Green", action: { backGround = .green})
                                Button("Purple", action: { backGround = .purple})
                                Button("Blue", action: { backGround = .blue})
                                
                                Button(role: .destructive) {
                                    backGround = .yellow
                                } label: {
                                    Label("Yellow", systemImage: "checkmark.circle")
                                }
                                //.foregroundColor(.red) //this will not work.
                            }
                        
                        //swipeActions
                        List {
                            Text("Swipe to delete")
                                .swipeActions {
                                    Button(role: .destructive) {
                                        
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    Button("Simple") {
                                        //
                                    }
                                    Button("Edit") {
                                        //
                                    }
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        //
                                    } label: {
                                        Label("Pin", systemImage: "pin.fill")
                                    }
                                }
                        }.frame(height: 100)
                        
                        //Local Notifications
                        VStack {
                            Button("Request permission") {
                                UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert]) { success, error in
                                    if success {
                                        print("All set up")
                                    } else if let error = error {
                                        print("Failed to set Up the notification!: \(error)")
                                    }
                                }
                            }.buttonStyle(.borderedProminent)
                            
                            Button("Schedule Notitification") {
                                //steps:
                                /*
                                 1. Content: sounds, badges, title, images etc.
                                 2. the trigger: when should be happend, when should be shown...
                                 3. The request combines the content and trigger, but also adds a unique identifier so you can edit or remove specific alerts later on. If you don’t want to edit or remove stuff, use UUID().uuidString to get a random identifier.
                                 */
                                let content = UNMutableNotificationContent()
                                content.title = "Go to gym!"
                                content.subtitle = "It is Bicep day, you should not miss it!"
                                content.sound = UNNotificationSound.default
                                
                                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                                
                                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                
                                //add it finaly
                                UNUserNotificationCenter.current().add(request)
                                
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        
                        
                        //SamplePackage. SPM
                        Text(results)
                        
                    }.task {
                       await provider.fetchReadings()
                    }
                }
                .tabItem {
                    Label("One", systemImage: "house")
                }
//                .onTapGesture {
//                    selectedTab = "Two"
//                } //letting the user switch views by tapping on their tab item,
                .tag("One")
                    
                NavigationView {
                    NavigationLink {
                        Text("Helll")
                    } label: {
                        Text("Nhhd")
                    }

                }
                .tabItem {
                        Label("Two", systemImage: "person")
                    }
                    .tag("Two")
//                    .onTapGesture {
//                        selectedTab = "One"
//                    }
            }
            .environmentObject(provider)
        }
    }
}

struct Practice_parts_Previews: PreviewProvider {
    static var previews: some View {
        Practice_parts()
    }
}

