//
//  Project7_iExpense.swift
//  WeSplit
//
//  Created by Muhammad Farid Ullah on 21/11/2022.
//

import SwiftUI

//Topics: Stateobject, ObservableObject, Published, observedObject.
/*
 @Published publishes change announcements automatically.
 @StateObject watches for those announcements and refreshes any views using the object.
 sheet() watches a condition we specify and shows or hides a view automatically.
 Codable can convert Swift objects into JSON and back with almost no code from us.
 UserDefaults can read and write data so that we can save settings and more instantly.
 
 1. The Codable protocol, which will allow us to archive all the existing expense items ready to be stored.
 2. UserDefaults, which will let us save and load that archived data.
 3. A custom initializer for the Expenses class, so that when we make an instance of it we load any saved data from UserDefaults
 A didSet property observer on the items property of Expenses, so that whenever an item gets added or removed we’ll write out changes.
 
 */
//if struct -> works well
class User: ObservableObject {//the @StateObject property wrapper can only be used on types that conform to the ObservableObject protocol. This protocol has no requirements, and really all it means is “we want other things to be able to monitor this for changes.”
    
    
    //it tells Swift that whenever either of those two properties changes, it should send an announcement out to any SwiftUI views that are watching that they should reload.
   @Published var name: String = "Farid"
   @Published var fname: String = "Mehmood"
}
struct UserrView: View {
    //How do those views know which classes might send out these notifications? by stateobject
    //it tells SwiftUI that we’re creating a new class instance that should be watched for any change announcements.
        @StateObject var user = User()
    // @StateObject tells SwiftUI that we’re creating a new class instance that should be watched for any change announcements
    
    @State var showSheet = false
    @Environment(\.dismiss) var dismisso
        var body: some View {
            VStack {
                Text("Name is: \(user.name)")
                TextField("Enter your name", text: $user.name)
                    .padding()
                
                Button("Show bottom sheet") {
                    showSheet.toggle()
                }
            }.sheet(isPresented: $showSheet) {
                SecondView_sheet()
            }
        }
}


struct SecondView_sheet: View {
    @Environment(\.dismiss) var dissmiso
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State var tapCount = UserDefaults.standard.integer(forKey: "tapkey") //set key for the intValue
    @AppStorage("myname") var myname = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Button {
                            dissmiso()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        
                        Spacer()
                    }.padding()
                    
                    List {
                        ForEach(numbers, id: \.self) { num in
                            Text("Row \(num)")
                        }.onDelete(perform: removeNumber)
                    }
                    
                    Button("Add a number") {
                        numbers.append(currentNumber)
                        currentNumber += 1
                    }
                    
                    Spacer()
                }
                
                Text("\(tapCount)")
                Text("\(myname)")
                
                Button("TapCount") {
                    tapCount += 1
                    myname = "Farid Khan"
                    UserDefaults.standard.set(tapCount, forKey: "tapkey")
                    //when being taped, then save into tapKey
                }
                
            }
            .navigationTitle("OnDelete Method")
            .toolbar {
                EditButton()
            }
        }
    }
    
    func removeNumber(removeAt: IndexSet) {
        numbers.remove(atOffsets: removeAt)
    }
}
